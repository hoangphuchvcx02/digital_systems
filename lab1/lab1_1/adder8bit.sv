module adder8bit(
	input [7:0] A,B,
	input Cin,
	output [7:0] S,
	output Cout,
	output V
);

	wire c0,c1,c2,c3,c4,c5,c6,c7;

FA a0(
	.A(A[0]),
	.B(B[0]),
	.Cin(Cin),
	.S(S[0]),
	.Cout(c0)
);

FA a1(
	.A(A[1]),
	.B(B[1]),
	.Cin(c0),
	.S(S[1]),
	.Cout(c1)
);
FA a2(
	.A(A[2]),
	.B(B[2]),
	.Cin(c1),
	.S(S[2]),
	.Cout(c2)
);
FA a3(
	.A(A[3]),
	.B(B[3]),
	.Cin(c2),
	.S(S[3]),
	.Cout(c3)
);
FA a4(
	.A(A[4]),
	.B(B[4]),
	.Cin(c3),
	.S(S[4]),
	.Cout(c4)
);
FA a5(
	.A(A[5]),
	.B(B[5]),
	.Cin(c4),
	.S(S[5]),
	.Cout(c5)
);
FA a6(
	.A(A[6]),
	.B(B[6]),
	.Cin(c5),
	.S(S[6]),
	.Cout(c6)
);
FA a7(
	.A(A[7]),
	.B(B[7]),
	.Cin(c6),
	.S(S[7]),
	.Cout(c7)
);

	
	assign V = c6^c7;
	
endmodule


