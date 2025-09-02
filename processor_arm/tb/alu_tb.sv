`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/01/2025 04:14:53 PM
// Design Name: 
// Module Name: alu_tb
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


module alu_tb
    #(parameter size = 64) ();
        //Entradas
        logic [size-1:0] a, b;
        logic [3:0] ALUControl;
        
        //Salidas
        logic [size-1:0] result;
        logic zero;
        
        //Instanciacion del modulo
        alu dut (
            .a(a),
            .b(b),
            .ALUControl(ALUControl),
            .result(result),
            .zero(zero)
        );
        
        //Señales para el test
        logic [size-1:0] pos1, pos2, neg1, neg2;
        
        //Casos de test
        initial begin
            pos1 = {{size-4{1'b0}}, 4'b1010};   //A
            pos2 = {{size-4{1'b0}}, 4'b0101};   //5
            neg1 = {{size-4{1'b1}}, 4'b0100};   //-C 1100 -> 0011 + 1 => 0100
            neg2 = {{size-4{1'b1}}, 4'b1101};   //-3 0011 -> 1100 + 1 => 1101
            $display ("\nComienzo testbench alu\n");
           
           //---AND---
           //Caso positivo
           a = pos1; b = pos2;
           ALUControl = 4'b0000; #1; //Indico AND en el ALUControl
           if (result !== {{size-4{1'b0}}, 4'b0000}) //Valor esperado
                $display("AND pos & pos fallo: result=%0b, zero=%b", result, zero);
                 
           //Caso negativo
           a = neg1; b = neg2; #1;
           if (result !== {{size-4{1'b1}}, 4'b0100}) //Valor esperado
                $display("AND neg & neg fallo: result=%0b, zero=%b", result, zero);

           //Caso positivo y negativo
           a = pos1; b = neg1; #1;
           if (result !== {{size-4{1'b0}}, 4'b0000}) //Valor esperado
                $display("AND pos & neg fallo: result=%0b, zero=%b", result, zero);



           //---OR---
           //Caso positivo
           a = pos1; b = pos2;
           ALUControl = 4'b0001; #1; //Indico OR en el ALUControl
           if (result !== {{size-4{1'b0}}, 4'b1111}) //Valor esperado
                $display("OR pos & pos fallo: result=%0b, zero=%b", result, zero);
                 
           //Caso negativo
           a = neg1; b = neg2; #1;
           if (result !== {{size-4{1'b1}}, 4'b1101}) //Valor esperado
                $display("OR neg & neg fallo: result=%0b, zero=%b", result, zero);

           //Caso positivo y negativo
           a = pos1; b = neg1; #1;
           if (result !== {{size-4{1'b1}}, 4'b1110}) //Valor esperado
                $display("AND pos & neg fallo: result=%0b, zero=%b", result, zero);



           //---ADD---
           //Caso positivo
           a = pos1; b = pos2;
           ALUControl = 4'b0010; #1; //Indico AND en el ALUControl
           if (result !== (pos1 + pos2)) //Valor esperado
                $display("ADD pos & pos fallo: result=%0b, zero=%b", result, zero);
                 
           //Caso negativo
           a = neg1; b = neg2; #1;
           if (result !== (neg1 + neg2)) //Valor esperado
                $display("ADD neg & neg fallo: result=%0b, zero=%b", result, zero);

           //Caso positivo y negativo
           a = pos1; b = neg1; #1;
           if (result !== (pos1 + neg1)) //Valor esperado
                $display("ADD pos & neg fallo: result=%0b, zero=%b", result, zero);



           //---SUB---
           //Caso positivo
           a = pos1; b = pos2;
           ALUControl = 4'b0011; #1; //Indico AND en el ALUControl
           if (result !== (pos1 - pos2)) //Valor esperado
                $display("SUB pos & pos fallo: result=%0b, zero=%b", result, zero);
                 
           //Caso negativo
           a = neg1; b = neg2; #1;
           if (result !== (neg1 - neg2)) //Valor esperado
                $display("SUB neg & neg fallo: result=%0b, zero=%b", result, zero);

           //Caso positivo y negativo
           a = pos1; b = neg1; #1;
           if (result !== (pos1 - neg1)) //Valor esperado
                $display("SUB pos & neg fallo: result=%0b, zero=%b", result, zero);



           //---Pass input b---
           //Caso positivo
           a = pos1; b = pos2;
           ALUControl = 4'b0100; #1; //Indico AND en el ALUControl
           if (result !== b) //Valor esperado
                $display("Pass input b pos & pos fallo: result=%0b, zero=%b", result, zero);
                 
           //Caso negativo
           a = neg1; b = neg2; #1;
           if (result !== b) //Valor esperado
                $display("Pass input b neg & neg fallo: result=%0b, zero=%b", result, zero);

           //Caso positivo y negativo
           a = pos1; b = neg1; #1;
           if (result !== b) //Valor esperado
                $display("Pass input b pos & neg fallo: result=%0b, zero=%b", result, zero);
           
           
                
           //Caso Overflow
           a = 64'h7FFFFFFFFFFFFFFF; b = 1; //Valor maximo posible con 64bits
           ALUControl = 4'b0010; #1; //ALUControl en ADD
           $display("Overflow: result=%0b, zero=%b", result, zero);
           
           
           
           //Caso zero
           a = 10; b = 10; //Valores para restar
           ALUControl = 4'b0011; #1; //ALUControl en SUB
           $display("Caso zero: result=%0b, zero=%b", result, zero);
           
           $display ("Finalizo testbench alu\n");
        $finish;
    end
endmodule
