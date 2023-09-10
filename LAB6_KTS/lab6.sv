module lab6(
input clk, rstn, run,
output done,
output [8:0] LEDs
);

logic [8:0] DIN, ADDR, DOUT;
logic W;
logic A8, A7, wr_en_mem, LED_en;


assign A8 = ADDR[8];
assign A7 = ADDR[7];
assign wr_en_mem = !(A8 | A7) & W;
assign LED_en = !(A8 | !A7) & W;

processor processor(.DIN(DIN),.clk(clk),.rstn(rstn),.run(run),.ADDR(ADDR),.DOUT(DOUT),.done(done),.W(W));
RAM memory(.addr(ADDR[6:0]),.data(DOUT),.wr_en(wr_en_mem),.clk(clk),.q(DIN));
register9 LED(.clk(clk),.en(LED_en),.R(DOUT),.Q(LEDs));

endmodule