`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/04/2025 11:35:19 PM
// Design Name: 
// Module Name: adder
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


module adder #(parameter N = 64) (
    input logic [N-1:0] pc_in1, pc_in2,
    output logic [N-1:0] pc_out
    );
    
    //Con dos entradas funciona para ambos ejercicios,
    //Simplemento ponemos 64'h4 en una entrada si queremos que sume 4
    assign pc_out = pc_in1 + pc_in2;
endmodule
