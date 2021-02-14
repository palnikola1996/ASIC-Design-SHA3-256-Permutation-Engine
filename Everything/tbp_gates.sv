// This is a simple test bench for the permutation block
//
`timescale 1ns/10ps

`include "perm_gates.v"

module top();
reg clk,reset;
reg pushin;
reg [199:0] din;
reg [2:0] dix;	// data index for 1600 bits
wire pushout;
reg pushoutH;
wire [2:0] doutix;
reg [2:0] doutixH;
wire [199:0] dout;
reg [199:0] doutH;

typedef struct packed {
	reg [3:0] ix;
	reg [199:0] dat;
} DD;

int picnt=20;
int tlimit=40;
int damt;

DD fifoout[$];
DD dd_exp;

task die(input string msg);
	$display("\n\n\n- - - - - - - - - - - Error - - - - - - - - - -");
	$display("  at %8.1fns",$realtime/10);
	$display("  %s",msg);
	$display("- - - - - - - - - - - Error - - - - - - - - - -\n\n\n");
	#10;
	$finish;
endtask : die

task push_out(reg [2:0] dix,reg [199:0] dat);
	DD di;
	di.ix=dix;
	di.dat=dat;
	fifoout.push_back(di);
endtask : push_out

task push_in(reg [2:0] dixx,reg [199:0] datx);
	pushin=1;
	dix=dixx;
	din=datx;
	@(posedge(clk)) #1
	pushin=0;
	dix=$urandom_range(0,7);
	din=$urandom_range(0,32'hffff_ffff);
	if(picnt>0) begin
		picnt-=1;
	end else begin
		repeat($urandom_range(2,0)) @(posedge(clk)) #1;
	end
endtask : push_in


initial begin
    clk=1;
    repeat(100000) begin
        #5 clk=~clk;
        #5 clk=~clk;
    end
    $display("ran out of clocks");
    $finish;
end

initial begin
    reset=1;
    repeat(3) @(posedge(clk)) #1;
    reset=0;
end

function string diff(input reg[199:0] a, input reg[199:0] b);
	string rv;
	reg [199:0] delta;
	delta=a^b;
	rv="";
	for(int ix=0; ix < 50; ix+=1) begin
		if(delta[199:196]!=0) rv={rv,"^"}; else rv={rv," "};
		delta <<= 4;
	end
	return rv;
endfunction : diff

always @(posedge(clk)) begin
	if(!reset) begin
		if(pushout===1'bx) die("Pushout is an X");
		if(^dout===1'bx) die("dout has an X");
		if(^doutix===1'bx) die("doutix has an X");
		if(pushout === 1'b1) begin
			if(fifoout.size() > 0) begin
				dd_exp=fifoout.pop_front();
				if(dd_exp.ix !== doutix) begin
					die($sformatf("doutix wrong, got %1d, expected %1d",
						doutix,dd_exp.ix));
				end
				if(dd_exp.dat !== dout) begin
					die($sformatf("dout wrong, got %050h\n  expected        %050h\n                  %s",
						dout,dd_exp.dat,diff(dout,dd_exp.dat)));
				end
				
			end else begin
				die("You pushed, and nothing was expected");
			end
		end
		pushoutH=pushout;
		doutH=dout;
		doutixH=doutix;
		#0.1;
		if(pushoutH !== pushout) die("No hold time on pushout");
		if(doutH !== dout) die("No hold time on dout");
		if(doutixH !== doutix) die("No hold time on doutix");
		
	end
end



initial begin
    string line;
    int fi;
    int junk;
    pushin=0;
    din=64'h12345678abcdef0;
    dix=0;
    repeat(5) @(posedge(clk))#1;
    pushin=0;
    fi=$fopen("sha3_tests.txt","r");
    while(!$feof(fi)) begin
		junk=$fgets(line,fi);
		if(line.len()<2) continue;
		case(line[0])
			"#": continue;
			"i": begin
				junk=$sscanf(line,"%*c %d %x",dix,din);
				push_in(dix,din);
			end
			"o": begin
				junk=$sscanf(line,"%*c %d %x",dix,din);
				push_out(dix,din);
				if(dix==7) begin
					tlimit -=1;
					if(tlimit < 0) begin
						repeat(100) @(posedge(clk)) #1;
						if(fifoout.size()>0) begin
							die($sformatf("not all data pushed out in 100 clocks\n    %d items left",fifoout.size()));
						end else begin
							$display("\n\n\nOh what joy, you passed the test\n\n\n");
						end
						$finish;
					end
				end
			end
			"e":  begin
				repeat(100) @(posedge(clk))#1;
				if(fifoout.size()>0) begin
					die($sformatf("not all data pushed out in 100 clocks\n    %d items left",fifoout.size()));
				end else begin
					$display("\n\n\nOh what joy, you passed the test\n\n\n");
				end
				$finish;
			end
			default: begin
				$display("You didn't handle line correctly\n%s\n",line);
			end
		endcase
    end
    $fclose(fi);
end

perm p(clk,reset,dix[2:0],din,pushin,doutix,dout,pushout);

/*initial begin
    $dumpfile("perm.vcd");
    $dumpvars(9,top);
    repeat(18) @(posedge(clk));
    $dumpoff;

end*/

endmodule : top
