`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/30/2025 10:30:58 PM
// Design Name: 
// Module Name: flopr_tb
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


module flopr_tb();
    //Tamaño de N
    parameter N = 64;
    
    //Señales
    logic clk, rst;
    logic [N-1:0] d;
    logic [N-1:0] q;
    
    //Instancia del modulo flopr
    flopr #(.N(N)) dut (
        .clk(clk),
        .reset(rst),
        .d(d),
        .q(q)
    );
    
    //Generador del clock -> Ciclo=10ps=100MHz
    always //Sin lista de sensibilidad => se ejecuta siempre
        begin
            clk = 1; #5;
            clk = 0; #5;
        end
 
 initial begin
    $display("\nComienzo testbench");
    //Valores iniciales
    rst = 1;
    d = '0; //Aca no me importa si es hexa, binario o lo que fuere
    
    @(posedge clk);
     //Ingreso un valor por cada ciclo de reloj 
     d = 64'h1; @(posedge clk);
     if (q !== 64'h0)
        $display("Error con q=0, d=1");
        
     d = 64'h2; @(posedge clk);
     if (q !== 64'h0)
        $display("Error con q=0, d=2");
        
     d = 64'h3; @(posedge clk);
     if (q !== 64'h0)
        $display("Error con q=0, d=3");
        
     d = 64'h4; @(posedge clk);
     if (q !== 64'h0)
        $display("Error con q=0, d=4");
        
     d = 64'h5; @(posedge clk);
     if (q !== 64'h0)
        $display("Error con q=0, d=5");
 

    //Desactivo el reset
    rst = 0;
    
     d = 64'h6; @(posedge clk);
     if (q !== 64'h6)
        $display("Error con q=0, d=1");
        
     d = 64'h7; @(posedge clk);
     if (q !== 64'h7)
        $display("Error con q=0, d=2");
        
     d = 64'h8; @(posedge clk);
     if (q !== 64'h8)
        $display("Error con q=0, d=3");
        
     d = 64'h9; @(posedge clk);
     if (q !== 64'h9)
        $display("Error con q=0, d=4");
        
     d = 64'hA; @(posedge clk);
     if (q !== 64'hA)
        $display("Error con q=0, d=5"); 
 
        $finish;
    end
endmodule
