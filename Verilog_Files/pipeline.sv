module pipeline(
input clk,
input reset,

input pushin,
input [4:0][4:0][63:0]din,

output reg pushout,
output reg [4:0][4:0][63:0]Q
);

always @(posedge clk, posedge reset) begin

    if(reset) begin
        pushout <= 0;
        Q <= 0;
    end
    else begin
        pushout <= #1 pushin;
        Q <= din;
    end

end

endmodule
