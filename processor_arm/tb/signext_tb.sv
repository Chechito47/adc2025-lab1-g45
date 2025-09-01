`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/31/2025 11:38:50 PM
// Design Name: 
// Module Name: signext_tb
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


module signext_tb();
    //Señales
    logic [31:0] a;
    logic [63:0] y;
    
    //Instancia del modulo
    signext dut (
        .a(a),
        .y(y)
    );
    
    initial
        begin
            $display ("\nComienzo testbench signext\n");
        
            //LDUR positivo
            a = 32'b11111000010_000000001_00_00000_00000; //inm9 = 1
            #1;
            if (y !== 64'b1)
                $display ("LDUR positivo fallo, y=%0b", y);
                
            //LDUR negativo
            a = 32'b11111000010_111111111_00_00000_00000; //inm9 = -1, complemento a 2 del anterior
            #1;
            if (y !== -64'sh1) //s -> signado, uso - para negar el 1
                $display ("LDUR negativo fallo, y=%0b", y);

            //STUR positivo
            a = 32'b11111000000_000000011_00_00000_00000; //inm9 = 3
            #1;
            if (y !== 64'h3)
                $display ("SDUR positivo fallo, y=%0b", y);

            //STUR negativo
            a = 32'b11111000000_111111101_00_00000_00000; //inm9 = -3, complmento a 2 del anterior
            #1;
            if (y !== -64'sh3)
                $display ("SDUR negativo fallo, y=%0b", y);                

            //CBZ positivo 
            a = 32'b10110100_0000000000000000101_00000; //inm19 = 5
            #1;
            if (y !== 64'h5)
                $display ("CBZ positivo fallo, y=%0b", y);

            //CBZ negativo
            a = 32'b10110100_1111111111111111011_00000; //inm19 = -5, complemento a 2 del anterior
            #1;
            if (y !== -64'sh5)
                $display ("CBZ negativo fallo, y=%0b", y);
                
            //Instruccion ajena a la tabla
            a = 32'b00000000_0000000000000000000_00000;
            #1;
            if (y !== 64'h0)
                $display ("Instruccion ajena a la tabla fallo, y=%0b", y);
        
            $display("Finalizo testbench signext\n");                      
        $finish;
    end      
endmodule
