`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/31/2025 10:25:40 PM
// Design Name: 
// Module Name: signext
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


module signext(
    //En este caso las 3 instrucciones son signadas
    input logic [31:0] a, //Instruccion de 32bits
    output logic [63:0] y //Inmediato extendido a 64bits
    );
    
    //LDUR o STUR [20:12] -> 9bits
    //CBZ [23:5] -> 19bits
    //Al extender signo solo nos importa mantener estos bits
    //Extendemos el bit 20 unas 55 veces en este caso y mantenemos
    //del 20 al 12. En el otro caso extendemos 45 veces el bit 23
    
    always_comb
        casez (a[31:21])
            //LDUR y STUR
            11'b111110000?0: y = {{55{a[20]}}, a[20:12]};
            
            //CBZ
            11'b10110100???: y = {{45{a[23]}}, a[23:5]};
            
            //Resto
            default: y = 'b0;
        endcase
endmodule
