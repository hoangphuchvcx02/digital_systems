module register2 (
    input clk_i,
    input rst_n,
    input [15:0] D,
    output [15:0] Q
);
	reg [15:0] reg_data;

always_ff @(posedge clk_i, negedge rst_n) begin
    if (~rst_n) 
        reg_data <= 16'b0000000000000000;
    else
        reg_data <= D;
end

	assign Q = reg_data;

endmodule