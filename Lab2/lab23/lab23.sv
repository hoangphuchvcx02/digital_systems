module lab23(
input clk,
input rst_n,
input data_in,
output z
);


wire [3:0] reg2logicA;
wire [3:0] reg2logicB;

reg8bit r1(
	.clk(clk),
	.rst_n(rst_n),
	.data_in(data_in),
	.z(reg2logicA)
);
	
reg8bit r2(
	.clk(clk),
	.rst_n(rst_n),
	.data_in(data_in),
	.z(reg2logicB)
);
	
	
always @(*) begin
  z = (reg2logicA == 4'b1111) || (reg2logicB == 4'b0000);
end
endmodule
