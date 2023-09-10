module ex2lab2(
					input clk,reset,
					input w,
					output Y,
					output ledr3, ledr2, ledr1, ledr0
				   );
	typedef enum logic [3:0] {A, B, C, D, E, F, G, H, I} State;
	State currentState, nextState;

	always_ff @(posedge clk, negedge reset)
		if(~reset)	currentState <= A;
		else		 	currentState <= nextState;
	
	always_comb
		case(currentState)
		A:	if(w)		nextState = F;		// if w = 1, go to F
			else		nextState = B;		// if w = 0, go to B
			
		B:	if(w)		nextState = F;		// if w = 1, go to F
			else		nextState = C;		// if w = 0, go to C
			
		C:	if(w)		nextState = F;		// if w = 1, go to F
			else		nextState = D;		// if w = 0, go to D
			
		D:	if(w)		nextState = F;		// if w = 1, go to F
			else		nextState = E;		// if w = 0, go to E
			
		E:	if(w)		nextState = F;		// if w = 1, go to F
			else		nextState = E;		// if w = 0, stay at E	
			
		F: if(w)		nextState = G;		// if w = 1, go to G
			else		nextState = B;		// if w = 0, go to B
		
		G: if(w)		nextState = H;		// if w = 1, go to H
			else		nextState = B;		// if w = 0, go to B
			
		H: if(w)		nextState = I;		// if w = 1, go to I
			else		nextState = B;		// if w = 0, go to B
			
		I: if(w)		nextState = I;		// if w = 1, stay at I
			else		nextState = B;		// if w = 0, go to B
		
		default: nextState = A;			// first state 
		endcase
		
		assign Y = (currentState == E | currentState == I);
		assign ledr3 = (currentState == I);
		assign ledr2 = (currentState == E | currentState == F | currentState == G | currentState == H);
		assign ledr1 = (currentState == C | currentState == D | currentState == G | currentState == H);
		assign ledr0 = (currentState == B | currentState == D | currentState == F | currentState == H);
		
		
endmodule