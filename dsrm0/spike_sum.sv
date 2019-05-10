module spike_sum (
                 input reset,
                 input clk,
                 input [13:0] i_weighted_spikes[7:0],
                 input [13:0] i_cond_decay,
                 output reg [13:0] o_sum_voltage_ff,
                 output reg [13:0] o_sum_voltage
                 );
genvar i;

assign o_sum_voltage = i_weighted_spikes[7] +  i_weighted_spikes[6] + i_weighted_spikes[5] 
                       +  i_weighted_spikes[4] +  i_weighted_spikes[3] +  i_weighted_spikes[2] 
                       +  i_weighted_spikes[1] +  i_weighted_spikes[0] + i_cond_decay;


always @(posedge clk or negedge reset) begin
    if (!reset) begin
        o_sum_voltage_ff <= 0;
    end
    else begin
        o_sum_voltage_ff <= o_sum_voltage;
    end
end

endmodule

