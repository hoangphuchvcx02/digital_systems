module lab22(
    input clk,
    input rst_n,
    input w,
    output logic z,
    output[3:0] stateLED
	 );

    logic [3:0] y,Y ;
    
	 parameter A = 4'b0000;
    parameter B = 4'b0001;
    parameter C = 4'b0010;
    parameter D = 4'b0011;
    parameter E = 4'b0100;
    parameter F = 4'b0101;
    parameter G = 4'b0110;
    parameter H = 4'b0111;
    parameter I = 4'b1000;

assign stateLED = y;
	always_comb 
		begin 
			case (y) 
					A: if (w) Y = B;
						else Y = F;
					B: if (w) Y = C;
						else Y = F;
					C: if (w) Y = D; 
						else Y = F; 
					D: if (w) Y = E;
						else Y = F; 
					E: if (w) Y = E;
						else Y = F;
					F: if (w) Y = B;
						else Y = G;
					G: if (w) Y = B;
						else Y = H;
					H: if (w) Y = B;
						else Y = I;
					I: if (w) Y = B;
						else Y= I;
					default: Y = 4'bxxxx;

    //output signal depending on state
    //signals in states E and I will be 1, otherwise 0

				endcase
				end
			always_ff @(negedge rst_n or posedge clk)
				if (rst_n==0) y<=A;
					else y<= Y ;
			always_comb 
				begin
					z=(y==E||y==I);
				end
endmodule
