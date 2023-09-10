module Lab4_ex2(
input MClock, PClock, Resetn, Run,
output Done,
output [8:0] Bus
);

logic [8:0] DATA;

top_mem Getaddress(
.CLK(MClock),
.RST(Resetn),
.DATAOUT(DATA)
);

Lab4_ex1 Getdata(
.DIN(DATA),
.Clock(PClock),
.Resetn(Resetn),
.Run(Run),
.Bus(Bus),
.Done(Done)
);

endmodule