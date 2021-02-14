module string2array(
input clk,
input reset,

input pushin,
input [2:0]dix,
input [199:0]din,

output reg pushout,
output reg [4:0][4:0][63:0]A
);

parameter X = 5;
parameter Y = 5;
parameter Z = 64;

integer x,y,z;

reg Push;
reg [1599:0]Sin;

always @(posedge clk, posedge reset) begin
    if(reset) begin
        Push <= 0;
        Sin  <= 0;
    end
    else begin
        if(pushin) begin
            Sin <= #1 {din,Sin[1599:200]};
        end
        else begin
            Sin <= Sin;
        end

        if(dix == 3'd7) begin
            Push <= #1 pushin;
        end
        else begin
            Push <= 0;
        end
    end
end


always @(*) begin

    pushout = Push;
    
    for(x=0;x<X;x=x+1) begin
        for(y=0;y<Y;y=y+1) begin
            for(z=0;z<Z;z=z+1) begin
                A[x][y][z] = Sin[Z*(Y*y+x)+z];
            end
        end
    end
end

endmodule
