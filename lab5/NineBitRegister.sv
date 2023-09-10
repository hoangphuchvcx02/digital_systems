module NineBitRegister(
input clk, enable,

input [8:0] R,
output [8:0] Q
);
always@(posedge clk) begin
	if (enable) 
		Q <= R;
	else
		;
end
endmodule

