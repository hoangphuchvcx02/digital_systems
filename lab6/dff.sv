module d_ff(
input clk,
input W_D,
output W
);
always@(posedge clk) begin 
		W <= W_D;
end
endmodule