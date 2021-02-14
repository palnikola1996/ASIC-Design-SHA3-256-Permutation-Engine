module theta(
input [4:0][4:0][63:0]A,
output reg [4:0][4:0][63:0]theta
);
parameter X = 5;
parameter Y = 5;
parameter Z = 64;

reg [4:0][63:0]C;
reg [4:0][63:0]D;

integer x,y,z;

always @(*) begin
    
    for(x=0;x<X;x=x+1)begin
        for(z=0;z<Z;z=z+1)begin
            C[x][z] = A[x][0][z]^A[x][1][z]^A[x][2][z]^A[x][3][z]^A[x][4][z];
        end
    end
    for(x=0;x<X;x=x+1)begin
        for(z=0;z<Z;z=z+1)begin
    		D[x][z] = C[dividend_minus_1_mod_divisor(x,X)][z]^C[x_plus_y_mod_5(x,5'd1)][dividend_minus_1_mod_divisor(z,Z)];
        end
    end
    
    for(x=0;x<X;x=x+1)begin
        for(y=0;y<Y;y=y+1)begin
            //for(z=0;z<Z;z=z+1)begin
                theta[x][y] = A[x][y]^D[x];
            //end
        end
    end

end
`include "./mod_functions.sv"
endmodule
