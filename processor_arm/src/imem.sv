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
        ROM[0]  = 32'hf8000001;   // STUR X1, [X0, #0]
        ROM[1]  = 32'hf8008002;   // STUR X2, [X0, #8]
        ROM[2]  = 32'hf8000203;   // STUR X3, [X16, #0]
        ROM[3]  = 32'h8b050083;   // ADD X3, X4, X5
        ROM[4]  = 32'h8b1f03ff;   // NOP
        ROM[5]  = 32'h8b1f03ff;   // NOP
        ROM[6]  = 32'hf8018003;   // STUR X3, [X0, #24]
        ROM[7]  = 32'hcb050083;   // SUB X3, X4, X5
        ROM[8]  = 32'h8b1f03ff;   // NOP ← AGREGAR
        ROM[9]  = 32'h8b1f03ff;   // NOP ← AGREGAR
        ROM[10] = 32'hf8020003;   // STUR X3, [X0, #32]
        ROM[11] = 32'hcb0a03e4;   // SUB X4, XZR, X10
        ROM[12] = 32'h8b1f03ff;   // NOP ← AGREGAR
        ROM[13] = 32'h8b1f03ff;   // NOP ← AGREGAR
        ROM[14] = 32'hf8028004;   // STUR X4, [X0, #40]
        ROM[15] = 32'h8b040064;   // ADD X4, X3, X4
        ROM[16] = 32'h8b1f03ff;   // NOP ← AGREGAR
        ROM[17] = 32'h8b1f03ff;   // NOP ← AGREGAR
        ROM[18] = 32'hf8030004;   // STUR X4, [X0, #48]
        ROM[19] = 32'hcb030025;   // SUB X5, X1, X3
        ROM[20] = 32'h8b1f03ff;   // NOP ← AGREGAR
        ROM[21] = 32'h8b1f03ff;   // NOP ← AGREGAR
        ROM[22] = 32'hf8038005;   // STUR X5, [X0, #56]
        ROM[23] = 32'h8a1f0145;   // AND X5, X10, XZR
        ROM[24] = 32'h8b1f03ff;   // NOP ← AGREGAR
        ROM[25] = 32'h8b1f03ff;   // NOP ← AGREGAR
        ROM[26] = 32'hf8040005;   // STUR X5, [X0, #64]
        ROM[27] = 32'h8a030145;   // AND X5, X10, X3
        ROM[28] = 32'h8b1f03ff;   // NOP ← AGREGAR
        ROM[29] = 32'h8b1f03ff;   // NOP ← AGREGAR
        ROM[30] = 32'hf8048005;   // STUR X5, [X0, #72]
        ROM[31] = 32'h8a140294;   // AND X20, X20, X20
        ROM[32] = 32'h8b1f03ff;   // NOP ← AGREGAR
        ROM[33] = 32'h8b1f03ff;   // NOP ← AGREGAR
        ROM[34] = 32'hf8050014;   // STUR X20, [X0, #80]
        ROM[35] = 32'haa1f0166;   // ORR X6, X11, XZR
        ROM[36] = 32'h8b1f03ff;   // NOP ← AGREGAR
        ROM[37] = 32'h8b1f03ff;   // NOP ← AGREGAR
        ROM[38] = 32'hf8058006;   // STUR X6, [X0, #88]
        ROM[39] = 32'haa030166;   // ORR X6, X11, X3
        ROM[40] = 32'h8b1f03ff;   // NOP ← AGREGAR
        ROM[41] = 32'h8b1f03ff;   // NOP ← AGREGAR
        ROM[42] = 32'hf8060006;   // STUR X6, [X0, #96]
        ROM[43] = 32'hf840000c;   // LDUR X12, [X0, #0]
        ROM[44] = 32'h8b1f03ff;   // NOP ← AGREGAR
        ROM[45] = 32'h8b1f03ff;   // NOP ← AGREGAR
        ROM[46] = 32'h8b1f0187;   // ADD X7, X12, XZR
        ROM[47] = 32'h8b1f03ff;   // NOP ← AGREGAR
        ROM[48] = 32'h8b1f03ff;   // NOP ← AGREGAR
        ROM[49] = 32'hf8068007;   // STUR X7, [X0, #104]
        ROM[50] = 32'hf807000c;   // STUR X12, [X0, #112]
        ROM[51] = 32'h8b0e01bf;   // ADD XZR, X13, X14
        ROM[52] = 32'hf807801f;   // STUR XZR, [X0, #120]
        ROM[53] = 32'hb4000040;   // CBZ X0, L1
        ROM[54] = 32'hf8080015;   // STUR X21, [X0, #128]
        ROM[55] = 32'hf8088015;   // L1: STUR X21, [X0, #136]
        ROM[56] = 32'h8b0103e2;   // ADD X2, XZR, X1
        ROM[57] = 32'h8b1f03ff;   // NOP ← AGREGAR (X2 se usa después)
        ROM[58] = 32'h8b1f03ff;   // NOP ← AGREGAR
        ROM[59] = 32'hcb010042;   // L2: SUB X2, X2, X1
        ROM[60] = 32'h8b1f03ff;   // NOP ← AGREGAR (X2 se escribe y se lee en CBZ)
        ROM[61] = 32'h8b1f03ff;   // NOP ← AGREGAR
        ROM[62] = 32'h8b0103f8;   // ADD X24, XZR, X1
        ROM[63] = 32'h8b1f03ff;   // NOP ← AGREGAR (X24 se usa después)
        ROM[64] = 32'h8b1f03ff;   // NOP ← AGREGAR
        ROM[65] = 32'hf8090018;   // STUR X24, [X0, #144]
        ROM[66] = 32'h8b080000;   // ADD X0, X0, X8
        ROM[67] = 32'h8b1f03ff;   // NOP ← AGREGAR (X0 se usa en CBZ)
        ROM[68] = 32'h8b1f03ff;   // NOP ← AGREGAR
        ROM[69] = 32'hb4ffff82;   // CBZ X2, L2 (branch si X2=0)
        ROM[70] = 32'hf809001e;   // STUR X30, [X0, #144]
        ROM[71] = 32'h8b1e03de;   // ADD X30, X30, X30
        ROM[72] = 32'h8b1f03ff;   // NOP ← AGREGAR (X30 se usa después)
        ROM[73] = 32'h8b1f03ff;   // NOP ← AGREGAR
        ROM[74] = 32'hcb1503f5;   // SUB X21, XZR, X21
        ROM[75] = 32'h8b1f03ff;   // NOP ← AGREGAR (X21 se escribe)
        ROM[76] = 32'h8b1f03ff;   // NOP ← AGREGAR
        ROM[77] = 32'h8b1403de;   // ADD X30, X30, X20
        ROM[78] = 32'h8b1f03ff;   // NOP ← AGREGAR (X30 se usa en LDUR)
        ROM[79] = 32'h8b1f03ff;   // NOP ← AGREGAR
        ROM[80] = 32'hf85f83d9;   // LDUR X25, [X30, #-8]
        ROM[81] = 32'h8b1f03ff;   // NOP ← AGREGAR (X25 se carga)
        ROM[82] = 32'h8b1f03ff;   // NOP ← AGREGAR
        ROM[83] = 32'h8b1e03de;   // ADD X30, X30, X30
        ROM[84] = 32'h8b1f03ff;   // NOP ← AGREGAR (X30 se usa después)
        ROM[85] = 32'h8b1f03ff;   // NOP ← AGREGAR
        ROM[86] = 32'h8b1003de;   // ADD X30, X30, X16
        ROM[87] = 32'h8b1f03ff;   // NOP ← AGREGAR (X30 se usa en STUR)
        ROM[88] = 32'h8b1f03ff;   // NOP ← AGREGAR
        ROM[89] = 32'hf81f83d9;   // STUR X25, [X30, #-8]
        ROM[90] = 32'hb400001f;   // finloop: CBZ XZR, finloop
        //Del 91 al 127 ya estan en 0 por el default
    end

    //La salida es el ROM que toma un addr, con esto hago la lectura
    assign q = ROM[addr];
endmodule
