`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02.09.2025 20:27:05
// Design Name: 
// Module Name: regfile
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module regfile #(
    parameter N = 64 //Ancho de palabra
   )(
   input logic clk, //clock
   input logic wr_en3, // write  
   input logic [4 : 0] read_add1, // read address 1
   input logic [4 : 0] read_add2,   // read address 2
   input logic [4 : 0] write_add3, // write address
   input logic [N-1 : 0] write_d3, // write data
   output logic [N-1:0] read_d1,  // read data 1
   output logic read_d2
    );
    
   logic [N-1:0] X[0:31];
   
   always_comb begin
    read_d1 = (wr_en3 && write_add3 != 31 && write_add3 == read_add1) ? write_d3 : X[read_add1];
    read_d2 = (wr_en3 && write_add3 != 31 && write_add3 == read_add2) ? write_d3 : X[read_add2];
  end
  always_ff @(posedge clk) begin
    if (wr_en3 && write_add3 != 31) begin
      X[write_add3] <= write_d3;
    end
  end
    // Inicialización para simulación: X0..X30 = 0..30, X31 = 0
  initial begin
    integer i;
    for (i = 0; i < 31; i = i + 1) X[i] = i;
    X[31] = '0;
  end

endmodule
