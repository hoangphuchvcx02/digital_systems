module D_flipflop(
	input clk_i,rst_n,
	input D,
	output Q
);

always @(posedge clk_i,negedge rst_n) begin
	if (~rst_n)
	Q<=1'b0;
	else
	Q<=D;
	end

endmodule 