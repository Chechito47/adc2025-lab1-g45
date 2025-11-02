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
    input logic [6:0] addr,
    output logic [N-1:0] q
    );
    
    //Uso unpacked arrays, ROM tiene 128 elementos(palabras en este caso) de 32bits c/u
    //Inicializo cada palabra en 0
    logic [N-1:0] ROM [0:127] = '{default: 'b0};
    
    //Cargo las palabras
    initial begin
        ROM [0:96] ='{32'hf8000001,
32'hf8008002,
32'hf8000203,
32'h8b050083,
32'h8b1f03ff,
32'h8b1f03ff,
32'hf8018003,
32'hcb050083,
32'h8b1f03ff,
32'h8b1f03ff,
32'hf8020003,
32'hcb0a03e4,
32'h8b1f03ff,
32'h8b1f03ff,
32'hf8028004,
32'h8b040064,
32'h8b1f03ff,
32'h8b1f03ff,
32'hf8030004,
32'hcb030025,
32'h8b1f03ff,
32'h8b1f03ff,
32'hf8038005,
32'h8a1f0145,
32'h8b1f03ff,
32'h8b1f03ff,
32'hf8040005,
32'h8a030145,
32'h8b1f03ff,
32'h8b1f03ff,
32'hf8048005,
32'h8a140294,
32'h8b1f03ff,
32'h8b1f03ff,
32'hf8050014,
32'haa1f0166,
32'h8b1f03ff,
32'h8b1f03ff,
32'hf8058006,
32'haa030166,
32'h8b1f03ff,
32'h8b1f03ff,
32'hf8060006,
32'hf840000c,
32'h8b1f03ff,
32'h8b1f03ff,
32'h8b1f0187,
32'h8b1f03ff,
32'h8b1f03ff,
32'hf8068007,
32'hf807000c,
32'h8b0e01bf,
32'hf807801f,
32'hb4000080,
32'h8b1f03ff,
32'h8b1f03ff,
32'hf8080015,
32'hf8088015,
32'h8b0103e2,
32'h8b1f03ff,
32'h8b1f03ff,
32'hcb010042,
32'h8b1f03ff,
32'h8b1f03ff,
32'h8b0103f8,
32'h8b1f03ff,
32'h8b1f03ff,
32'hf8090018,
32'h8b080000,
32'h8b1f03ff,
32'h8b1f03ff,
32'hb4fffec2,
32'h8b1f03ff,
32'h8b1f03ff,
32'hf809001e,
32'h8b1f03ff,
32'h8b1f03ff,
32'h8b1e03de,
32'h8b1f03ff,
32'h8b1f03ff,
32'hcb1503f5,
32'h8b1f03ff,
32'h8b1f03ff,
32'h8b1403de,
32'h8b1f03ff,
32'h8b1f03ff,
32'hf85f83d9,
32'h8b1f03ff,
32'h8b1f03ff,
32'h8b1e03de,
32'h8b1f03ff,
32'h8b1f03ff,
32'h8b1003de,
32'h8b1f03ff,
32'h8b1f03ff,
32'hf81f83d9,
32'hb400001f};

        //Del 91 al 127 ya estan en 0 por el default
    end

    //La salida es el ROM que toma un addr, con esto hago la lectura
    assign q = ROM[addr];
endmodule
