module processor(
input [8:0] DIN,
input clk, run, rstn,
output [8:0] ADDR, DOUT,
output done, W
);

logic [8:0] bus;
logic [7:0] Rout, Rin;
logic Gout, DINout, IRin, Ain, Gin, AddSub;
logic [8:0] IR_Q;
logic [8:0] G_Q, A_Q;
logic [8:0] R0_Q, R1_Q, R2_Q, R3_Q, R4_Q, R5_Q, R6_Q, R7_Q;
logic [8:0] AddSub_Result;
logic gzero;
logic incr_pc, ADDRin, DOUTin, W_D;

logic GFout, AFin, GFin, AddSubF;
logic [8:0] GF_Q, AF_Q;
logic [8:0] AddSubF_Result;

assign gzero = G_Q == 0;

control FSM(.clk(clk),.run(run),.rstn(rstn),.gzero(gzero),.IR(IR_Q),.IRin(IRin),.Rout(Rout),.Gout(Gout),.GFout(GFout),
.DINout(DINout),.Rin(Rin),.Ain(Ain),.Gin(Gin),.AFin(AFin),.GFin(GFin),.AddSub(AddSub),.AddSubF(AddSubF),
.incr_pc(incr_pc),.ADDRin(ADDRin),.DOUTin(DOUTin),.W_D(W_D),.done(done));

register9 IR(.clk(clk),.en(IRin),.R(DIN),.Q(IR_Q));
register9 G(.clk(clk),.en(Gin),.R(AddSub_Result),.Q(G_Q));
register9 A(.clk(clk),.en(Ain),.R(bus),.Q(A_Q));
register9 GF(.clk(clk),.en(GFin),.R(AddSubF_Result),.Q(GF_Q));
register9 AF(.clk(clk),.en(AFin),.R(bus),.Q(AF_Q));
register9 R0(.clk(clk),.en(Rin[0]),.R(bus),.Q(R0_Q));
register9 R1(.clk(clk),.en(Rin[1]),.R(bus),.Q(R1_Q));
register9 R2(.clk(clk),.en(Rin[2]),.R(bus),.Q(R2_Q));
register9 R3(.clk(clk),.en(Rin[3]),.R(bus),.Q(R3_Q));
register9 R4(.clk(clk),.en(Rin[4]),.R(bus),.Q(R4_Q));
register9 R5(.clk(clk),.en(Rin[5]),.R(bus),.Q(R5_Q));
register9 R6(.clk(clk),.en(Rin[6]),.R(bus),.Q(R6_Q));
counter R7(.clk(clk),.en(Rin[7]),.incr_pc(incr_pc),.rstn(rstn),.R(bus),.Q(R7_Q));
register9 ADDR_ff(.clk(clk),.en(ADDRin),.R(bus),.Q(ADDR));
register9 DOUT_ff(.clk(clk),.en(DOUTin),.R(bus),.Q(DOUT));
d_ff W_ff(.clk(clk),.W_D(W_D),.W(W));

addsub ALU(.A(A_Q),.B(bus),.addsub(AddSub),.result(AddSub_Result));
floatingpoint fp(.A(AF_Q),.B(bus),.S(AddSubF),.result(AddSubF_Result));

muxx select(.DIN(DIN),.R0(R0_Q),.R1(R1_Q),.R2(R2_Q),.R3(R3_Q),.R4(R4_Q),.R5(R5_Q),.R6(R6_Q),.R7(R7_Q),.G(G_Q),
.GF(GF_Q),.Rout(Rout),.DINout(DINout),.Gout(Gout),.GFout(GFout),.bus(bus));

endmodule
