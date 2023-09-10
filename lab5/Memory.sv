module Memory(
input Resetn, Clock, ChipSelect, WriteEnable,
input [7:0] Address, DataIn,
output reg [7:0] DataOut
);
	
reg [7:0] RAM[0:255];

always @(posedge Clock, negedge Resetn) begin
	if (!Resetn) begin
		DataOut <= 8'b0;
		RAM <= '{default:'0};
	end else begin
		if (ChipSelect) begin
			if (WriteEnable) begin
				RAM[Address] <= DataIn;
			end else begin
				DataOut <= RAM[Address];
			end
		end else begin
			DataOut <= 8'bZ;
	

		end
	end
end

endmodule
