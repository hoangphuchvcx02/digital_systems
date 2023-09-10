module addsub(
input [8:0] A, B,
input addsub,
output [8:0] result
);

always_comb begin
	if(!addsub) result <= A + B;
	else result <= A - B;
end
endmodule