module fraction(
input [3:0] A_f, B_f,
input [4:0] diff_ex,
output [3:0] bigger_f, smaller_f,
output [4:0] diff_f
);

assign diff_f = A_f - B_f;

always_comb begin
	if (diff_ex == 0) begin			//Exp_A = Exp_B
		if (diff_f[4] ==  0) begin
			bigger_f <= A_f;
			smaller_f <= B_f;
		end	
		else begin
			bigger_f <= B_f;
			smaller_f <= A_f;
		end
	end
	
	else begin								//Exp_A <> Exp_B
		if (diff_ex[4] == 0) begin
			bigger_f <= A_f;
			smaller_f <= B_f;
		end
		else begin
			bigger_f <= B_f;
			smaller_f <= A_f;
		end
	end
end

endmodule