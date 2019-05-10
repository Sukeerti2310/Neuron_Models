`timescale 100ns / 1ns

module test_top;

reg ex1, ex2, ex3, ex4, in1, in2, in3, in4;
wire led;
reg clk;
reg reset;

top top_m    (
	      .reset(reset),
              .clk(clk),
	      .ex1(ex1),
	      .ex2(ex2),
	      .ex3(ex3),
	      .ex4(ex4),
	      .in1(in1),
	      .in2(in2),
	      .in3(in3),
	      .in4(in4),
	      .led(led)
             );
initial begin
clk = 1'b1;
end

always begin
   clk = #1 ~clk;
end
 
    initial
    begin

        $dumpfile("top.vcd");
        $dumpvars(0, test_top);
      
	#200 
	reset = 0;
	#400

	ex1 = 0;
        ex2 = 0;
        ex3 = 0;
        ex4 = 0;
        in1 = 0;
        in2 = 0;
        in3 = 0;
        in4 = 0;
 
	#400
	reset = 1;

        #2000
        ex1 = 0;
	ex2 = 1;
	ex3 = 1;
	ex4 = 1;
	in1 = 0;
	in2 = 0;
	in3 = 0;
	in4 = 0;
	 
        #20000
        $finish;

   end

endmodule
