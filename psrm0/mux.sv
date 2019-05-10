module mux    #(
		parameter IN1 = 14'h800
	      )
	      (
		  input sel,  
                  output [13:0] out   
               );


assign out = (sel) ? IN1 : sel;

endmodule
