// CLOCK DIVIDER

module clkDiv (input logic clk,
					input logic reset,
					output logic clkDiv);
	
	logic [20:0] clk_divider;
	
	always_ff @(posedge clk, posedge reset)
		if(reset) clk_divider  <= '0;
		else clk_divider <= clk_divider + 1;
		
	// Para analizar en simulador:	
	assign clkDiv = clk_divider[0];

	// Para grabar en FPGA:
	//assign clkDiv = clk_divider[20];

endmodule 
