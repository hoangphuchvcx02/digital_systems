module lab1_4(
	input clk_sys, rst_sys,
	input [7:0] A,
	input [7:0] B,
	input EA, EB, EC,
	output reg [16:0] P
);

	wire [7:0] reg2alu1;
	wire [7:0] reg2alu2;
	wire [7:0] alu2reg;
	wire [16:0] Pout;
	
	assign P = Pout;
	
	register r1(
		.clk_i(clk_sys),
		.rst_n(rst_sys),
		.ea(EA),
		.D(A),
		.Q(reg2alu1)
	);
	
	register r2(
		.clk_i(clk_sys),
		.rst_n(rst_sys),
		.ea(EB),
		.D(B),
		.Q(reg2alu2)
	);	
	
	ALU alu0(
		.clk_i(clk_sys),
		.A(reg2alu1),
		.B(reg2alu2),
		.Result(alu2reg)
	);
	
	register r3(
		.clk_i(clk_sys),
		.rst_n(rst_sys),
		.ea(EC),
		.D(alu2reg),
		.Q(Pout)
	);
	
endmodule
	
	