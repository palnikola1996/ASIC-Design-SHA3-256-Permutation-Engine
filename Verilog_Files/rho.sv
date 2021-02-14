module rho(
input [4:0][4:0][63:0]theta,
output reg [4:0][4:0][63:0]rho
);
parameter X = 5;
parameter Y = 5;
parameter Z = 64;

integer x,y,z;

reg [8:0]offset[0:4][0:4];

always @(*) begin
   
    offset[3][2] = 153;    offset[4][2] = 231;   offset[0][2] = 3  ;    offset[1][2] = 10 ;    offset[2][2] = 171;
    offset[3][1] = 55 ;    offset[4][1] = 276;   offset[0][1] = 36 ;    offset[1][1] = 300;    offset[2][1] = 6  ;
    offset[3][0] = 28 ;    offset[4][0] = 91 ;   offset[0][0] = 0  ;    offset[1][0] = 1  ;    offset[2][0] = 190;
    offset[3][4] = 120;    offset[4][4] = 78 ;   offset[0][4] = 210;    offset[1][4] = 66 ;    offset[2][4] = 253;
    offset[3][3] = 21 ;    offset[4][3] = 136;   offset[0][3] = 105;    offset[1][3] = 45 ;    offset[2][3] = 15 ;

    for(x=0;x<X;x=x+1)begin
        for(y=0;y<Y;y=y+1)begin
            for(z=0;z<Z;z=z+1)begin
                rho[x][y][z] = theta[x][y][x_minus_y_mod_64(z,offset[x][y])];
            end
        end
    end
end
`include "./mod_functions.sv"
endmodule
