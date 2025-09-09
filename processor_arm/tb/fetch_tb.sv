`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/07/2025 09:15:44 PM
// Design Name: 
// Module Name: fetch_tb
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


module fetch_tb #(parameter N = 64)();
    //Señales
    logic PCSrc_F, clk, reset;    //Control del mux, clock y reset
    logic [N-1:0] PCBranch_F;     //Direccion del branch
    logic [N-1:0] imem_addr_F;    //Direccion de la instruccion
    
    fetch dut (
        .PCSrc_F(PCSrc_F),
        .clk(clk),
        .reset(reset),
        .PCBranch_F(PCBranch_F),
        .imem_addr_F(imem_addr_F)
    );
    
    //--- Generador de clock ----> ciclo 10ps = 100MHz
    always begin
            clk = 1; #5;
            clk = 0; #5;
    end
    
    //Inicio con reset = 1 por 5 ciclos -> repeat 5
    initial begin
        $display("\nComienzo testbench fetch\n");
        //Inicializo señales
        PCSrc_F = 0;
        PCBranch_F = 64'h0;
        reset = 1;
        repeat (5) @(posedge clk);
    
        //Inicio con PCBranch_F con valor fijo
        PCBranch_F = 64'h0000_00A0;
        PCSrc_F = 0;    //Quiero lo que sale del adder
    
        //Cambio a reset=0 despues de 5 flancos, muestro PC antes del cambio
        reset = 0;
        @(posedge clk);
        $display("PC antes de incremento: %0d", imem_addr_F);
        
        //Incremento del PC
        repeat (5) begin
            @(posedge clk);
            $display("PC despues del incremento: %0d", imem_addr_F);
        end
        
        //Quiero ahora la entrada del PCBranch_F y no lo que sale del adder
        PCSrc_F = 1;
        repeat (2) @(posedge clk); //Tengo que esperar dos flancos para que sea actulice bien el valor
        $display("PC branch esperado: %0d, resultado: %0d", PCBranch_F, imem_addr_F);
        
        $display("Finalizo testbench fetch\n");
        $finish;
    end
endmodule
