module lab31(
	 input [7:0] A,
	 input [7:0] B,
	 input  sel, 
	 output reg[7:0] result,
	 output reg z
);
	
	 wire larger;
    assign larger = (A[6:4] > B[6:4]) || ((A[6:4] == B[6:4]) && (A[3:0] >= B[3:0]));
    wire [7:0] big_number;
    assign big_number = larger ? B : A;
	 reg[7:0] small_number;
    logic [2:0] shift_amount;
    assign shift_amount = big_number[6:4] - small_number[6:4];
    logic [15:0] shift_fraction;
    assign shift_fraction = small_number[3:0] << shift_amount;
    logic [15:0] neg_shift_fraction;
    assign neg_shift_fraction = (~shift_fraction) + 1;
    logic [16:0] sum;
    wire carry;
    assign {carry, sum} = shift_fraction + big_number[3:0];
	

    wire [7:0] expo;
    wire [7:0] last_exp;
    wire [22:0] fraction;
    wire [22:0] normalized_fraction;
    wire [22:0] last_fraction;
	 assign [15:0] sum;
    assign last_exp = big_number[6:4];
    assign normalized_fraction = sum >> 1;
    assign last_fraction = normalized_fraction | {1'b1, carry};

    wire sign;
    assign sign = big_number[7];

    
    wire zero;
    assign zero = (A[7] != B[7]) && (last_fraction == 0) && (expo == 0);

    
    assign result[7] = sign;
    assign result[6:4] = last_exp;
    assign result[3:0] = last_fraction;
	 
	 
	 always_comb begin
  if (sel) begin
    if (A[7]) begin
      if (B[7]) begin
        fraction[22:16] =  + (~A[3:0]) + 1;
      end else begin
        fraction[8:0] = fraction[22:16] + (~A[3:0]) + 1;
      end
    end else begin
      if (B[7]) begin
        fraction[8:0] = fraction[15:9] + A[3:0];
      end else begin
        fraction[8:0] = fraction[22:16] + A[3:0];
      end
    end
  end else begin
    if (A[3:0]) begin
      if (B[3:0]) begin
        fraction[8:0] = fraction[22:16] - A[3:0];
      end else begin
        fraction[8:0] = fraction[15:9] - A[3:0];
      end
    end else begin
      if (B[0]) begin
        fraction[8:0] = fraction[22:16] + A[3:0];
      end else begin
        fraction[8:0] = fraction[15:9] + A[3:0];
      end
    end
  end
end 
	 
	 

endmodule