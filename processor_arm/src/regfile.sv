`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/02/2025 10:48:42 AM
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


module regfile #(parameter N = 64) (
    //--- Señales ---
    input logic clk, we3, we3_W,            //clock, write enable, write enable Writeback
    input logic [4:0] ra1, ra2, wa3, wa3_W, //read address 1, read address 2, write address, write address Writeback (para forwarding)
    input logic [N-1:0] wd3, wd3_W,         //write data, write data Writeback (para forwarding)
    output logic [N-1:0] rd1, rd2           //read data 1, read data 2
    
    //clk -> para habilitar la escritura
    //we3 -> indica si esta habilitada la escritura para wd3
    //we3_W -> indica si hay escritura en Writeback (para forwarding)
    //wa3 -> indica en que registro vamos a escribir
    //wa3_W -> indica en que registro se está escribiendo en Writeback (para comparar)
    //wd3 -> el contenido que vamos a escribir
    //wd3_W -> el contenido que se escribe en Writeback (para forwardear)
    
    //ra1 -> indica en que registro vamos a leer (1 de 2)
    //ra2 -> indica en que registro vamos a leer (2 de 2)
    //rd1 -> el contenido que vamos a leer (direccion dada por ra1)
    //rd2 -> el contenido que vamos a leer (direccion dada por ra2) 
    );
    
    //--- Banco de 32 registros REGS de 64 bits cada registro --- -> Unpacked array
    logic [N-1:0] REGS [0:31];
    
    //--- Inicializo registros del 0 a 30 con dicha posicion como valor ---
    initial begin
        integer i;          //Para el array
        for (i = 0; i < 31; i++) begin
            REGS[i] = i;
        end
        REGS[31] = 'b0;     //Registro 31(XZR) en 0 
    end
    
    //--- Escritura sincrona--- => como es sincrona dependo un flanco del clk
    //Verifico que no sea el registro 31
    always_ff @(posedge clk) begin
       if (we3 && (wa3 !== 5'b11111))
            REGS[wa3] <= wd3;   //<= porque estamos dentro de un always_ff 
    end
    
    //--- Lectura asincrona con forwarding interno ---
    //Verifico primero si es XZR, luego si hay forwarding desde Writeback, sino lectura normal
    assign rd1 = (ra1 == 5'b11111) ? {N{1'b0}} :              //si es XZR => 0
                 (we3_W && (ra1 == wa3_W)) ? wd3_W :          //si WB escribe este reg => forward
                 REGS[ra1];                                   //si no => leer normal
    
    assign rd2 = (ra2 == 5'b11111) ? {N{1'b0}} :              //si es XZR => 0
                 (we3_W && (ra2 == wa3_W)) ? wd3_W :          //si WB escribe este reg => forward
                 REGS[ra2];                                   //si no => leer normal

endmodule
