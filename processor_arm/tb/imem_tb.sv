`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/01/2025 10:28:04 PM
// Design Name: 
// Module Name: imem_tb
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


module imem_tb #(parameter N = 32)();
    //Señales
    logic [5:0] addr;
    logic [N-1:0] q;
    
    //Instanciacion del modulo
    imem dut (
        .addr(addr),
        .q(q)
    );
    
    initial begin
    //Declaro variable para el for
    integer i, errors = 0;
    
    //Valor esperado, 47+3=50
    logic [31:0] expected [0:49] = '{32'hf8000001,
                                    32'hf8008002,
                                    32'hf8000203,
                                    32'h8b050083,
                                    32'hf8018003,
                                    32'hcb050083,
                                    32'hf8020003,
                                    32'hcb0a03e4,
                                    32'hf8028004,
                                    32'h8b040064,
                                    32'hf8030004,
                                    32'hcb030025,
                                    32'hf8038005,
                                    32'h8a1f0145,
                                    32'hf8040005,
                                    32'h8a030145,
                                    32'hf8048005,
                                    32'h8a140294,
                                    32'hf8050014,
                                    32'haa1f0166,
                                    32'hf8058006,
                                    32'haa030166,
                                    32'hf8060006,
                                    32'hf840000c,
                                    32'h8b1f0187,
                                    32'hf8068007,
                                    32'hf807000c,
                                    32'h8b0e01bf,
                                    32'hf807801f,
                                    32'hb4000040,
                                    32'hf8080015,
                                    32'hf8088015,
                                    32'h8b0103e2,
                                    32'hcb010042,
                                    32'h8b0103f8,
                                    32'hf8090018,
                                    32'h8b080000,
                                    32'hb4ffff82,
                                    32'hf809001e,
                                    32'h8b1e03de,
                                    32'hcb1503f5,
                                    32'h8b1403de,
                                    32'hf85f83d9,
                                    32'h8b1e03de,
                                    32'h8b1003de,
                                    32'hf81f83d9,
                                    32'hb400001f,
                                    32'h00000000,
                                    32'h00000000,
                                    32'h00000000};
    
        $display ("\nComienzo testbench imem\n");
        //Recorro las direcciones y comparo
        for (i = 0; i < 50; i++) begin
            addr = i; #1;
            if (q !== expected[i]) begin
                $display("Error en addr=%0d: esperado=%08h, recibido=%08h", i, expected[i], q);
                errors++;
            end
        end
    
        if (errors == 0)
            $display("Funciona");
        else
            $display("Hay %0d errores", errors);
            
        $display ("\nFinalizo testbench imem\n");
        
        $finish;
    end
endmodule
