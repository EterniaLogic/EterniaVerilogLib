`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   14:38:01 01/21/2015
// Design Name:   RegisterFile_2Bit
// Module Name:   /home/eternia/Dropbox/Xilinx/Projects/HW2/RegisterFile_2Bit_tb.v
// Project Name:  HW2
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: RegisterFile_2Bit
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module RegisterFile_2Bit_tb;

	// Inputs
	reg clk;
	reg Write;
	reg [1:0] AddrA;
	reg [1:0] AddrB;
	reg [1:0] DestAddr;
	reg [15:0] DestData;
	integer i, j;

	// Outputs
	wire [15:0] DataA;
	wire [15:0] DataB;

	// Instantiate the Unit Under Test (UUT)
	RegisterFile_2Bit uut (
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
		clk=0;
		Write = 0;
		AddrA = 0;
		AddrB = 0;
		DestAddr = 0;
		DestData = 0;
		i=0;
		j=0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here

		// write in new data
		Write = 1;
		for(i=0;i<4;i=i+1) begin
			DestAddr = i;
			#5;
			DestData = i;	
			#10;
		end
		#20;
		Write = 0;
		
		// loop through selects
		while(1) begin
			for(i=0;i<4;i=i+1) begin
				for(j=0;j<4;j=j+1) begin
					AddrA = i;
					AddrB = j;
					#10;
				end
			end
		end
	end
	
	
	always #0.1 clk = ~clk;
endmodule

