module CPU(
input CLK, RST, RUN,
input [7:0] DIN,
output [7:0] DOUT
);

reg [7:0] ACC, R0, R1, R2, R3, R4, R5, R6, R7;
reg [7:0] IR;
reg [7:0] MEM [255:0];
reg [7:0] PC;

// Control Unit
Control_unit CU(.Resetn(RST), .Clock(CLK), .Run(RUN),
.IR(IR),
.Rout(DOUT),
.DINout(),
.Gout(),
.IRin(),
.Ain(),
.Gin(),
.AddSub(),
.Rin(R7),
.Done());

// Instruction Register (IR)
always @(posedge CLK, negedge RST)
    if (~RST) IR <= 8'b0;
    else IR <= MEM[PC];

// Program Counter (PC)
always @(posedge CLK, negedge RST)
    if (~RST) PC <= 8'b0;
    else PC <= PC + 1;

// Memory
always @(posedge CLK, negedge RST)
    if (~RST) MEM <= 256'h00000000;
    else if (CU.IRin) MEM[PC] <= DIN;
    else if (CU.DINout) DOUT <= MEM[CU.Rin];
    else if (CU.Rout != 8'b0) MEM[CU.Rout] <= ACC;
    else if (CU.Gout) DOUT <= ACC;
    else if (CU.Ain) ACC <= MEM[CU.Rin];
    else if (CU.Gin) ACC <= DOUT;
    else if (CU.AddSub) ACC <= ACC + ~DOUT + 1;
    else ACC <= ACC + DOUT;

endmodule
