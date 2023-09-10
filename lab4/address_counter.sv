module address_counter(
input CLK, RST,
output [4:0] ADDRESS
);

always @ (posedge CLK or negedge RST) 
	begin
		if (!RST) ADDRESS <= '0;
		else ADDRESS <= ADDRESS + 1;
	end

endmodule
