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
    parameter N = 4;
    
    //Señales
    logic clk, rst;
    logic [N-1:0] d;
    logic [N-1:0] q;
    
    //Instancia
    flopr tb(clk, rst, d, q);
    
    //Generador de clock
    always // no sensitivity list, so it always executes
        begin
            clk = 1; #5; clk = 0; #5;
        end
 
    initial begin
        //Reset inicial
        rst = 1; d = '0; #12;
        if (q !== '0)
            $display("reset inicial fallo");
        
        //Reset = 0
        rst = 0; d = 4'b1010; #10;
        if (q !== 4'b1010)
            $display("1010 fallo"); 
        //Veo el siguiente sin cambiar el reset
        d = 4'b1011; #10;
        if (q !== 4'b1011)
            $display("1011 fallo");
            
        //Reset = 1
        rst = 1; #2;
        if (q !== '0)
            $display("Fallo q!=0");
        
        d = 4'b1111; #10;
        if(q !== 4'b1111)
            $display("1111 fallo");
         
         $stop;
    end
endmodule
