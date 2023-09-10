module FA(
	input  A,B,
	input Cin,
	output  S,
	output Cout,
	output V
);
	assign S = A^B^Cin;
	assign Cout = (A&B) | (B&Cin) | (Cin&A);
endmodule


