module counter_9bit (
  input logic clk, 
  input logic reset, 
  input logic load, 
  input logic incr_PC, 
  output logic [8:0] count
);

  logic [8:0] counter_reg;

  always_ff @(posedge clk) begin
    if (reset) begin
      counter_reg <= 0;
    end
    else if (load) begin
      counter_reg <= 9'b0;
    end
    else if (incr_PC) begin
      counter_reg <= counter_reg + 1;
    end
  end

  assign count = counter_reg;

endmodule