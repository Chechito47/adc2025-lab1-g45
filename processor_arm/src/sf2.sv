`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/08/2025 11:15:32 PM
// Design Name: 
// Module Name: sf2
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


//Toma un valor de 64bits y la desplaza 2bits a la izquierda => multiplica x 4
module sf2 #(parameter N = 64)(
    input logic [N-1:0] a,
    output logic [N-1:0] y
    );
    
    //<< desplazo a la izq y lueog cant de bits
    assign y = a << 2;
endmodule
