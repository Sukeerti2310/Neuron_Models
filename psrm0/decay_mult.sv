module decay_mult #(parameter constant = 0)
	      (		
		  //input reset,
		  //input clk,
                  input [13:0] input1,
                  output [13:0] out   
               );

//reg [63:0] temp_out;
wire comp;
wire [2:0] shift_gt;
wire [2:0] shift_lt;
wire [13:0] sub_val;

assign comp = (input1[13:8] > 6'h0);

find_pow2_6 find_gt (
		     .input1 (input1[13:8]),
		     .out (shift_gt)
		     );

find_pow2_8 find_lt (
                     .input1 (input1[7:0]),
                     .out (shift_lt)
                     );

assign sub_val = (comp) ? constant << shift_gt : (constant << shift_lt) >> 8;
assign out = input1 - sub_val;

/*
always @(posedge clk or negedge reset) begin
    if (!reset) begin
	temp_out = 64'h0;
    end
    else begin
	// If number is greater than or equal to 1
	if (comp) begin
	    // Shift constant by shift_gt, thereby achieving mult by power of 2
	    sub_val = constant << shift_gt;
	end
	else begin
	    // To divide by power of 2 (or multuiply by negative power of 2)
	    // Shift left by shift_lt then shift right by 16 ( = shift right by 16 - shift_lt)
	    sub_val = (constant << shift_lt) >> 16;
	end
	temp_out = input1 - sub_val;
    end
end

assign out = temp_out;
*/

endmodule
