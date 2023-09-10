module addsub_f(
input A_s, B_s, S,
input [5:0] shifted_f, sixbitbigger_f,
output [5:0] mag_f
);

logic equal;

assign equal = A_s ~^ B_s;

always_comb begin
	if (equal == 1) begin
		if (equal == 1)
			mag_f <= sixbitbigger_f - shifted_f;
		else
			mag_f <= sixbitbigger_f + shifted_f;
		end
	else begin
		if (equal == 1)
			mag_f <= sixbitbigger_f + shifted_f;
		else
			mag_f <= sixbitbigger_f - shifted_f;
		end
end

endmodule
 
		
	