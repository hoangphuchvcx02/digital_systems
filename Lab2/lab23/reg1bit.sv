module reg1bit(
input logic clk,
input logic rst_n,                             //_n for fall edge active
input [7:0] data_in,
output [7:0] z                   // no , needed for last line
);

reg[7:0] reg_data;

always @(posedge clk, negedge rst_n)begin // conditional that code inside activate when conditions are met
  if(~rst_n)
     reg_data <= 8'b0;
  else
     reg_data <= data_in;

end

assign z = reg_data;
endmodule
