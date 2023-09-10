module multiplier (
	input clk_i,
	input [7:0] A,
	input [7:0] B,
	output reg [15:0] P
);
	
	always @(posedge clk_i) begin
		 P = {8'b00000000,A}*{8'b00000000,B};
	end
	
endmodule
	
	

