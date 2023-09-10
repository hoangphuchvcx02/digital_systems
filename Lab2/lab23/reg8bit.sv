module reg8bit (
  input logic clk,
  input logic rst_n,
  input [7:0] data_in,
  output [7:0] data_out
);

  wire [7:0] d;

  reg1bit r[8:1](
    .clk(clk),
    .rst_n(rst_n),
    .data_in(data_in),
    .z(d[1])
  );

  assign d[8] = 1'b0;
  assign data_out = d[8:1];

  always @ (posedge clk, negedge rst_n) begin
    if (~rst_n) begin
      d <= 8'b0;
    end
    else begin
      d <= {d[7:1], r[8].z};
    end
  end

endmodule
