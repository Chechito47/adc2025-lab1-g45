`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/01/2025 03:52:10 PM
// Design Name: 
// Module Name: alu
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


module alu
    #(parameter size = 64) (
        //Señales
        input logic [size-1:0] a, b,
        input logic [3:0] ALUControl,
        output logic [size-1:0] result,
        output logic zero
    );
    
    always_comb begin
        case(ALUControl)
            4'b0000: result = a & b;    //AND
            4'b0001: result = a | b;    //OR
            4'b0010: result = a + b;    //ADD
            4'b1001: result = a << b[5:0]; // LSL
            4'b1000: result = a >> b[5:0]; // LSR
            4'b0110: result = a - b;    //SUB
            4'b0111: result = b;        //Pass input b
            default: result = 'b0;      //Resto de caso
        endcase
    end
    
    // assign zero = (result == 'b0);
    always_comb begin
        if (result == 'b0)
            zero = 1'b1;
        else
            zero = 1'b0;
    end

endmodule
