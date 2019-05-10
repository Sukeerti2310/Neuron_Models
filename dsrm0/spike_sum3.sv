module spike_sum3 (
                 input reset,
                 input clk,
                 input [13:0] i_sum_excit,
                 input [13:0] i_sum_inhibit,
                 input [13:0] i_cond_decay,
                 output reg [13:0] o_final_voltage,
                 output reg o_spike
                 );
wire [13:0] sum;
wire [13:0] sum_excit_decay;
genvar i;
reg spike_f;
reg spike_ff;
wire comp;

parameter threshold = 14'h1300;

assign sum = i_sum_excit - i_sum_inhibit + i_cond_decay;  
assign sum_excit_decay = i_sum_excit + i_cond_decay;

always_ff @(posedge clk or negedge reset) begin
    if (!reset) begin
        o_final_voltage <= 0;
    end
    else begin
       if (o_spike == 1) begin
          o_final_voltage <= 0;
       end
       else begin
	  if (sum_excit_decay > i_sum_inhibit) begin
	      o_final_voltage <= sum;
	  end
	  else begin
              o_final_voltage <= 0;
	  end
       end
    end
end

assign comp = (o_final_voltage >= threshold);

always_ff @(posedge clk or negedge reset) begin
    if (!reset) begin
        spike_f <= 1'b0;
    end
    else begin
        if (comp) begin
           spike_f <= 1'b1;
        end
        else
           spike_f <= 1'b0;
        end
    end


always_ff @(posedge clk or negedge reset) begin
    if (!reset) begin
        spike_ff <= 1'b0;
    end
    else begin
        spike_ff <= spike_f;
    end
end

assign o_spike = spike_f && ~spike_ff;

endmodule

