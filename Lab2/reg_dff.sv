module reg_dff(
 input  clk, reset,
 input  d,
 output q, not_q
 );
 assign not_q = !q;
 always @(posedge clk, posedge reset)
 begin
 if (reset)
 q <= 1'b0;
 else
 q <= d;
end
endmodule