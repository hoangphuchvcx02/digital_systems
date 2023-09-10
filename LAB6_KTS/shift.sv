module shift(
input  logic [3:0] smaller_f,
input logic [4:0] diff_ex,		 
output logic [5:0] shifted_f
);

logic [4:0] shift, lead;

always_comb begin	    
	if (diff_ex[4] == 0) 
		shift = diff_ex;
	else	 
		shift = -diff_ex;	 
end

assign lead = {1'b1, smaller_f};
assign shifted_f = lead >> shift;	 

endmodule