`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/01/2025 09:24:47 PM
// Design Name: 
// Module Name: imem
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


module imem #(parameter N = 32) (
    //addr = 7 ya que 2^7 = 128
    //addr sirve para indicar que palabra de esas 128 va a leer, es un indice nomas
    input logic [7:0] addr,
    output logic [N-1:0] q
    );
    
    //Uso unpacked arrays, ROM tiene 128 elementos(palabras en este caso) de 32bits c/u
    //Inicializo cada palabra en 0
    logic [N-1:0] ROM [0:255] = '{default: 'b0};
    
    //Cargo las palabras
    initial begin
ROM [0:53] ='{32'hD371C034,
32'h8b1f03ff,
32'h8b1f03ff,
32'h8b1f03ff,
32'hd37d3c35,
32'h8b1f03ff,
32'h8b1f03ff,
32'h8b1f03ff,
32'haa0102b5,
32'h8b1f03ff,
32'h8b1f03ff,
32'h8b1f03ff,
32'hD37F3C36,
32'h8b1f03ff,
32'h8b1f03ff,
32'h8b1f03ff,
32'haa1602b5,
32'h8b1f03ff,
32'h8b1f03ff,
32'h8b1f03ff,
32'hD37E3C36,
32'h8b1f03ff,
32'h8b1f03ff,
32'h8b1f03ff,
32'haa1602b5,
32'h8b1f03ff,
32'h8b1f03ff,
32'h8b1f03ff,
32'hf8000295,
32'h8b1f03ff,
32'h8b1f03ff,
32'h8b1f03ff,
32'h8b1f03ff,
32'h8b1f03ff,
32'h8b1f03ff,
32'h8b1f03ff,
32'h8b1f03ff,
32'hD37E3C37,
32'h8b1f03ff,
32'h8b1f03ff,
32'h8b1f03ff,
32'hD37D3C38,
32'h8b1f03ff,
32'h8b1f03ff,
32'h8b1f03ff,
32'haa1802f7,
32'h8b1f03ff,
32'h8b1f03ff,
32'h8b1f03ff,
32'hf8000297,
32'h8b1f03ff,
32'h8b1f03ff,
32'h8b1f03ff,
32'hb400001f};



        //Del 91 al 127 ya estan en 0 por el default
    end

    //La salida es el ROM que toma un addr, con esto hago la lectura
    assign q = ROM[addr];
endmodule
