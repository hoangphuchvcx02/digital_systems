module result(
input [8:0] A, B,
input result_s, S,
input [3:0] result_ex, result_f,
output Z,
output [8:0] result
);

always_comb begin
	if ((A[7:0] == B[7:0] && A[8] != B[8] && S == 0) | (A[8:0] == B[8:0] && S == 1)) begin
		Z <= 1'b1;
		result <= '0;
		end
	else begin
		Z <= 1'b0;
		result <= {result_s, result_ex, result_f};
		end
end

endmodule