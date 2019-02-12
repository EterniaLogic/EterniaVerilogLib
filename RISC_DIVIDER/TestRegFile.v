`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   10:44:33 03/29/2015
// Design Name:   RegisterFile_32Bit
// Module Name:   /home/eternia/Dropbox/Xilinx/Projects/Project4/TestRegFile.v
// Project Name:  Project4
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: RegisterFile_32Bit
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module TestRegFile;

	// Inputs
	reg clk;
	reg Write;
	reg [4:0] AddrA;
	reg [4:0] AddrB;
	reg [4:0] DestAddr;
	reg [31:0] DestData;

	// Outputs
	wire [31:0] DataA;
	wire [31:0] DataB;
	integer i;
	// Instantiate the Unit Under Test (UUT)
	RegisterFile_32Bit uut (
		.clk(clk), 
		.Write(Write), 
		.AddrA(AddrA), 
		.AddrB(AddrB), 
		.DestAddr(DestAddr), 
		.DestData(DestData), 
		.DataA(DataA), 
		.DataB(DataB)
	);

	initial begin
		// Initialize Inputs
		clk = 0;
		Write = 0;
		AddrA = 0;
		AddrB = 0;
		DestAddr = 0;
		DestData = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here
		#20;
		Write = 1;
		for(i=0;i<32;i=i+1) begin
			clk=0;
			DestAddr=i;
			DestData=i;
			#10;
			clk=1;
			#10;
		end
		
		
	end
	
	//always #10 clk=~clk;
      
endmodule

