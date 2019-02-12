`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   00:25:04 04/28/2014
// Design Name:   PhaseDetector
// Module Name:   /home/eternia/Dropbox/Project Lab 1/Projects/MAIN_DEMOS/Full_March/PhaseDetectorTest.v
// Project Name:  Full_March
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: PhaseDetector
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module PhaseDetectorTest;

	// Inputs
	reg CLK;
	reg Phase1;
	reg Phase2;
	reg initialSLEEP;
	
	integer CC, CC2, CC3;

	// Outputs
	wire [15:0] PhaseOUT;
	wire LeftFirst;
	wire SignalDetect;

	// Instantiate the Unit Under Test (UUT)
	PhaseDetector uut (
		.CLK(CLK), 
		.Phase1(Phase1), 
		.Phase2(Phase2), 
		.PhaseOUT(PhaseOUT), 
		.LeftFirst(LeftFirst), 
		.SignalDetect(SignalDetect)
	);

	initial begin
		// Initialize Inputs
		CLK = 0;
		Phase1 = 0;
		Phase2 = 0;
		CC = 0;
		CC2 = 0;
		initialSLEEP = 1;
		CC3 = 0;

		// Wait 100 ns for global reset to finish
		#100;
		
		while(1) begin
			CLK = ~CLK; // run clock
			#10;
			
			// wait for first 19kHz signal timeout
			if(CC >= 2632) begin
				CC = 0;
				Phase1 = ~Phase1; // set opposite
			end
			
			if(CC3 >= 2632) begin
				initialSLEEP = 0;
			end
			
			if(CC2 >= 2632) begin
				CC2 = 0;
				Phase2 = ~Phase2; // set opposite
			end
			
			CC = CC+1;
			CC3 = CC3+1;
			if(~initialSLEEP) begin
				CC2 = CC2+1;
			end
		end
        
		// Add stimulus here

	end
      
endmodule

