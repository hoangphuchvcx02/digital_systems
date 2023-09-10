module add_subtract(
	input clk_i, Cin,
	input [7:0] A,
	input [7:0] B,
	output [7:0] Result,
	output Cout
);	

	reg [7:0] temp_result;
	
	always @(posedge clk_i) begin
		if (Cin == 1'b1) 
			temp_result <= A - B;
		if (Cin == 1'b0)
			temp_result <= A + B;
	end
	
	assign Result = temp_result;
	assign Cout = Cin;
	
endmodule