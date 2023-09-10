module AddSub(
input [8:0] A, B,
input AddSub,
output [8:0] Result
);

always_comb begin
	if(!AddSub) Result <= A + B;
	else Result <= A - B;
end
endmodule

