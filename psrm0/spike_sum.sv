module spike_sum (
                 input reset,
                 input clk,
                 input [13:0] i_weighted_spikes_e[7:0],
                 input [13:0] i_weighted_spikes_i[7:0],
                 input [13:0] i_cond_decay,
                 output reg [13:0] o_sum_voltage,
                 output reg [13:0] o_sum_voltage_ff
                 );
wire [13:0] sum_e_decay;
wire [13:0] sum_i;
genvar i;

assign sum_e_decay = i_weighted_spikes_e[7] +  i_weighted_spikes_e[6] + i_weighted_spikes_e[5] +  i_weighted_spikes_e[4] +  i_weighted_spikes_e[3] +  i_weighted_spikes_e[2] +  i_weighted_spikes_e[1] +  i_weighted_spikes_e[0] + i_cond_decay;

assign sum_i = i_weighted_spikes_i[7] +  i_weighted_spikes_i[6] + i_weighted_spikes_i[5] +  i_weighted_spikes_i[4] +  i_weighted_spikes_i[3] +  i_weighted_spikes_i[2] +  i_weighted_spikes_i[1] +  i_weighted_spikes_i[0];

assign o_sum_voltage = sum_e_decay - sum_i;
//assign o_sum_voltage = (sum_e_decay > sum_i) ? sum : 0;


always @(posedge clk or negedge reset) begin
    if (!reset) begin
        o_sum_voltage_ff <= 0;
    end
    else begin
	if (sum_e_decay > sum_i) begin
            o_sum_voltage_ff <= o_sum_voltage;
	end
	// Prevent from overflowing
	else begin
	    o_sum_voltage_ff <= 0;
	end
    end
end


endmodule

