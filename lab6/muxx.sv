module muxx(
input [8:0] DIN,
input [8:0] R0, R1, R2, R3, R4, R5, R6, R7,
input [8:0] G, GF,
input [7:0] Rout,
input DINout, Gout, GFout,
output [8:0] bus
);

logic [10:0] sel;

assign sel = {Rout, DINout, Gout, GFout};

always_comb begin
	case (sel)
		11'b10000000000: bus = R7;
		11'b01000000000: bus = R6;
		11'b00100000000: bus = R5;
		11'b00010000000: bus = R4;
		11'b00001000000: bus = R3;
		11'b00000100000: bus = R2;
		11'b00000010000: bus = R1;
		11'b00000001000: bus = R0;
		11'b00000000100: bus = DIN;
		11'b00000000010: bus = G;
		11'b00000000001: bus = GF;
		default: bus = '0;
	endcase
end
endmodule