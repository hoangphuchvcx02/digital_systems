module ALU(
	input clk_i,
	input [7:0] A,
	input [7:0] B,
	input [2:0] Sel,
	output reg [16:0] Result
);

	always @(posedge clk_i) begin
		if (Sel == 3'b000) 
			Result = {1'b0,A} + {1'b0,B};
		if (Sel == 3'b001) 
			Result = {1'b0,A} - {1'b0,B};
		if (Sel == 3'b010) 
			Result = {1'b0,A} * {1'b0,B};
	end
	
endmodule 
			