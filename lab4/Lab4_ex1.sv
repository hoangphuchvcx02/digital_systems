module Lab4_ex1(
input [8:0] DIN,
input Clock, Run, Resetn,
output [8:0] Bus,
output Done
);

logic [7:0] Rout, Rin;
logic Gout, DINout, IRin, Ain, Gin, AddSub;
logic [8:0] IR_Q;
logic [8:0] G_Q, A_Q;
logic [8:0] R0_Q, R1_Q, R2_Q, R3_Q, R4_Q, R5_Q, R6_Q, R7_Q;
logic [8:0] AddSub_Result;


Control_unit FSM(.Clock(Clock),.Run(Run),.Resetn(Resetn),.IR(IR_Q),.IRin(IRin),.Rout(Rout),.Gout(Gout),.DINout(DINout),.Rin(Rin),.Ain(Ain),.Gin(Gin),.AddSub(AddSub),.Done(Done));

NineBitRegister IR(.clk(Clock),.enable(IRin),.R(DIN),.Q(IR_Q));
NineBitRegister Q(.clk(Clock),.enable(Gin),.R(AddSub_Result),.Q(G_Q));
NineBitRegister A(.clk(Clock),.enable(Ain),.R(Bus),.Q(A_Q));
NineBitRegister R0(.clk(Clock),.enable(Rin[0]),.R(Bus),.Q(R0_Q));
NineBitRegister R1(.clk(Clock),.enable(Rin[1]),.R(Bus),.Q(R1_Q));
NineBitRegister R2(.clk(Clock),.enable(Rin[2]),.R(Bus),.Q(R2_Q));
NineBitRegister R3(.clk(Clock),.enable(Rin[3]),.R(Bus),.Q(R3_Q));
NineBitRegister R4(.clk(Clock),.enable(Rin[4]),.R(Bus),.Q(R4_Q));
NineBitRegister R5(.clk(Clock),.enable(Rin[5]),.R(Bus),.Q(R5_Q));
NineBitRegister R6(.clk(Clock),.enable(Rin[6]),.R(Bus),.Q(R6_Q));
NineBitRegister R7(.clk(Clock),.enable(Rin[7]),.R(Bus),.Q(R7_Q));

AddSub ALU(.A(A_Q),.B(Bus),.AddSub(AddSub),.Result(AddSub_Result));

Mux10_1 select(.DIN(DIN),.R0(R0_Q),.R1(R1_Q),.R2(R2_Q),.R3(R3_Q),.R4(R4_Q),.R5(R5_Q),.R6(R6_Q),.R7(R7_Q),.G(G_Q),.Rout(Rout),.DINout(DINout),.Gout(Gout),.Bus(Bus));

endmodule