module D_flipflop(
 input  clk, rst,
 input  D,
 output Q, Q_bar
 );
 assign Q_bar = Q;
 always @(posedge clk, posedge rst)
 begin
 if (rst)
 Q <= 1'b0;
 else
 Q <= D;
end
endmodule