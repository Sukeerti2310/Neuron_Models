module top (
	    input reset,
	    input clk,
	    input ex1,
	    input ex2,
	    input ex3,
	    input ex4,
	    input in1,
	    input in2, 
	    input in3,
	    input in4,
	    output led
	   );

wire exc_arr [7:0];
wire inh_arr [7:0];
reg del_ex1, del_ex2, del_ex3, del_ex4, del_in1, del_in2, del_in3, del_in4;
reg del2_ex1, del2_ex2, del2_ex3, del2_ex4, del2_in1, del2_in2, del2_in3, del2_in4;
wire op_spike;

assign exc_arr[7] = 0;
assign exc_arr[6] = 0;
assign exc_arr[5] = 0;
assign exc_arr[4] = 0;
assign exc_arr[3] = ex4 & ~del2_ex4;
assign exc_arr[2] = ex3 & ~del2_ex3;
assign exc_arr[1] = ex2 & ~del2_ex2;
assign exc_arr[0] = ex1 & ~del2_ex1;

assign inh_arr[7] = 0;
assign inh_arr[6] = 0;
assign inh_arr[5] = 0;
assign inh_arr[4] = 0;
assign inh_arr[3] = in4 & ~del2_in4;
assign inh_arr[2] = in3 & ~del2_in3;
assign inh_arr[1] = in2 & ~del2_in2;
assign inh_arr[0] = in1 & ~del2_in1;

neuron neur (
	     .reset (reset),
	     .clk (clk),
	     .i_excitatory (exc_arr),
	     .i_inhibitory (inh_arr),
	     .o_spike (op_spike)
	    );

always@ (posedge clk)
begin
    del_ex4 <= ex4;
    del_ex3 <= ex3;
    del_ex2 <= ex2;
    del_ex1 <= ex1;

    del_in4 <= in4;
    del_in3 <= in3;
    del_in2 <= in2;
    del_in1 <= in1; 
end

always@ (posedge clk)
begin
    del2_ex4 <= del_ex4;
    del2_ex3 <= del_ex3;
    del2_ex2 <= del_ex2;
    del2_ex1 <= del_ex1;

    del2_in4 <= del_in4;
    del2_in3 <= del_in3;
    del2_in2 <= del_in2;
    del2_in1 <= del_in1;
end

assign led = op_spike;

endmodule
