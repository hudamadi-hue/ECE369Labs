`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// ECE369 - Computer Architecture
// 
// Module - ALU32Bit.v
// Description - 32-Bit wide arithmetic logic unit (ALU).
//
// INPUTS:-
// ALUControl: N-Bit input control bits to select an ALU operation.
// A: 32-Bit input port A.
// B: 32-Bit input port B.
//
// OUTPUTS:-
// ALUResult: 32-Bit ALU result output.
// ZERO: 1-Bit output flag. 
//
// FUNCTIONALITY:-
// Design a 32-Bit ALU, so that it supports all arithmetic operations 
// needed by the MIPS instructions given in Labs5-8.docx document. 
//   The 'ALUResult' will output the corresponding result of the operation 
//   based on the 32-Bit inputs, 'A', and 'B'. 
//   The 'Zero' flag is high when 'ALUResult' is '0'. 
//   The 'ALUControl' signal should determine the function of the ALU 
//   You need to determine the bitwidth of the ALUControl signal based on the number of 
//   operations needed to support. 
////////////////////////////////////////////////////////////////////////////////

module ALU32Bit(ALUControl, A, B, ALUResult, ALUResultHi, Zero);

	input [3:0] ALUControl; // control bits for ALU operation
                                // you need to adjust the bitwidth as needed
	input [31:0] A, B;	    // inputs

	output reg [31:0] ALUResult;	// answer
	output reg [31:0] ALUResultHi;
	output reg Zero;	    // Zero=1 if ALUResult == 0

        reg [63:0] MultResult;

    always @(*) begin

        // Defaults
        ALUResult = 32'b0;
        ALUResultHi = 32'b0;
        MultResult = 64'b0;
        Zero = 1'b0;

        case (ALUControl)

            4'b0000: begin               // ADD
                ALUResult = A + B;
            end

            4'b0001: begin               // SUB
                ALUResult = A - B;
            end

            4'b0010: begin               // AND
                ALUResult = A & B;
            end

            4'b0011: begin               // OR
                ALUResult = A | B;
            end

            4'b0100: begin               // NOR
                ALUResult = ~(A | B);
            end

            4'b0101: begin               // XOR
                ALUResult = A ^ B;
            end

            4'b0110: begin               // SLL
                ALUResult = B << A[4:0];
            end

            4'b0111: begin               // SRL
                ALUResult = B >> A[4:0];
            end

            4'b1000: begin               // SLT
                ALUResult =
                    ($signed(A) < $signed(B)) ? 32'd1 : 32'd0;
            end

            4'b1001: begin               // MUL
                MultResult = A * B;
                ALUResult = MultResult[31:0];
                ALUResultHi = MultResult[63:32];
            end

            4'b1010: begin               // BGEZ
                Zero = ($signed(A) >= 0);
            end

            4'b1011: begin               // BGTZ
                Zero = ($signed(A) > 0);
            end

            4'b1100: begin               // BLEZ
                Zero = ($signed(A) <= 0);
            end

            4'b1101: begin               // BLTZ
                Zero = ($signed(A) < 0);
            end

            4'b1110: begin               // BEQ
                Zero = (A == B);
            end

            4'b1111: begin               // BNE
                Zero = (A != B);
            end

            default: begin
                ALUResult = 32'b0;
                ALUResultHi = 32'b0;
                Zero = 1'b0;
            end

        endcase
    
        if (ALUControl <= 4'b1001)
            Zero = (ALUResult == 32'b0);
        end
        
endmodule

