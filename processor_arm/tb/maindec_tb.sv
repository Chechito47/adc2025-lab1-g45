`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/02/2025 09:31:58 PM
// Design Name: 
// Module Name: maindec_tb
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


module maindec_tb();
    logic [10:0] Op;
    logic Reg2Loc, ALUSrc, MemtoReg, RegWrite, MemRead, MemWrite, Branch;
    logic [1:0] ALUOp;
    
    maindec dut(
        .Op(Op),
        .Reg2Loc(Reg2Loc),
        .ALUSrc(ALUSrc),
        .MemtoReg(MemtoReg),
        .RegWrite(RegWrite),
        .MemRead(MemRead),
        .MemWrite(MemWrite),
        .Branch(Branch),
        .ALUOp(ALUOp)
    );
    
    initial begin
        $display("\nComienzo testbench maindec\n");
        //LDUR
        Op = 11'b111_1100_0010; #1;
        $display("LDUR -> Reg2Loc=%0b, ALUSrc=%0b, MemtoReg=%0b, RegWrite=%0b, MemRead=%0b, MemWrite=%0b, Branch=%0b, ALUOp=%02b", Reg2Loc, ALUSrc, MemtoReg, RegWrite, MemRead, MemWrite, Branch, ALUOp); 
        
        
        //STUR
        Op = 11'b111_1100_0000; #1;
        $display("STUR -> Reg2Loc=%0b, ALUSrc=%0b, MemtoReg=%0b, RegWrite=%0b, MemRead=%0b, MemWrite=%0b, Branch=%0b, ALUOp=%02b", Reg2Loc, ALUSrc, MemtoReg, RegWrite, MemRead, MemWrite, Branch, ALUOp); 
        
        
        //CBZ
        Op = 11'b101_1010_0???; #1;
        $display("CBZ  -> Reg2Loc=%0b, ALUSrc=%0b, MemtoReg=%0b, RegWrite=%0b, MemRead=%0b, MemWrite=%0b, Branch=%0b, ALUOp=%02b", Reg2Loc, ALUSrc, MemtoReg, RegWrite, MemRead, MemWrite, Branch, ALUOp); 
        
        
        //ADD
        Op = 11'b100_0101_1000; #1;
        $display("ADD  -> Reg2Loc=%0b, ALUSrc=%0b, MemtoReg=%0b, RegWrite=%0b, MemRead=%0b, MemWrite=%0b, Branch=%0b, ALUOp=%02b", Reg2Loc, ALUSrc, MemtoReg, RegWrite, MemRead, MemWrite, Branch, ALUOp); 
        
        
        //SUB
        Op = 11'b110_0101_1000; #1;
        $display("SUB  -> Reg2Loc=%0b, ALUSrc=%0b, MemtoReg=%0b, RegWrite=%0b, MemRead=%0b, MemWrite=%0b, Branch=%0b, ALUOp=%02b", Reg2Loc, ALUSrc, MemtoReg, RegWrite, MemRead, MemWrite, Branch, ALUOp); 
        
        
        //AND
        Op = 11'b100_0101_0000; #1;
        $display("AND  -> Reg2Loc=%0b, ALUSrc=%0b, MemtoReg=%0b, RegWrite=%0b, MemRead=%0b, MemWrite=%0b, Branch=%0b, ALUOp=%02b", Reg2Loc, ALUSrc, MemtoReg, RegWrite, MemRead, MemWrite, Branch, ALUOp); 
        
        
        //ORR
        Op = 11'b101_0101_0000; #1;
        $display("ORR  -> Reg2Loc=%0b, ALUSrc=%0b, MemtoReg=%0b, RegWrite=%0b, MemRead=%0b, MemWrite=%0b, Branch=%0b, ALUOp=%02b", Reg2Loc, ALUSrc, MemtoReg, RegWrite, MemRead, MemWrite, Branch, ALUOp); 
        
        
        //Caso default
        Op = 11'b111_1111_1111; #1;
        $display("default -> Reg2Loc=%0b, ALUSrc=%0b, MemtoReg=%0b, RegWrite=%0b, MemRead=%0b, MemWrite=%0b, Branch=%0b, ALUOp=%02b", Reg2Loc, ALUSrc, MemtoReg, RegWrite, MemRead, MemWrite, Branch, ALUOp); 
        
        
        $display("Finalizo testbench maindec\n");
        $finish;
    end
endmodule
