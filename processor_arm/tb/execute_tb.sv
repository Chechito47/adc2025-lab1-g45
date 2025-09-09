`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/08/2025 10:44:05 PM
// Design Name: 
// Module Name: execute_tb
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


module execute_tb #(parameter N = 64) ();
    //Señales
    logic AluSrc;
    logic [3:0] AluControl;
    logic [N-1:0] PC_E, signImm_E, readData1_E, readData2_E;
    logic [N-1:0] PCBranch_E, aluResult_E, writeData_E;
    logic zero_E;
    
    execute dut (
        .AluSrc(AluSrc),
        .AluControl(AluControl),
        .PC_E(PC_E),
        .signImm_E(signImm_E),
        .readData1_E(readData1_E),
        .readData2_E(readData2_E),
        .PCBranch_E(PCBranch_E),
        .aluResult_E(aluResult_E),
        .writeData_E(writeData_E),
        .zero_E(zero_E)
    );
    
    initial begin
        $display("\nComienzo testbench execute\n");
        //Inicializo señales
        AluSrc = 0; //Tomo readData2_E en el mux
        AluControl = 4'b0010;   //ADD
        PC_E = 100;
        signImm_E = 5;
        readData1_E = 10;
        readData2_E = 20;
        #5;
        
        //Verifico writeData_E = readData2_E
        $display("writeData: %0d, readData2_E: 20", writeData_E);
        
        //Verifico ALU con 0 -> entra readData2_E con readData1_E al ALU
        $display("aluResult_E: %0d, esperado: 30", aluResult_E);
        
        //Verifico ALU con 1 -> entra signImm_E con readData1_E al ALU
        AluSrc = 1;
        #5;
        $display("aluResult_E: %0d, esperado: 15", aluResult_E);
        
        //Verifico zero_E
        readData1_E = 5;
        AluControl = 4'b0011;
        #5;
        $display("aluResult_E: %0d, zero_E: %0d, esperado: 1", aluResult_E, zero_E);
        
        //Verifico PC_Branch_E = PC_E + (signImm_E << 2)
        $display("PCBranch_E: %0d, esperado: 120", PCBranch_E);
        
        $display("Finalizo testbench execute\n");
        $finish;
    end
endmodule
