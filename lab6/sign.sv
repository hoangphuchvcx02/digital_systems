module sign(
input [4:0] diff_ex, diff_f,
input A_s, B_s, S,
output result_s
);


always_comb begin
	if (S == 0) begin
		if (diff_ex == 0) begin
			if (diff_f[4] == 0) result_s <= A_s;
			else result_s <= B_s;
			end
		else if (diff_ex[4] == 0) result_s <= A_s;
		else result_s <= B_s;
	end
	
	else begin
		if (diff_ex == 0) begin
			if (diff_f[4] == 0) result_s <= A_s;
			else result_s <= ~B_s;
			end
		else if (diff_ex[4] == 0) result_s <= A_s;
		else result_s <= ~B_s;
	end
end
	
endmodule