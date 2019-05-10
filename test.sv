`timescale 100us / 1us

module test;

parameter NO_OF_NEURONS = 8;
wire o_spike;
reg clk;
reg reset;
reg excitatory_arr [NO_OF_NEURONS-1:0]; 
reg inhibitory_arr [NO_OF_NEURONS-1:0]; 

neuron neuron_m    (
                   .reset(reset),
                   .clk(clk),
                   .i_excitatory (excitatory_arr), 
                   .i_inhibitory (inhibitory_arr),
                   .o_spike (o_spike)
                   );
initial begin
clk = 1'b1;
reset = 1'b1;
end

always begin
   clk = #1 ~clk;
end
 
    initial
    begin

        $dumpfile("neuron.vcd");
        $dumpvars(0, test);
        
        #20
        reset = 1'b0;
        excitatory_arr = {0,0,0,0,0,0,0,0}; 
        inhibitory_arr = {0,0,0,0,0,0,0,0}; 
        
        #10
        reset = 1'b1;
 
        #10
        excitatory_arr = {1,0,0,0,0,0,0,0}; 
        
        #2
        excitatory_arr = {0,0,0,0,0,0,0,0}; 
        
        #2
        excitatory_arr = {0,1,1,0,0,0,0,0}; 
        inhibitory_arr = {0,0,0,0,0,0,1,0}; 

        #2
        excitatory_arr = {0,0,0,0,0,0,0,0}; 
        inhibitory_arr = {0,0,0,0,0,0,0,0}; 

        #2
        excitatory_arr = {0,0,0,1,0,0,0,0}; 
        
        #2
        excitatory_arr = {0,0,0,0,0,0,0,0}; 
        inhibitory_arr = {0,0,0,0,0,0,0,0}; 
        
        #200
        $finish;

   end

endmodule
