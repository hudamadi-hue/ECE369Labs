`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// ECE369 - Computer Architecture
// 
// Module - ALU32Bit_tb.v
// Description - Test the 'ALU32Bit.v' module.
////////////////////////////////////////////////////////////////////////////////

module ALU32Bit_tb(); 

	reg [3:0] ALUControl;   // control bits for ALU operation
	reg [31:0] A, B;	        // inputs

	wire [31:0] ALUResult;	// answer
	wire [31:0] ALUResultHi;
	wire Zero;	        // Zero=1 if ALUResult == 0

    ALU32Bit u0(
        .ALUControl(ALUControl), 
        .A(A), 
        .B(B), 
        .ALUResult(ALUResult),
        .ALUResultHi(ALUResultHi), 
        .Zero(Zero)
    );

    initial begin

        // ADD: 10 + 20 = 30
        ALUControl = 4'b0000;
        A = 32'd10;
        B = 32'd20;
        #10;

        // ADD resulting in zero
        A = 32'd0;
        B = 32'd0;
        #10;

        // SUB: 20 - 10 = 10
        ALUControl = 4'b0001;
        A = 32'd20;
        B = 32'd10;
        #10;

        // SUB resulting in zero
        A = 32'd20;
        B = 32'd20;
        #10;

        // AND
        ALUControl = 4'b0010;
        A = 32'hF0F0F0F0;
        B = 32'h0FF00FF0;
        #10;

        // OR
        ALUControl = 4'b0011;
        A = 32'hF0F0F0F0;
        B = 32'h0FF00FF0;
        #10;

        // NOR
        ALUControl = 4'b0100;
        A = 32'hF0F0F0F0;
        B = 32'h0FF00FF0;
        #10;

        // XOR
        ALUControl = 4'b0101;
        A = 32'hF0F0F0F0;
        B = 32'h0FF00FF0;
        #10;

        // SLL: 1 << 4 = 16
        ALUControl = 4'b0110;
        A = 32'd4;
        B = 32'd1;
        #10;

        // SRL: 16 >> 4 = 1
        ALUControl = 4'b0111;
        A = 32'd4;
        B = 32'd16;
        #10;

        // SLT true: -5 < 10
        ALUControl = 4'b1000;
        A = -32'sd5;
        B = 32'd10;
        #10;

        // SLT false: 10 < -5
        A = 32'd10;
        B = -32'sd5;
        #10;

        // MUL: 10 * 20 = 200
        ALUControl = 4'b1001;
        A = 32'd10;
        B = 32'd20;
        #10;

        // MUL with a result requiring upper 32 bits
        A = 32'hFFFFFFFF;
        B = 32'hFFFFFFFF;
        #10;

        // BGEZ true
        ALUControl = 4'b1010;
        A = 32'd5;
        B = 32'd0;
        #10;

        // BGEZ false
        A = -32'sd5;
        #10;

        // BGTZ true
        ALUControl = 4'b1011;
        A = 32'd5;
        #10;

        // BGTZ false
        A = 32'd0;
        #10;

        // BLEZ true
        ALUControl = 4'b1100;
        A = 32'd0;
        #10;

        // BLEZ false
        A = 32'd5;
        #10;

        // BLTZ true
        ALUControl = 4'b1101;
        A = -32'sd5;
        #10;

        // BLTZ false
        A = 32'd5;
        #10;

        // BEQ true
        ALUControl = 4'b1110;
        A = 32'd10;
        B = 32'd10;
        #10;

        // BEQ false
        B = 32'd20;
        #10;

        // BNE true
        ALUControl = 4'b1111;
        A = 32'd10;
        B = 32'd20;
        #10;

        // BNE false
        B = 32'd10;
        #10;

        $finish;

    end

endmodule

