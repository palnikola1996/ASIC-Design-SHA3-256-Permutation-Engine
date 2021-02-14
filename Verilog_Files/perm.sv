module perm(
input clk, 
input reset, 

input [2:0] dix,
input [199:0] din,
input pushin, 

output [2:0] doutix, 
output [199:0]dout,
output pushout
);

`include "./param.svh"

wire [4:0][4:0][63:0]Iota_00;   wire [4:0][4:0][63:0]Iota_03;   wire [4:0][4:0][63:0]Iota_06;   wire [4:0][4:0][63:0]Iota_09;
wire [4:0][4:0][63:0]Iota_01;   wire [4:0][4:0][63:0]Iota_04;   wire [4:0][4:0][63:0]Iota_07;   wire [4:0][4:0][63:0]Iota_10;
wire [4:0][4:0][63:0]Iota_02;   wire [4:0][4:0][63:0]Iota_05;   wire [4:0][4:0][63:0]Iota_08;   wire [4:0][4:0][63:0]Iota_11;
                                                                                                
wire [4:0][4:0][63:0]Iota_12;   wire [4:0][4:0][63:0]Iota_15;   wire [4:0][4:0][63:0]Iota_18;   wire [4:0][4:0][63:0]Iota_21;
wire [4:0][4:0][63:0]Iota_13;   wire [4:0][4:0][63:0]Iota_16;   wire [4:0][4:0][63:0]Iota_19;   wire [4:0][4:0][63:0]Iota_22;
wire [4:0][4:0][63:0]Iota_14;   wire [4:0][4:0][63:0]Iota_17;   wire [4:0][4:0][63:0]Iota_20;   wire [4:0][4:0][63:0]Iota_23;


wire pushout_str2ary;
wire [4:0][4:0][63:0]A;

wire [4:0][4:0][63:0]din_l0, din_l1, din_l2, din_l3, din_l4, din_l5, din_l6, din_l7;
wire p0,p1,p2,p3,p4,p5,p6,p7;

string2array str2ary (.clk(clk), .reset(reset), .pushin(pushin), .dix(dix), .din(din), .pushout(pushout_str2ary), .A(A));

permutation round_00 (      .A(A), .RC(RC_00) , .Iota(Iota_00));
permutation round_01 (.A(Iota_00), .RC(RC_01) , .Iota(Iota_01));
permutation round_02 (.A(Iota_01), .RC(RC_02) , .Iota(Iota_02));

pipeline      level0 (.clk(clk), .reset(reset), .pushin(pushout_str2ary), .din(Iota_02), .pushout(p0),.Q(din_l0));

permutation round_03 ( .A(din_l0), .RC(RC_03) , .Iota(Iota_03));
permutation round_04 (.A(Iota_03), .RC(RC_04) , .Iota(Iota_04));
permutation round_05 (.A(Iota_04), .RC(RC_05) , .Iota(Iota_05));

pipeline      level1 (.clk(clk), .reset(reset), .pushin(p0), .din(Iota_05), .pushout(p1), .Q(din_l1));

permutation round_06 ( .A(din_l1), .RC(RC_06) , .Iota(Iota_06));
permutation round_07 (.A(Iota_06), .RC(RC_07) , .Iota(Iota_07));
permutation round_08 (.A(Iota_07), .RC(RC_08) , .Iota(Iota_08));

pipeline      level2 (.clk(clk), .reset(reset), .pushin(p1), .din(Iota_08), .pushout(p2), .Q(din_l2));

permutation round_09 ( .A(din_l2), .RC(RC_09) , .Iota(Iota_09));
permutation round_10 (.A(Iota_09), .RC(RC_10) , .Iota(Iota_10));
permutation round_11 (.A(Iota_10), .RC(RC_11) , .Iota(Iota_11));

pipeline      level3 (.clk(clk), .reset(reset), .pushin(p2), .din(Iota_11), .pushout(p3), .Q(din_l3));

permutation round_12 ( .A(din_l3), .RC(RC_12) , .Iota(Iota_12));
permutation round_13 (.A(Iota_12), .RC(RC_13) , .Iota(Iota_13));
permutation round_14 (.A(Iota_13), .RC(RC_14) , .Iota(Iota_14));

pipeline      level4 (.clk(clk), .reset(reset), .pushin(p3), .din(Iota_14), .pushout(p4), .Q(din_l4));

permutation round_15 ( .A(din_l4), .RC(RC_15) , .Iota(Iota_15));
permutation round_16 (.A(Iota_15), .RC(RC_16) , .Iota(Iota_16));
permutation round_17 (.A(Iota_16), .RC(RC_17) , .Iota(Iota_17));

pipeline      level5 (.clk(clk), .reset(reset), .pushin(p4), .din(Iota_17), .pushout(p5), .Q(din_l5));

permutation round_18 ( .A(din_l5), .RC(RC_18) , .Iota(Iota_18));
permutation round_19 (.A(Iota_18), .RC(RC_19) , .Iota(Iota_19));
permutation round_20 (.A(Iota_19), .RC(RC_20) , .Iota(Iota_20));

pipeline      level6 (.clk(clk), .reset(reset), .pushin(p5), .din(Iota_20), .pushout(p6), .Q(din_l6));

permutation round_21 ( .A(din_l6), .RC(RC_21) , .Iota(Iota_21));
permutation round_22 (.A(Iota_21), .RC(RC_22) , .Iota(Iota_22));
permutation round_23 (.A(Iota_22), .RC(RC_23) , .Iota(Iota_23));

pipeline      level7 (.clk(clk), .reset(reset), .pushin(p6), .din(Iota_23), .pushout(p7), .Q(din_l7));

array2string ary2str (.clk(clk), .reset(reset), .pushin(p7), .din(din_l7), .pushout(pushout), .doutix(doutix), .dout(dout));

endmodule
`include "./my_pkg.sv"
