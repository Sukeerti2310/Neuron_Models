module mult #(parameter weight = 0)
	      (
                  input [13:0] input2,
                  output [13:0] out   
               );

//parameter weight = 0;
wire [27:0] temp_mult;

assign temp_mult = weight * input2;
assign out = temp_mult[21:8];
//assign mult1_noconn = temp_mult[63:48];
//assign mult2_noconn = temp_mult[15:0];

endmodule
