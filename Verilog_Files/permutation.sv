module permutation(
input [4:0][4:0][63:0]A,
input [63:0]RC,
output [4:0][4:0][63:0]Iota
);

wire [4:0][4:0][63:0]Theta;
wire [4:0][4:0][63:0]Rho;
wire [4:0][4:0][63:0]Pie;
wire [4:0][4:0][63:0]Chi;

theta   dut1_00(        .A(A),.theta(Theta)            );
rho     dut2_00(.theta(Theta),  .rho(  Rho)            );
pie     dut3_00(  .rho(  Rho),  .pie(  Pie)            );
chi     dut4_00(  .pie(  Pie),  .chi(  Chi)            );
iota    dut5_00(  .chi(  Chi), .iota( Iota) ,.rc(RC)   );

endmodule
