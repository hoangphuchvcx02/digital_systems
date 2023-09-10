module ex1lab2(
			input  logic [0:0] w,clk,rst,
			output logic [0:0] z,
			output logic [8:0] state_out
);

logic Y8, Y7, Y6, Y5, Y4, Y3, Y2, Y1, Y0;
logic y8, y7, y6, y5, y4, y3, y2, y1, y0;
logic y8b, y7b, y6b, y5b,y4b, y3b,y2b, y1b,y0b;


D_flipflop ff0(
			.clk(clk),
			.rst(rst),
			.D(Y0),
			.Q(y0),
			.Q_bar(y0b)
);
			
D_flipflop ff1(
			.clk(clk),
			.rst(rst),
			.D(Y1),
			.Q(y1),
			.Q_bar(y1b)
);

D_flipflop ff2(
			.clk(clk),
			.rst(rst),
			.D(Y2),
			.Q(y2),
			.Q_bar(y2b)
);

D_flipflop ff3(
			.clk(clk),
			.rst(rst),
			.D(Y3),
			.Q(y3),
			.Q_bar(y3b)
);

D_flipflop ff4(
			.clk(clk),
			.rst(rst),
			.D(Y4),
			.Q(y4),
			.Q_bar(y4b)
);
			
D_flipflop ff5(
			.clk(clk),
			.rst(rst),
			.D(Y5),
			.Q(y5),
			.Q_bar(y5b)
);

D_flipflop ff6(
			.clk(clk),
			.rst(rst),
			.D(Y6),
			.Q(y6),
			.Q_bar(y6b)
);

D_flipflop ff7(
			.clk(clk),
			.rst(rst),
			.D(Y7),
			.Q(y7),
			.Q_bar(y7b)
);

D_flipflop ff8(
			.clk(clk),
			.rst(rst),
			.D(Y8),
			.Q(y8),
			.Q_bar(y8b)
);
assign Y0 = 1'b0;

assign Y1 = ( ~w & y4b & y3b & y2b & y1b & y0b & ( (y8b & y6b &  y5b) | (y8b & y7b &  y5b) |(y7b & y6b &  y5b) |(y8b & y7b &  y6b) ) );

assign Y2 = ( ~w & y8b & y7b & y6b & y5b & y4b & y3b & y2b & y1 & y0b );

assign Y3 = ( ~w & y8b & y7b & y6b & y5b & y4b & y3b & y2 & y1b & y0b );

assign Y4 = ( ~w & y8b &  y7b &  y6b &  y5b &  y2b &  y1b &  y0b & ( y4 ^ y3));

assign Y5 = ( w & y8b & y7b & y6b & y5b & y0b & ( (y4b & y2b &  y1b) | (y4b & y3b &  y1b) |(y3b & y2b &  y1b) |(y4b & y3b &  y2b) ) );

assign Y6 = ( w & y8b & y7b & y6b & y5 & y4b & y3b & y2b & y1b & y0b );

assign Y7 = ( w & y8b & y7b & y6 & y5b & y4b & y3b & y2b & y1b & y0b );

assign Y8 = ( w & y6b & y5b & y4b & y3b & y2b & y1b & y0b & ( y8 ^ y7));

assign z = ( y7b & y6b & y5b & y3b & y2b & y1b & y0b & ( y8 ^ y4 ) );

assign state_out = {y8,y7,y6,y5,y4,y3,y2,y1,y0};

endmodule