`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/02/2025 11:59:25 AM
// Design Name: 
// Module Name: regfile_tb
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


module regfile_tb();
    parameter N = 64;

    //Señales
    logic clk, we3;
    logic [4:0] ra1, ra2, wa3;
    logic [N-1:0] wd3, rd1, rd2;
    
    //Instanciacion del modulo
    regfile dut (
        .clk(clk),
        .we3(we3),
        .ra1(ra1),
        .ra2(ra2),
        .wa3(wa3),
        .wd3(wd3),
        .rd1(rd1),
        .rd2(rd2)
    );
    
    //--- Generador de clock ----> ciclo 10ps = 100MHz
    always begin
            clk = 1; #5;
            clk = 0; #5;
    end
    
    initial begin
        $display("\nComienzo testbench regfile\n");
        //Verifico inicializacion
        for (int i = 0; i < 32; i++) begin //31 incluido
            ra1 = i;
            ra2 = i;
            #10;    //Espero un ciclo
            $display("REG[%0d], rd1=%0d, rd2=%0d", i, rd1, rd2);
        end
    
    //--- Escribo un valor en un registro y lo leo en el mismo clock ----> REG[5]
    we3 = 1;            //Indico que puedo escribir
    wa3 = 5;            //Registro en el que voy a escribir
    wd3 = {N-1{1'b1}}; //El contenido sera todos 1
    ra1 = 5;           //Indico que registro quiero leer, ra2 no es necesario
    #10;               //Escribo y leo en el mismo clock, si no lo pongo mostraria un valor viejo
                       //y si lo pongo antes del ra1 veria los valores con un ciclo de retraso
    $display("REG[5]: rd1=%h, esperado=%h", rd1, wd3);
    
    
    //--- Verifico que no se altere en contenido de un registro si we=0 ---
    //Trato de escribir sobre el registro que escribi antes
    we3 = 0;
    wd3 = {N-1{1'b0}};  //El contenido sera todos 0
    #10;
    if (rd1 !== {N-1{1'b1}})
        $display("Error, REG[5] con we3=%0b cambio: esperado=%h, rd1=%h", we3, {N-1{1'b1}}, wd3);
    else
        $display("REG[5] con we3=%0b no cambio: rd1=%h", we3, rd1);
    
    
    //--- Escribir valor distinto a 0 en el registro 31 ---
    we3 = 1;
    wa3 = 31;
    wd3 = 'hA;
    ra1 = 31;
    #10;
    $display("REG[31]: rd1=%h, esperado=0", rd1);

    $display("Finalizo testbench regfile\n");
    $finish;
    end
endmodule
