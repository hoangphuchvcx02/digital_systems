module expfract(
input [5:0] mag_f,
input [3:0] bigger_ex,
output [3:0] result_ex, result_f,
output OV
);

always_ff begin
	if (mag_f[5] == 1) begin
		if (bigger_ex <= 14) begin
			result_ex <= bigger_ex + 1;
			result_f <= mag_f[4:1];
			OV <= 1'b0;
			end
		else begin
			OV <= 1'b1;
			result_ex <= 4'b1111;
			result_f <= 4'b1111;
			end
		end
	else if (mag_f[4] == 1) begin
		result_ex <= bigger_ex;
		result_f <= mag_f[3:0];
		OV <= 1'b0;
		end
	else if (mag_f[3] == 1) begin
		if (bigger_ex >= 1) begin
			result_ex <= bigger_ex - 1;
			result_f <= {mag_f[2:0] , 1'b0};
			OV <= 1'b0;
			end
		else begin
			OV <= 1'b1;
			result_ex <= 4'b1111;
			result_f <= 4'b1111;
			end
		end
	else if (mag_f[2] == 1) begin
		if (bigger_ex >= 2) begin
			result_ex <= bigger_ex - 2;
			result_f <= {mag_f[1:0] , 2'b0};
			OV <= 1'b0;
			end
		else begin
			OV <= 1'b1;
			result_ex <= 4'b1111;
			result_f <= 4'b1111;
			end
		end
	else if (mag_f[1] == 1) begin
		if (bigger_ex >= 3) begin
			result_ex <= bigger_ex - 3;
			result_f <= {mag_f[0] , 3'b0};
			OV <= 1'b0;
			end
		else begin
			OV <= 1'b1;
			result_ex <= 4'b1111;
			result_f <= 4'b1111;
			end
		end
	else if (mag_f[0] == 1) begin
		if (bigger_ex >= 4) begin
			result_ex <= bigger_ex - 4;
			result_f <= 4'b0;
			OV <= 1'b0;
			end
		else begin
			OV <= 1'b1;
			result_ex <= 4'b1111;
			result_f <= 4'b1111;
			end
		end
	else begin
		OV <= 1'b0;
		result_ex <= 4'b0000;
		result_f <= 4'b0000;
		end
	end

endmodule

			