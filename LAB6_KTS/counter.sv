module counter(
input clk, en, incr_pc, rstn,
input [8:0] R,
output [8:0] Q
);
always@(posedge clk) begin
	if (!rstn)
            Q <= 9'b0;
        else if (en)
            Q <= R;
        else if (incr_pc)
            Q <= Q + 1'b1;
end
endmodule