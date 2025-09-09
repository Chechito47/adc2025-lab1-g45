`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/08/2025 01:03:46 PM
// Design Name: 
// Module Name: execute
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


module execute #(parameter N = 64)(
    input logic AluSrc,
    input logic [3:0] AluControl,
    input logic [N-1:0] PC_E, signImm_E, readData1_E, readData2_E,
    output logic [N-1:0] PCBranch_E, aluResult_E, writeData_E,
    output logic zero_E
    );
    
    //Declaro señales necesarias -> salidas que no contempla la consigna
    logic [N-1:0] mux_result, sf2_result;
    
    //Instancio el mux2
    mux2 #(N) MUX (
        .d0(readData2_E),
        .d1(signImm_E),
        .s(AluSrc),
        .y(mux_result)
    );
    
    //Instancio la ALU
    alu #(N) ALU (
        .a(readData1_E),
        .b(mux_result),
        .ALUControl(AluControl),
        .result(aluResult_E),
        .zero(zero_E)
    );
    
    //Instancio el shift left 2
    sf2 #(N) SF2 (
        .a(signImm_E),
        .y(sf2_result)
    );
    
    //Instancio el adder
    adder #(N) ADD (
        .pc_in1(PC_E),
        .pc_in2(sf2_result),
        .pc_out(PCBranch_E)
    );
    
    assign writeData_E = readData2_E;
endmodule
