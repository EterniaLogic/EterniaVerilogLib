`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   22:42:20 07/13/2015
// Design Name:   DCDCController
// Module Name:   C:/Users/Eternia/Dropbox/Project Lab 4/Verilog/DCDCDriver/DCDCTest_tb.v
// Project Name:  DCDCDriver
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: DCDCController
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module DCDCTest_tb;

	// Inputs
	reg clk;
	reg [15:0] voltageSet;
	reg [15:0] currentSet;
	reg [23:0] DCDC_VSense;
	reg [23:0] DCDC_CSense;

	// Outputs
	wire DCDC_Driver;
	wire DCDC_CV;

	// Instantiate the Unit Under Test (UUT)
	DCDCController uut (
		.clk(clk), 
		.voltageSet(voltageSet), 
		.currentSet(currentSet), 
		.DCDC_VSense(DCDC_VSense), 
		.DCDC_CSense(DCDC_CSense), 
		.DCDC_Driver(DCDC_Driver), 
		.DCDC_CV(DCDC_CV)
	);

	initial begin
		// Initialize Inputs
		clk = 0;
		voltageSet = 0;
		currentSet = 0;
		DCDC_VSense = 0;
		DCDC_CSense = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here
		
		voltageSet = 35000;
		currentSet = 1000; // 60A -> 0.9 A
	end
	
	always #2.5 clk=~clk;
      
endmodule

