`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// ECE369 - Computer Architecture
// 
// Module - DataMemory_tb.v
// Description - Test the 'DataMemory.v' module.
////////////////////////////////////////////////////////////////////////////////

module DataMemory_tb(); 

    reg     [31:0]  Address;
    reg     [31:0]  WriteData;
    reg             Clk;
    reg             MemWrite;
    reg             MemRead;

    wire [31:0] ReadData;

    DataMemory u0(
        .Address(Address), 
        .WriteData(WriteData), 
        .Clk(Clk), 
        .MemWrite(MemWrite), 
        .MemRead(MemRead), 
        .ReadData(ReadData)
    ); 

	initial begin
		Clk <= 1'b0;
		forever #10 Clk <= ~Clk;
	end

initial begin

    // Initialize inputs
    Address = 32'd0;
    WriteData = 32'd0;
    MemWrite = 1'b0;
    MemRead = 1'b0;

    // Write 10 to byte address 4 (memory word 1)
    #5;
    Address = 32'd4;
    WriteData = 32'd10;
    MemWrite = 1'b1;

    // Rising edge occurs at 10 ns
    #10;
    MemWrite = 1'b0;

    // Read address 4
    MemRead = 1'b1;
    #5;
    $display("Address 4 = %d", ReadData);

    // Write 20 to byte address 8 (memory word 2)
    MemRead = 1'b0;
    Address = 32'd8;
    WriteData = 32'd20;
    MemWrite = 1'b1;

    // Rising edge occurs at 30 ns
    #11;
    MemWrite = 1'b0;

    // Read address 8
    MemRead = 1'b1;
    #5;
    $display("Address 8 = %d", ReadData);

    // Return to address 4 and verify its value is still 10
    Address = 32'd4;
    #5;
    $display("Address 4 again = %d", ReadData);

    // Attempt to overwrite address 4 while MemWrite = 0
    WriteData = 32'd99;
    MemWrite = 1'b0;

    // Allow next rising edge to pass
    #10;
    $display("After MemWrite=0: Address 4 = %d", ReadData);

    // Disable reading; ReadData should become 0
    MemRead = 1'b0;
    #5;
    $display("MemRead=0: ReadData = %d", ReadData);

    #10;
    $finish;

end

endmodule

