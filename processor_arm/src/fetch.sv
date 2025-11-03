`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/07/2025 12:26:56 PM
// Design Name: 
// Module Name: fetch
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


module fetch #(parameter N = 64)(
    input logic PCSrc_F, clk, reset,    //Control del mux, clock y reset
    input logic [N-1:0] PCBranch_F,     //Direccion del branch
    output logic [N-1:0] imem_addr_F    //Direccion de la instruccion
    );
    
    //Registros de salida del PC, adder y mux -> 64bits
    logic [N-1:0] PC_out, adder_out, mux_out;
    //Importa el orden, primero el PC porque el adder hace PC + 4
    //ultimo el mux porque elige entre PC y PC + 4

    //FLOPR: input -> clk, reset, [N-1: 0] d; output [N-1: 0] q
    //Viene a ser el del medio en el diagrama
    flopr #(N) PC (
        .clk(clk),
        .reset(reset),
        .d(mux_out),
        .q(PC_out)
    );
    
    //ADDER: input -> [N-1:0] a, b; output -> [N-1:0] y
    adder #(N) ADD (
        .a(PC_out),
        .b(64'h4),
        .y(adder_out)
    );
    
    //MUX2: input -> s, [N-1:0] d0, d1; output [N-1:0] y
    mux2 #(N) MUX (
        .s(PCSrc_F),
        .d0(adder_out),
        .d1(PCBranch_F),
        .y(mux_out)
    );
    
    //Direccion de la instruccion (solo es para salida)
    assign imem_addr_F = PC_out;
endmodule
