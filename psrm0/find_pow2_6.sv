module find_pow2_6
	      (
		  input [5:0] input1,  
                  output [2:0] out   
               );

// Doing this will give the (power of 2 smaller than input) - 1
wire [5:0] pow2_sub1;
wire [5:0] input1_sub1;

assign input1_sub1 = (input1) ? input1 - 1 : 0;

assign pow2_sub1 = (input1_sub1 >> 1) | (input1_sub1 >> 2) | (input1_sub1 >> 3) | (input1_sub1 >> 4) | (input1_sub1 >> 5);

// Adding all the bits will give the correct power
assign out = pow2_sub1[0] + pow2_sub1[1] + pow2_sub1[2] + pow2_sub1[3] + pow2_sub1[4] + pow2_sub1[5];

endmodule
