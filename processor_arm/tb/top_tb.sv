module top_tb();
	
	logic [15:0] i_sw;
	logic i_mclk;
	logic i_reset, dump;
	logic [15:0] o_led;

  
  // instantiate device under test
  processor_arm  dut (i_sw,i_mclk,i_reset,o_led, dump);
    
  // generate clock
  always     // no sensitivity list, so it always executes
    begin
      #10 i_mclk = ~i_mclk; 
    end
	 
	 
  initial
    begin
      dump=0;
      i_mclk = 0; i_reset = 1; i_sw = 1;
      #20; i_reset = 0;
      dump = 1; 
      #80;
      $stop;
	end 
endmodule 