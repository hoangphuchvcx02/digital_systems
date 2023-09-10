module Control_unit(
input Resetn, Clock, Run,
input [8:0] IR,
output [7:0] Rout,
output DINout, Gout,
output IRin, Ain, Gin, AddSub,
output [7:0] Rin,
output Done
);

logic [1:0] Tstep_Q, Tstep_D;
logic [2:0] III, XXX, YYY;
logic [7:0] RXin_temp, RXout_temp, RYout_temp;

assign III = IR[8:6];
assign XXX = IR[5:3];
assign YYY = IR[2:0]; 

Dec3_8 rxin(.W(XXX),.Y(RXin_temp));
Dec3_8 rxout(.W(XXX),.Y(RXout_temp));
Dec3_8 ryout(.W(YYY),.Y(RYout_temp));

parameter T0 = 2'b00, T1 = 2'b01, T2 = 2'b10, T3 = 2'b11;
// Control FSM state table
always @(Tstep_Q, Run, Done)
		case (Tstep_Q)
            T0: // data is loaded into IR in this time step
                if (~Run) Tstep_D = T0;
                else Tstep_D = T1;
            T1: // some instructions end after this time step
                if (Done) Tstep_D = T0;
                else Tstep_D = T2;
            T2: // always go to T3 after this
                Tstep_D = T3;
            T3: // instructions end after this time step
                Tstep_D = T0;
            default: Tstep_D = 2'bxx;
       endcase
		 
parameter mv = 3'b000, mvi = 3'b001, add = 3'b010, sub = 3'b011;		 
// Control FSM outputs
always @(Tstep_Q) begin
Done = 1'b0; Ain = 1'b0; Gin = 1'b0; AddSub = 1'b0; IRin = 1'b0; Rin = 8'b0;
DINout = 1'b0; Gout = 1'b0; Rout = 8'b0;
		case (Tstep_Q)
            T0: // store instruction on DIN in IR 
                IRin = 1'b1;
            T1: // define signals in T1
                case (III)
                    mv: begin
                        Rout = RYout_temp;
								Rin = RXin_temp;
								Done = 1'b1;
                    end
                    mvi: begin
                        DINout = 1'b1;
								Rin = RXin_temp;
								Done = 1'b1;
                    end
                    add, sub: begin
                        Rout = RXout_temp;
								Ain = 1'b1;
								Done = 1'b0;
                    end
                    default: begin
										Done = 1'b0; Ain = 1'b0; Gin = 1'b0;
										AddSub = 1'b0; IRin = 1'b0; Rin = 8'b0;
										DINout = 1'b0; Gout = 1'b0; Rout = 8'b0;
										end
                endcase
            T2: // define signals T2
                case (III)
                    add: begin
                        Rout = RYout_temp;
								Gin = 1'b1;
								AddSub = 1'b0;
                    end
                    sub: begin
                        Rout = RYout_temp;
								Gin = 1'b1;
								AddSub = 1'b1;
                    end
                    default: begin
										Done = 1'b0; Ain = 1'b0; Gin = 1'b0;
										AddSub = 1'b0; IRin = 1'b0; Rin = 8'b0;
										DINout = 1'b0; Gout = 1'b0; Rout = 8'b0;
										end 
                endcase
            T3: // define T3
                case (III)
                    add, sub: begin
                        Gout = 1'b1;
								Rin = RXin_temp;
								Done = 1'b1;
                    end
                    default: begin
										Done = 1'b0; Ain = 1'b0; Gin = 1'b0;
										AddSub = 1'b0; IRin = 1'b0; Rin = 8'b0;
										DINout = 1'b0; Gout = 1'b0; Rout = 8'b0;
										end
                endcase
        endcase
    end

// Control FSM flip-flops
always @(posedge Clock, negedge Resetn)
		if (!Resetn)
			Tstep_Q <= T0;
		else
         Tstep_Q <= Tstep_D;
endmodule
