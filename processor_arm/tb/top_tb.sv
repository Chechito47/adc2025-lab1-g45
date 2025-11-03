module top_tb();
	
	logic [15:0] i_sw, o_led;
	logic [7:0] D0_seg, D1_seg;
	logic [3:0] D0_a, D1_a;
	logic i_mclk, i_reset, dump;

  // instantiate device under test
  processor_arm dut (
	    .i_sw(i_sw),
	    .i_mclk(i_mclk),
	    .i_reset(i_reset),
	    .o_led(o_led),
	    .D0_seg(D0_seg),
	    .D1_seg(D1_seg),
	    .D0_a(D0_a),
	    .D1_a(D1_a),
	    .dump(dump)
	);
    
  // generate clock
  always     // no sensitivity list, so it always executes
    begin
      #10 i_mclk = ~i_mclk; 
    end
	 
	 
  initial
    begin
      dump = 0; i_mclk = 0; i_reset = 1; i_sw = 1;
      #20; i_reset = 0;
      #10000; dump = 1;
      #100;
      $stop;
	end 
endmodule 