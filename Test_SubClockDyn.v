`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   22:36:02 03/02/2014
// Design Name:   SubClockDyn
// Module Name:   /home/eternia/Dropbox/Project Lab 1/Verilog/Test_SubClockDyn.v
// Project Name:  Router
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: SubClockDyn
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module Test_SubClockDyn;

	// Inputs
	reg CLK;
	reg [25:0] Freq;

	// Outputs
	wire OUTCLK;

	// Instantiate the Unit Under Test (UUT)
	SubClockDyn uut (
		.CLK(CLK), 
		.Freq(Freq), 
		.OUTCLK(OUTCLK)
	);

	initial begin
		// Initialize Inputs
		CLK = 0;
		Freq = 240;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here
		while(1) begin
			#10;
			CLK = ~CLK;
		end
	end
      
endmodule

