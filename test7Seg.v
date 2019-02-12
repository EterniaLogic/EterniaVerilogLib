`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   03:26:40 01/26/2014
// Design Name:   Segment7
// Module Name:   /media/MStuffs/Dev/ise/testAISystem/test7Seg.v
// Project Name:  testAISystem
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: Segment7
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module test7Seg;

	// Inputs
	reg CLK;
	reg [7:0] DATA1;
	reg [7:0] DATA2;
	reg [7:0] DATA3;
	reg [7:0] DATA4;

	// Outputs
	wire [7:0] SEGMENT;
	wire [3:0] DIG;

	// Instantiate the Unit Under Test (UUT)
	Segment7 uut (
		.CLK(CLK), 
		.DATA1(DATA1), 
		.DATA2(DATA2), 
		.DATA3(DATA3), 
		.DATA4(DATA4), 
		.SEGMENT(SEGMENT), 
		.DIG(DIG)
	);

	initial begin
		// Initialize Inputs
		CLK = 0;
		DATA1 = 0;
		DATA2 = 0;
		DATA3 = 0;
		DATA4 = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here
		DATA1 = "1";
		DATA1 = "2";
		DATA1 = "3";
		DATA1 = "4";

	end
      
endmodule

