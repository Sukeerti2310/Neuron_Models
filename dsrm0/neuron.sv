parameter NO_OF_NEURONS = 8;

module neuron (
              input reset,
              input clk,
              input i_excitatory [7:0],
              input i_inhibitory [7:0],
	      output o_spike 
              );

localparam weight = 14'h800; // Weight of 8
localparam weight1 = 14'h9A; // 0.6
localparam weight2 = 14'hCD; // 0.8
localparam weight3 = 14'hE6; // 0.9

genvar i;
wire [13:0] excit_weighted [7:0];
wire [13:0] inhibit_weighted [7:0];
wire [13:0] excit_weight;
wire [13:0] inhibit_weight;
wire [13:0] final_decay;
wire [13:0] final_vt;
wire [13:0] vt_e;
wire [13:0] sum_vt_e;
wire [13:0] vt_i;
wire [13:0] sum_vt_i;


spike_sum element1 (
                   .reset (reset),
		   .clk (clk),
                   .i_weighted_spikes (excit_weighted),
                   .i_cond_decay (excit_weight),
                   .o_sum_voltage(sum_vt_e),
                   .o_sum_voltage_ff(vt_e)
                   );


spike_sum element2 (
                   .reset (reset),
                   .clk (clk),
                   .i_weighted_spikes (inhibit_weighted),
                   .i_cond_decay (inhibit_weight),
		   .o_sum_voltage(sum_vt_i),
                   .o_sum_voltage_ff(vt_i)
                   );

generate 
   for (i = 0; i < 8; i = i+1) begin
       mux #(.IN1(weight)) mux_e (
                 .sel (i_excitatory[i]),
                 .out (excit_weighted[i])
                  );
       mux #(.IN1(weight)) mux_i (
                 .sel (i_inhibitory[i]),
                 .out (inhibit_weighted[i])
                  );
   end
endgenerate         

mult #(weight1) mul3 (
          .input2 (vt_e),
          .out (excit_weight)
          );


mult #(weight2) mul4 (
          .input2 (vt_i),
          .out (inhibit_weight)
          );

mult #(weight3) mul5 (
          .input2 (final_vt),
          .out (final_decay)
          );


spike_sum3 element3 (
                    .reset (reset),
                    .clk (clk),
                    .i_sum_excit (sum_vt_e),
                    .i_sum_inhibit (sum_vt_i),
                    .i_cond_decay (final_decay),
                    .o_final_voltage (final_vt),
                    .o_spike (o_spike)
                    );


endmodule
