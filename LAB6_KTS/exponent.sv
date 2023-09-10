module exponent(
input [3:0] A_ex, B_ex,
output [3:0] bigger_ex,
output [4:0] diff_ex
);

assign diff_ex = A_ex - B_ex;

always_comb begin
	if (diff_ex[4] == 0) 
		bigger_ex <= A_ex;
	else 
		bigger_ex <= B_ex;
end

endmodule