module alu_tb_selfcheck;
    reg clock, reset;
    reg [7:0] A, B;
    reg [3:0] ALU_Sel;
    wire [7:0] ALU_Out;
    wire CarryOut;

    // Instanciação da ULA
    alu uut (
        .clock(clock),
        .reset(reset),
        .A(A),
        .B(B),
        .ALU_Sel(ALU_Sel),
        .ALU_Out(ALU_Out),
        .CarryOut(CarryOut
    ));

    // Clock Generator
    always #5 clock = ~clock;

    task check_output(input [7:0] expected, input [7:0] result);
        if (expected !== result) begin
            $display("Erro: Esperado = %d, Obtido = %d", expected, result);
        end else begin
            $display("Passou: Esperado = %d, Obtido = %d", expected, result);
        end
    endtask

    initial begin
        // Inicialização
        clock = 0;
        reset = 1;
        #10 reset = 0;

        // Teste: Soma
        A = 8'd10; B = 8'd5; ALU_Sel = 4'b0000; #10; check_output(15, ALU_Out);
        A = 8'd20; B = 8'd15; ALU_Sel = 4'b0000; #10; check_output(35, ALU_Out);

        // Teste: Subtração
        A = 8'd15; B = 8'd5; ALU_Sel = 4'b0001; #10; check_output(10, ALU_Out);
        A = 8'd50; B = 8'd30; ALU_Sel = 4'b0001; #10; check_output(20, ALU_Out);

        // Teste: Multiplicação
        A = 8'd3; B = 8'd2; ALU_Sel = 4'b0010; #10; check_output(6, ALU_Out);
        A = 8'd4; B = 8'd5; ALU_Sel = 4'b0010; #10; check_output(20, ALU_Out);

        // Teste: Divisão
        A = 8'd20; B = 8'd4; ALU_Sel = 4'b0011; #10; check_output(5, ALU_Out);
        A = 8'd30; B = 8'd5; ALU_Sel = 4'b0011; #10; check_output(6, ALU_Out);

        $finish;
    end
    initial begin
    $dumpfile("d.vcd");
    $dumpvars();
    end
endmodule
