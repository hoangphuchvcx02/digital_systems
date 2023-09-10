module RAM(
input logic [6:0] addr,
input logic [8:0] data,
input logic wr_en,
input logic clk,
output logic [8:0] q
);

logic [8:0] memory [0:127]; // 128 words of 9-bit memory

initial begin
$readmemb("inst_mem.txt",memory);
end


always_ff @ (posedge clk) begin
	if (wr_en) begin
		memory[addr] <= data;
   end
   q = memory[addr];
end

endmodule
