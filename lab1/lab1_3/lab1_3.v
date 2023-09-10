module lab1_3(
	input clk_system, rst_system,
	input EA, EB,
	input [7:0] A,
	input [7:0] B,
	output [15:0] P
);
	wire [7:0] reg2mult1;
	wire [7:0] reg2mult2;
	wire [15:0] mult2reg;
	wire [15:0] result;
	
	assign P = result;
	
	register1 r1(
		.clk_i(clk_system),
		.rst_n(rst_system),
		.ea(EA),
		.D(A),
		.Q(reg2mult1)
	);
	
	register1 r2(
		.clk_i(clk_system),
		.rst_n(rst_system),
		.ea(EB),
		.D(B),
		.Q(reg2mult2)
	);
	
	multiplier mult(
		.clk_i(clk_system),
		.A(reg2mult1),
		.B(reg2mult2),
		.P(mult2reg)
	);
	
	register2 r3(
		.clk_i(clk_system),
		.rst_n(rst_system),
		.D(mult2reg),
		.Q(result)
	);
	
endmodule 