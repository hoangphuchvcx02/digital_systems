module lab1_1(
	input [7:0] A,
	input CLK_system,
	input rst_n_system,
	output [7:0] S,
	output Cout,
	output V
);

wire [7:0]reg2adder1;
wire [7:0]reg2adder2;
wire [7:0]adder2reg;
wire ca;
wire ov;

assign S = adder2reg ;
register r0(
 .rst_n(rst_n_system),
	 .clk_i(CLK_system),
	 .data_in(A),
	.data_out(reg2adder)
);
register r1(
 .rst_n(rst_n_system),
	 .clk_i(CLK_system),
	 .data_in(adder2reg),
	.data_out(reg2adder2)
);
 adder8bit add0(
	 .A(reg2adder),
	 .B(reg2adder2),
	 .Cin(1'b0),
	 .S(adder2reg),
	 .Cout(ca),
	 .V(ov)
);
 D_flipflop D0(
	 .clk_i(CLK_system),
	 .rst_n(rst_n_system),
	 .D(ov),
	 .Q(V)
);
 D_flipflop D1(
	 .clk_i(CLK_system),
	 .rst_n(rst_n_system),
	 .D(ca),
	 .Q(Cout)
);

endmodule 