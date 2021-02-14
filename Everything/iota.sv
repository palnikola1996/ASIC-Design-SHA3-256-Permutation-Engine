module iota(
input [4:0][4:0][63:0]chi,
input [63:0]rc,
output reg [4:0][4:0][63:0]iota
);
parameter X = 5;
parameter Y = 5;
parameter Z = 64;

integer x,y,z;

always @(*) begin
    for(x=0;x<X;x=x+1)begin
        for(y=0;y<Y;y=y+1)begin
            for(z=0;z<Z;z=z+1)begin
                if(x==0 && y==0)
                  iota[x][y][z] = chi[x][y][z]^rc[z];
                else
                  iota[x][y][z] = chi[x][y][z];
            end
        end
    end
end
endmodule
