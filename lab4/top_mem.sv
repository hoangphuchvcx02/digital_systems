module top_mem(
input logic CLK, RST,
output logic [8:0] DATAOUT
);

logic [4:0] ADDRESS;

address_counter getaddress(
.CLK (CLK),
.RST (RST),
.ADDRESS (ADDRESS)
);


MyROM getdata(
.CLK (CLK),
.ADDRESS (ADDRESS),
.DATAOUT (DATAOUT)
);
endmodule