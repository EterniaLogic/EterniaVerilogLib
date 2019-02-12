`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   06:25:32 07/06/2015
// Design Name:   SMPS_ZVS_Controller
// Module Name:   C:/Users/Eternia/Dropbox/Project Lab 4/Verilog/DCDCDriver/ZVSTest_tb.v
// Project Name:  DCDCDriver
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: SMPS_ZVS_Controller
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module ZVSTest_tb;

	// Inputs
	reg clk;
	reg [23:0] SMPS_50V_VSense;
	reg [23:0] SMPS_50V_CSense;

	// Outputs
	wire SMPS_Driver1;
	wire SMPS_Driver2;
	wire SMPS_Driver3;
	wire SMPS_Driver4;
	integer i,j;

	// Instantiate the Unit Under Test (UUT)
	SMPS_ZVS_Controller uut (
		.clk(clk), 
		.SMPS_50V_VSense(SMPS_50V_VSense), 
		.SMPS_50V_CSense(SMPS_50V_CSense), 
		.SMPS_Driver1(SMPS_Driver1), 
		.SMPS_Driver2(SMPS_Driver2), 
		.SMPS_Driver3(SMPS_Driver3), 
		.SMPS_Driver4(SMPS_Driver4)
	);

	initial begin
		// Initialize Inputs
		clk = 0;
		SMPS_50V_VSense = 0;
		SMPS_50V_CSense = 0;
		i=0;
		j=0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here
		/*for(i=0;i<16777216;i=i+1) begin
			for(j=0;j<16777216;j=j+1) begin
				SMPS_50V_VSense=i;
				SMPS_50V_CSense=j;
				#1500;
			end
		end*/
		SMPS_50V_VSense=24'd777216;
		SMPS_50V_CSense=24'd11777216;
	end
	always #2.5 clk=~clk;
      
endmodule

