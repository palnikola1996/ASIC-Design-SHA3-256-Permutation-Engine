module pie(
input [4:0][4:0][63:0]rho,
output reg [4:0][4:0][63:0]pie
);
parameter X = 5;
parameter Y = 5;
parameter Z = 64;

integer x,y,z;

always @(*) begin
    for(x=0;x<X;x=x+1)begin
        for(y=0;y<Y;y=y+1)begin
            for(z=0;z<Z;z=z+1)begin
                pie[x][y][z] = rho[x_plus_y_mod_5(x,3*y)][x][z];
            end
        end
    end
end
`include "./mod_functions.sv"
endmodule
