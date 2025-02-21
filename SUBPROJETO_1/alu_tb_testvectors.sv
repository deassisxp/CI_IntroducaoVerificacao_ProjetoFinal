module alu_tb_testvectors;
  reg clock, reset;
  reg [7:0] A, B;
  reg [3:0] ALU_Sel;
  wire [7:0] ALU_Out;
  wire CarryOut;

  alu dut(clock, reset, A, B, ALU_Sel, ALU_Out, CarryOut);

  integer file;
  integer tests = 0, errors = 0;
  string line;
  int scan_result;
  
  // Variáveis para parsing
  logic [3:0] sel;
  logic [7:0] a, b, exp_out;
  logic exp_carry;

  always #5 clock = ~clock;

  initial begin
    clock = 0;
    reset = 1;
    #10 reset = 0;

    file = $fopen("testvectors.dat", "r");
    if (!file) begin
      $display("Erro ao abrir arquivo de vetores!");
      $finish;
    end

    while (!$feof(file)) begin
      $fgets(line, file);
      
      // Ignora comentários e linhas vazias
      if (line[0] == "/" || line == "") continue;
      
      // Faz parsing da linha
      scan_result = $sscanf(line, "%h %h %h %h %h", 
                           sel, a, b, exp_out, exp_carry);
      
      if (scan_result != 5) continue;

      // Aplica estímulos
      ALU_Sel = sel;
      A = a;
      B = b;
      tests++;
      
      #20; // Espera estabilização
      
      // Verifica resultados
      if (ALU_Out !== exp_out || CarryOut !== exp_carry) begin
        errors++;
        $display("[ERRO] Teste %0d:", tests);
        $display("  Entradas: Sel=%h, A=%h(%0d), B=%h(%0d)", 
                 sel, a, a, b, b);
        $display("  Saídas: Out=%h(%0d) vs Esperado=%h(%0d), Carry=%b vs Esperado=%b",
                 ALU_Out, ALU_Out, exp_out, exp_out, 
                 CarryOut, exp_carry);
      end
    end
    
    $fclose(file);
    
    // Relatório final
    $display("\nResultado da Simulação:");
    $display("Testes Executados: %0d", tests);
    $display("Testes com Erro:   %0d", errors);
    $display("Taxa de Sucesso:   %0.2f%%", (real'(tests-errors)/real'(tests))*100);
    
    #100 $finish;
  end
    initial begin
    $dumpfile("d.vcd");
    $dumpvars();
    end
endmodule
