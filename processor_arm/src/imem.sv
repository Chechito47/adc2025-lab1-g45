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
    //addr = 6 ya que 2^6 = 64
    //addr sirve para indicar que palabra de esas 64 va a leer, es un indice nomas
    input logic [5:0] addr,
    output logic [N-1:0] q
    );
    
    //Uso unpacked arrays, ROM tiene 64 elementos(palabras en este caso) de 32bits c/u
    //Inicializo cada palabra en 0
    logic [N-1:0] ROM [0:63] = '{default: 'b0};
    
    //Cargo las 47 palabras
    initial begin
        ROM[0]  = 32'hf8000001;
        ROM[1]  = 32'hf8008002;
        ROM[2]  = 32'hf8000203;
        ROM[3]  = 32'h8b050083;
        ROM[4]  = 32'hf8018003;
        ROM[5]  = 32'hcb050083;
        ROM[6]  = 32'hf8020003;
        ROM[7]  = 32'hcb0a03e4;
        ROM[8]  = 32'hf8028004;
        ROM[9]  = 32'h8b040064;
        ROM[10] = 32'hf8030004;
        ROM[11] = 32'hcb030025;
        ROM[12] = 32'hf8038005;
        ROM[13] = 32'h8a1f0145;
        ROM[14] = 32'hf8040005;
        ROM[15] = 32'h8a030145;
        ROM[16] = 32'hf8048005;
        ROM[17] = 32'h8a140294;
        ROM[18] = 32'hf8050014;
        ROM[19] = 32'haa1f0166;
        ROM[20] = 32'hf8058006;
        ROM[21] = 32'haa030166;
        ROM[22] = 32'hf8060006;
        ROM[23] = 32'hf840000c;
        ROM[24] = 32'h8b1f0187;
        ROM[25] = 32'hf8068007;
        ROM[26] = 32'hf807000c;
        ROM[27] = 32'h8b0e01bf;
        ROM[28] = 32'hf807801f;
        ROM[29] = 32'hb4000040;
        ROM[30] = 32'hf8080015;
        ROM[31] = 32'hf8088015;
        ROM[32] = 32'h8b0103e2;
        ROM[33] = 32'hcb010042;
        ROM[34] = 32'h8b0103f8;
        ROM[35] = 32'hf8090018;
        ROM[36] = 32'h8b080000;
        ROM[37] = 32'hb4ffff82;
        ROM[38] = 32'hf809001e;
        ROM[39] = 32'h8b1e03de;
        ROM[40] = 32'hcb1503f5;
        ROM[41] = 32'h8b1403de;
        ROM[42] = 32'hf85f83d9;
        ROM[43] = 32'h8b1e03de;
        ROM[44] = 32'h8b1003de;
        ROM[45] = 32'hf81f83d9;
        ROM[46] = 32'hb400001f;
        //Del 47 al 63 ya estan en 0 por el default
    end

    //La salida es el ROM que toma un addr, con esto hago la lectura
    assign q = ROM[addr];
endmodule
