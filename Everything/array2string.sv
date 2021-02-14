module array2string(
input clk,
input reset,

input pushin,
input [4:0][4:0][63:0]din,

output reg pushout,
output reg [2:0]doutix,
output reg [199:0]dout
);

parameter X = 5;
parameter Y = 5;
parameter Z = 64;

integer x,y,z;

reg [7:0]Push;
reg [23:0]Dix;
reg [1599:0]Sin,S;

always @(*) begin
    for(x=0;x<X;x=x+1) begin
        for(y=0;y<Y;y=y+1) begin
            for(z=0;z<Z;z=z+1) begin
                S[Z*(Y*y+x)+z] = din[x][y][z];
            end
        end
    end
end

always @(posedge clk, posedge reset) begin
    if(reset) begin
        Push <= 0;
        Dix  <= 0;
        Sin  <= 0;
    end
    else begin
        
        if(pushin) begin
            Push <= #1 8'hFF ;
            Dix <= #1 {3'd7,3'd6,3'd5,3'd4,3'd3,3'd2,3'd1,3'd0};
            Sin <= #1 S;
        end
        else begin
            Push <= #1 {Push[6:0],pushin};
            Dix <= #1 {3'b0,Dix[23:3]};
            Sin <= #1 {200'b0,Sin[1599:200]};
        end
    end
end

always @(*) begin
    pushout = Push[7];
    doutix = Dix[2:0];
    dout   = Sin[199:0]; 
end


endmodule
