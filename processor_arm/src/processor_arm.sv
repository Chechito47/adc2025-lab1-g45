// PIPELINED PROCESSOR

module processor_arm #(parameter N = 64)
							(input logic [15:0] i_sw,
                             input logic i_mclk,
                             input logic i_reset,
                             output logic [15:0] o_led,
                             output [7:0] D0_seg, D1_seg,
                             output [3:0] D0_a, D1_a,
						  	 input	logic dump);
							
	logic [31:0] q;		
	logic [3:0] AluControl;
	logic reg2loc, regWrite, AluSrc, Branch, memtoReg, memRead, memWrite, mclk;
	logic [N-1:0] IM_address, DM_writeData, DM_addr, DM_readData;  
	logic [N-1:0] dp_readData;
	logic [10:0] instr;
	logic [28:0] cnt29 = 29'd0;
	
	controller 		c 			(.instr(instr), 
									.AluControl(AluControl), 
									.reg2loc(reg2loc), 
									.regWrite(regWrite), 
									.AluSrc(AluSrc), 
									.Branch(Branch),
									.memtoReg(memtoReg), 
									.memRead(memRead), 
									.memWrite(memWrite));
														
					
	datapath #(64) dp 		(.reset(i_reset), 
									.clk(mclk), 
									.reg2loc(reg2loc), 
									.AluSrc(AluSrc), 
									.AluControl(AluControl), 
									.Branch(Branch), 
									.memRead(memRead),
									.memWrite(memWrite), 
									.regWrite(regWrite), 
									.memtoReg(memtoReg), 
									.IM_readData(q), 
									.DM_readData(dp_readData), 
									.IM_addr(IM_address), 
									.DM_addr(DM_addr), 
									.DM_writeData(DM_writeData), 
									.DM_writeEnable(DM_writeEnable), 
									.DM_readEnable(DM_readEnable));				
					
					
	imem 				instrMem (.addr(IM_address[7:2]),
									.q(q));
									
	
	dmem 				dataMem 	(.clk(mclk), 
									.memWrite(DM_writeEnable), 
									.memRead(DM_readEnable), 
									.address(DM_addr[8:3]), 
									.writeData(DM_writeData), 
									.readData(DM_readData), 
									.dump(dump)); 							
		 
							
	flopr #(11)		IF_ID_TOP(.clk(mclk),
									.reset(i_reset), 
									.d(q[31:21]), 
									.q(instr));
									
	clkDiv cD 	(.clk (i_mclk),
					.reset (i_reset),
					.clkDiv (mclk));	 
					

	always_ff @(posedge mclk)
		if (DM_addr == 64'h8008) 
		  o_led <= DM_writeData[15:0];
		
	always_comb 		
		if (DM_addr == 64'h8000) 
		     dp_readData = {48'b0, i_sw};
		else 
		     dp_readData = DM_readData;			
		     
     disp7seg_controller dispA(  .clk(cnt29[13]),
                                .bcd_dig({4'h0, 4'hC, 4'hD, 4'hA}),
                                .blank_dig(4'b0001),
                                .seg(D0_seg),
                                .dig_en(D0_a));
                                
    disp7seg_controller dispB(  .clk(cnt29[13]),
                                .bcd_dig({4'h5, 4'h2, 4'h0, 4'h2}),
                                .blank_dig(4'b0000),
                                .seg(D1_seg),
                                .dig_en(D1_a));   
                                
    always @(posedge i_mclk) cnt29 <= cnt29 + 1;						
 	
endmodule
