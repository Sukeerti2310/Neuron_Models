parameter NO_OF_NEURONS = 8;

module neuron (
              input reset,
              input clk,
              input i_excitatory [7:0],
              input i_inhibitory [7:0],
              output reg o_spike 
              );

localparam weight_e = 14'h800; // Weight of 8
localparam weight_i = 14'hF33; // Weight of 15.2
//localparam weight1 = 32'h0000999A;  // 0.6
//localparam weight2 = 32'h0000CCCD; // 0.8
//localparam weight3 = 32'h0000E666; // 0.9
localparam dm = 14'h25; // 0.144
localparam ds = 14'h94; // 0.577

genvar i;
wire [13:0] excit_weighted [7:0];
wire [13:0] inhibit_weighted [7:0];
wire [13:0] excit_weight;
//wire [31:0] inhibit_weight;
wire [13:0] final_decay;
wire [13:0] final_vt;
wire [13:0] vt;
wire [13:0] sum_vt;


spike_sum element1 (
                   .reset (reset),
		   .clk (clk),
                   .i_weighted_spikes_e (excit_weighted),
                   .i_weighted_spikes_i (inhibit_weighted),
                   .i_cond_decay (excit_weight),
                   .o_sum_voltage(sum_vt),
                   .o_sum_voltage_ff(vt)
                   );



generate 
   for (i = 0; i < 8; i = i+1) begin
       mux #(.IN1(weight_e)) mux_e (
                 .sel (i_excitatory[i]),
                 .out (excit_weighted[i])
                  );
       mux #(.IN1(weight_i)) mux_i (
                 .sel (i_inhibitory[i]),
                 .out (inhibit_weighted[i])
                  );
   end
endgenerate         

// Decay multipliers
decay_mult #(ds) shift1 (
	  //.reset (reset),
	  //.clk (clk),
          .input1 (vt),
          .out (excit_weight)
          );


decay_mult #(dm) shift2 (
	  //.reset (reset),
	  //.clk (clk),
          .input1 (final_vt),
          .out (final_decay)
          );


spike_sum3 element3 (
                    .reset (reset),
                    .clk (clk),
                    .i_sum (sum_vt),
                    .i_cond_decay (final_decay),
                    .o_final_voltage (final_vt),
                    .o_spike (o_spike)
                    );


endmodule
