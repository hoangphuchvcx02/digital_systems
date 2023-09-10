module register9(
input clk, en,
input [8:0] R,
output [8:0] Q
);
always@(posedge clk) begin
	if (en) 
		Q <= R;
	else
		;
end
endmodule