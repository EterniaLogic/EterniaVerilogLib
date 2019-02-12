`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   04:04:53 03/27/2015
// Design Name:   RISC
// Module Name:   C:/Users/Eternia/Dropbox/Xilinx/Projects/Project4/RISC_tb.v
// Project Name:  Project4
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: RISC
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module RISC_tb;

	// Inputs
	reg clk;

	// Instantiate the Unit Under Test (UUT)
	RISC uut (
		.clk(clk)
	);

	initial begin
		// Initialize Inputs
		clk = 1;

		// Wait 300 ns for global reset to finish
		#300;
        
		// Add stimulus here

	end
	
	always #10 clk = ~clk;
      
endmodule

