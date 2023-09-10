module lab1_2(
	input clk_sys, rst_sys,
	input [7:0] A,
	output [7:0] Result
);	

	wire [7:0] reg2addsub1;
	wire [7:0] reg2addsub2;
	wire [7:0] Pout;
	wire [7:0] addsub2reg;
	
	assign Result = Pout;
	
	register r1(
		.rst_n(rst_sys),
		.clk_i(clk_sys),
		.data_in(A),
		.data_out(reg2addsub1)
	);
	
	
	add_subtract a0(
		.clk_i(clk_sys),
		.A(reg2addsub1),
		.B(Pout),
		.Result(addsub2reg)
	);

	register r2(
		.rst_n(rst_sys),
		.clk_i(clk_sys),
		.data_in(addsub2reg),
		.data_out(Pout)
	);
	
endmodule 