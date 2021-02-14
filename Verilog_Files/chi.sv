module chi(
input [4:0][4:0][63:0]pie,
output reg [4:0][4:0][63:0]chi
);
parameter X = 5;
parameter Y = 5;
parameter Z = 64;

integer x,y,z;

always @(*) begin
    for(x=0;x<X;x=x+1)begin
        for(y=0;y<Y;y=y+1)begin
            for(z=0;z<Z;z=z+1)begin
                chi[x][y][z] = pie[x][y][z]^((pie[x_plus_y_mod_5(x,1)][y][z]^1)&(pie[x_plus_y_mod_5(x,2)][y][z]));
            end
        end
    end
end
`include "./mod_functions.sv"
endmodule
