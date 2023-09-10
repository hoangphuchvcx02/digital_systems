module control(
input rstn, clk, run,
input [8:0] IR,
input gzero,
output [7:0] Rout,
output DINout, Gout,
output IRin, Ain, Gin, AddSub,
output incr_pc, ADDRin, DOUTin, W_D,
output [7:0] Rin,
output GFout,
output AFin, GFin, AddSubF,
output done
);

logic [2:0] Tstep_Q, Tstep_D;
logic [2:0] III, XXX, YYY;
logic [7:0] RXin_temp, RXout_temp, RYout_temp;

assign III = IR[8:6];
assign XXX = IR[5:3];
assign YYY = IR[2:0]; 

dec3to8 rxin(.W(XXX),.Y(RXin_temp));
dec3to8 rxout(.W(XXX),.Y(RXout_temp));
dec3to8 ryout(.W(YYY),.Y(RYout_temp));

parameter T0 = 3'b000, T1 = 3'b001, T2 = 3'b010, T3 = 3'b011, T4 = 3'b100, T5 = 3'b101;

    // Control FSM state table
    always @(Tstep_Q, run, done)
        case (Tstep_Q)
            T0: // instruction fetch
                if (~run) Tstep_D = T0;
                else Tstep_D = T1;
            T1: // wait cycle for synchronous memory
                Tstep_D = T2;
            T2: // this time step stores the instruction word in IR
                Tstep_D = T3;
            T3: // some instructions end after this time step
                if (done) Tstep_D = T0;
                else Tstep_D = T4;
            T4: // always go to T5 after this
                Tstep_D = T5;
            T5: // instructions end after this time step
                Tstep_D = T0;
            default: Tstep_D = 3'bxxx;
        endcase
		 
parameter mv = 3'b000, mvi = 3'b001, add = 3'b010, sub = 3'b011, ld = 3'b100, st = 3'b101, mvnz = 3'b110, addf = 3'b111;		 
// Control FSM outputs
always @(*) begin
done = 1'b0; Ain = 1'b0; Gin = 1'b0; AddSub = 1'b0; IRin = 1'b0; Rin = 8'b0;
DINout = 1'b0; Gout = 1'b0; Rout = 8'b0;
incr_pc = 1'b0; ADDRin = 1'b0; DOUTin = 1'b0; W_D = 1'b0;
GFout = 1'b0; AFin = 1'b0; GFin = 1'b0; AddSubF = 1'b0;
		case (Tstep_Q)
            T0: begin // fetch the instruction
                Rout = 8'b10000000; // put pc onto the internal bus
                ADDRin = 1'b1;
                incr_pc = run; // to increment pc
            end
            T1: // wait cycle for synchronous memory
                ;				
				T2: // store instruction on DIN in IR 
                IRin = 1'b1;
            T3: // define signals in T3
                case (III)
                    mv: begin
                        Rout = RYout_temp;
								Rin = RXin_temp;
								done = 1'b1;
                    end
                    mvi: begin
								Rout = 8'b10000000;
								ADDRin = 1'b1;
								incr_pc = 1'b1;
                    end
                    add, sub: begin
                        Rout = RXout_temp;
								Ain = 1'b1;
                    end
						  ld, st: begin
								Rout = RYout_temp;
								ADDRin = 1'b1;
						  end
                    mvnz: begin
								if (!gzero) begin
									Rout = RYout_temp;
									Rin = RXin_temp;
									done = 1'b1;
									end
								else
									done = 1'b1;
						  end
						  addf: begin
                        Rout = RXout_temp;
								AFin = 1'b1;
                    end
						  default: begin
										done = 1'b0; Ain = 1'b0; Gin = 1'b0;
										AddSub = 1'b0; IRin = 1'b0; Rin = 8'b0;
										DINout = 1'b0; Gout = 1'b0; Rout = 8'b0;
										incr_pc = 1'b0; ADDRin = 1'b0; DOUTin = 1'b0; W_D = 1'b0;
										GFout = 1'b0; AFin = 1'b0; GFin = 1'b0; AddSubF = 1'b0;
										end
                endcase
            T4: // define signals T4
                case (III)
                    add: begin
                        Rout = RYout_temp;
								Gin = 1'b1;
                    end
                    sub: begin
                        Rout = RYout_temp;
								Gin = 1'b1;
								AddSub = 1'b1;
                    end
						  mvi: // wait cycle for synchronous memory
								;
						  ld: // wait cycle for synchronous memory
                        ;
                    st: begin
                        Rout = RXout_temp;
								DOUTin = 1'b1;
								W_D = 1'b1;
                    end
						  addf: begin
                        Rout = RYout_temp;
								GFin = 1'b1;
                    end
                    default: begin
										done = 1'b0; Ain = 1'b0; Gin = 1'b0;
										AddSub = 1'b0; IRin = 1'b0; Rin = 8'b0;
										DINout = 1'b0; Gout = 1'b0; Rout = 8'b0;
										incr_pc = 1'b0; ADDRin = 1'b0; DOUTin = 1'b0; W_D = 1'b0;
										GFout = 1'b0; AFin = 1'b0; GFin = 1'b0; AddSubF = 1'b0;
										end 
                endcase
            T5: // define T5
                case (III)
                    add, sub: begin
                        Gout = 1'b1;
								Rin = RXin_temp;
								done = 1'b1;
                    end
						  mvi: begin
								DINout = 1'b1;
								Rin = RXin_temp;
								done = 1'b1;
						  end
						  ld: begin
                        DINout = 1'b1;
								Rin = RXin_temp;
								done = 1'b1;
                    end
                    st: // wait cycle for synhronous memory
                        done = 1'b1;
						  addf: begin
                        GFout = 1'b1;
								Rin = RXin_temp;
								done = 1'b1;
						  end
                    default: begin
										done = 1'b0; Ain = 1'b0; Gin = 1'b0;
										AddSub = 1'b0; IRin = 1'b0; Rin = 8'b0;
										DINout = 1'b0; Gout = 1'b0; Rout = 8'b0;
										incr_pc = 1'b0; ADDRin = 1'b0; DOUTin = 1'b0; W_D = 1'b0;
										GFout = 1'b0; AFin = 1'b0; GFin = 1'b0; AddSubF = 1'b0;
										end
                endcase
        endcase
    end

// Control FSM flip-flops
always @(posedge clk, negedge rstn)
		if (!rstn)
			Tstep_Q <= T0;
		else
         Tstep_Q <= Tstep_D;
endmodule