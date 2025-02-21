module alu_tb_simples;
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
        .CarryOut(CarryOut)
    );

    // Clock Generator
    always #5 clock = ~clock;

    initial begin
        // Inicialização
        clock = 0;
        reset = 1;
        A = 0;
        B = 0;
        ALU_Sel = 4'b0000;
        #10 reset = 0;

        // Teste: Soma
        A = 8'd10; B = 8'd5; ALU_Sel = 4'b0000; #10;
        $display("Soma: A=%d, B=%d, ALU_Out=%d, CarryOut=%b", A, B, ALU_Out, CarryOut);
        A = 8'd20; B = 8'd15; ALU_Sel = 4'b0000; #10;
        $display("Soma: A=%d, B=%d, ALU_Out=%d, CarryOut=%b", A, B, ALU_Out, CarryOut);

        // Teste: Subtração
        A = 8'd15; B = 8'd5; ALU_Sel = 4'b0001; #10;
        $display("Subtração: A=%d, B=%d, ALU_Out=%d, CarryOut=%b", A, B, ALU_Out, CarryOut);
        A = 8'd50; B = 8'd30; ALU_Sel = 4'b0001; #10;
        $display("Subtração: A=%d, B=%d, ALU_Out=%d, CarryOut=%b", A, B, ALU_Out, CarryOut);

        // Teste: Multiplicação
        A = 8'd3; B = 8'd2; ALU_Sel = 4'b0010; #10;
        $display("Multiplicação: A=%d, B=%d, ALU_Out=%d, CarryOut=%b", A, B, ALU_Out, CarryOut);
        A = 8'd4; B = 8'd5; ALU_Sel = 4'b0010; #10;
        $display("Multiplicação: A=%d, B=%d, ALU_Out=%d, CarryOut=%b", A, B, ALU_Out, CarryOut);

        // Teste: Divisão
        A = 8'd20; B = 8'd4; ALU_Sel = 4'b0011; #10;
        $display("Divisão: A=%d, B=%d, ALU_Out=%d, CarryOut=%b", A, B, ALU_Out, CarryOut);
        A = 8'd30; B = 8'd5; ALU_Sel = 4'b0011; #10;
        $display("Divisão: A=%d, B=%d, ALU_Out=%d, CarryOut=%b", A, B, ALU_Out, CarryOut);

        $finish;
    end
    initial begin
    $dumpfile("d.vcd");
    $dumpvars();
    end
endmodule
