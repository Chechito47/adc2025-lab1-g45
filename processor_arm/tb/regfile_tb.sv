`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02.09.2025 20:36:16
// Design Name: 
// Module Name: regfile_tb
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


module regfile_tb();
  // param:
  parameter CNT_MAX_TESTS = 10000;
  parameter N = 64;
  
  // señales de test
  logic clk, reset_tb;
  logic [N-1 : 0] rd1_expected, rd2_expected, wd3_auxiliar;

  int fd, error_code, cnt_tests, test_number, test_type, cnt_errors;
  string input_file_path, line;

  logic wr_en3_in[0 : CNT_MAX_TESTS];
  logic [4 : 0] ra1_in[0 : CNT_MAX_TESTS], ra2_in[0 : CNT_MAX_TESTS], wa3_in[0 : CNT_MAX_TESTS];
  logic [N-1 : 0] wd3_in[0 : CNT_MAX_TESTS], rd1_in[0 : CNT_MAX_TESTS], rd2_in[0 : CNT_MAX_TESTS];

  // modulos:
  logic wr_en3;
  logic [4 : 0] ra1, ra2, wa3;
  logic [N-1 : 0] wd3, rd1, rd2;

 //dut
  regfile #(N) dut (
      .clk(clk),
      .wr_en3(wr_en3),
      .read_add1(ra1),
      .read_add2(ra2),
      .write_add3(wa3),
      .write_d3(wd3),
      .read_d1(rd1),
      .read_d2(rd2)
  );

  // clock 
  always begin
    clk = 1;
    #5ns;
    clk = 0;
    #5ns;
  end

  initial begin
    cnt_tests = 0;
    test_number = 0;
    cnt_errors = 0;

    // obtener path al archivo de entrada
    input_file_path = `__FILE__;
    for (int i = input_file_path.len(); i >= 0; i--) begin
      if (input_file_path[i] == "/") begin
        input_file_path = input_file_path.substr(0, i);
        break;
      end
    end

    // abrir 
    fd = $fopen({input_file_path, "input-files/regfile_tb_in"}, "r");
    if (fd === 0) begin
      $display("ERROR: no se pudo abrir archivo de entrada");
      $stop;
    end

    while (!$feof(fd)) begin
      error_code = $fgets(line, fd);
      if (line === "" || line === "\n" || line.substr(0, 1) === "//") continue;
      error_code = $sscanf(
          line,
          "%d %d %d %d %d %d %d",
          wr_en3_in[cnt_tests],
          ra1_in[cnt_tests],
          ra2_in[cnt_tests],
          wa3_in[cnt_tests],
          wd3_in[cnt_tests],
          rd1_in[cnt_tests],
          rd2_in[cnt_tests]
      );
      cnt_tests++;
    end

    $fclose(fd);

    // reset 
    reset_tb = 1;
    #27ns;
    reset_tb = 0;
  end

  // bucle test
  always @(negedge clk) begin
    if (~reset_tb) begin
      test_type = 0;

      if (wr_en3 === 1'b1) begin
        test_type = 1;
        wr_en3 = 1'b0;
      end

      if ({rd1, rd2} !== {rd1_expected, rd2_expected}) begin
        $display("Error en %s test #%d con input = { wr_en3=%b, ra1=%d, ra2=%d, wa3=%d, wd3=%d } \
                  --> output = { rd1=%d, rd2=%d }, esperado = { rd1=%d, rd2=%d }",
                  (test_type ? "escritura" : "lectura"),
                  test_number, (test_type ? 1'b1 : 1'b0), ra1, ra2, wa3, wd3,
                  rd1, rd2, rd1_expected, rd2_expected);
        cnt_errors++;
      end

      test_number++;
      if (test_number === cnt_tests) begin
        $display("%d tests completados con %d errores", cnt_tests, cnt_errors);
        #5ns;
        $stop;
      end
    end

    // preparar siguiente test
    #2ns;
    wr_en3 = wr_en3_in[test_number];
    ra1 = ra1_in[test_number];
    ra2 = ra2_in[test_number];
    wa3 = wa3_in[test_number];
    wd3 = wd3_in[test_number];
    rd1_expected = rd1_in[test_number];
    rd2_expected = rd2_in[test_number];
    #2ns;
  end


endmodule
