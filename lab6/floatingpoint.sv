module floatingpoint(
input S,
input [8:0] A, B,
output [8:0] result,
output OV,
output Z
);

logic A_s, B_s;
logic [3:0] A_ex, B_ex;
logic [3:0] A_f, B_f;
logic [3:0] bigger_ex;
logic [4:0] diff_ex;
logic [4:0] diff_f;
logic [3:0] bigger_f, smaller_f;
logic [5:0] shifted_f;
logic [5:0] sixbitbigger_f;
logic [5:0] mag_f;
logic [3:0] result_f;
logic [3:0] result_ex;
logic result_s;

assign A_s = A[8];
assign A_ex = A[7:4];
assign A_f = A[3:0];
assign B_s = B[8];
assign B_ex = B[7:4];
assign B_f = B[3:0];

exponent exponent(.A_ex(A_ex),.B_ex(B_ex),.bigger_ex(bigger_ex),.diff_ex(diff_ex));

fraction fraction(.A_f(A_f),.B_f(B_f),.diff_ex(diff_ex),.bigger_f(bigger_f),.smaller_f(smaller_f),.diff_f(diff_f));

shift shift(.smaller_f(smaller_f),.diff_ex(diff_ex),.shifted_f(shifted_f));

assign sixbitbigger_f = {2'b01, bigger_f};

addsub_f addsubfraction(.A_s(A_s),.B_s(B_s),.S(S),.shifted_f(shifted_f),.sixbitbigger_f(sixbitbigger_f),.mag_f(mag_f));

expfract expfract(.mag_f(mag_f),.bigger_ex(bigger_ex),.result_f(result_f),.result_ex(result_ex),.OV(OV));

sign sign(.diff_ex(diff_ex),.diff_f(diff_f),.A_s(A_s),.B_s(B_s),.S(S),.result_s(result_s));

result Result(.A(A),.B(B),.S(S),.result_s(result_s),.result_ex(result_ex),.result_f(result_f),.result(result),.Z(Z));

endmodule