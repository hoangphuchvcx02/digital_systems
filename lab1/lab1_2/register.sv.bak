	module register (
	input rst_n,
	input clk_i,
	input [7:0] data_in,
	output [7:0] data_out
);
	reg [7:0] reg_data;
	
	always_ff @( posedge clk_i, negedge rst_n ) begin
		if (~rst_n)
			reg_data <= 8'b00000000;
		else 
			reg_data <= data_in;
	end
	assign data_out = reg_data;
	
endmodule 