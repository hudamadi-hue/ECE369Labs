`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// ECE369 - Computer Architecture
// 
// Module - RegisterFile.v
// Description - Test the register_file
// Suggested test case - First write arbitrary values into 
// the saved and temporary registers (i.e., register 8 through 25). Then, 2-by-2, 
// read values from these registers.
////////////////////////////////////////////////////////////////////////////////


module RegisterFile_tb();

	reg [4:0] ReadRegister1;
	reg [4:0] ReadRegister2;
	reg	[4:0] WriteRegister;
	reg [31:0] WriteData;
	reg RegWrite;
	reg Clk;

	wire [31:0] ReadData1;
	wire [31:0] ReadData2;


	RegisterFile u0(
		.ReadRegister1(ReadRegister1), 
		.ReadRegister2(ReadRegister2), 
		.WriteRegister(WriteRegister), 
		.WriteData(WriteData), 
		.RegWrite(RegWrite), 
		.Clk(Clk), 
		.ReadData1(ReadData1), 
		.ReadData2(ReadData2)
	);

	initial begin
		Clk <= 1'b0;
		forever #10 Clk <= ~Clk;
	end

	initial begin
	
        // Initialize Inputs
        ReadRegister1 = 5'd0;
        ReadRegister2 = 5'd0;
        WriteRegister = 5'd0;
        WriteData = 32'd0;
        RegWrite = 1'b0;
        
        // Write 10 into register 1
        #5;
        WriteRegister = 5'd1;
        WriteData = 32'd10;
        RegWrite = 1'b1;
        
        // Wait until after rising edge at 10 ns
        #10;
        RegWrite = 1'b0;
        
        // Write 20 into register 2
        #10;
        WriteRegister = 5'd2;
        WriteData = 32'd20;
        RegWrite = 1'b1;
        
        // Wait until after rising edge at 30 ns
        #10;
        RegWrite = 1'b0;
        
        // Select registers 1 and 2 for reading
        ReadRegister1 = 5'd1;
        ReadRegister2 = 5'd2;
        
        // Wait until falling edge @ 40 ns
        #10;
        $display("R1 = %d, R2 = %d", ReadData1, ReadData2);
        
        // Try to overwrite register 1 while RegWrite = 0
        WriteRegister = 5'd1;
        WriteData = 32'd99;
        RegWrite = 1'b0;
        
        // Another rising and falling edge
        #20;
        $display("After RegWrite=0: R1 = %d", ReadData1);
        
        #10;
        $finish;
	
	end

endmodule
