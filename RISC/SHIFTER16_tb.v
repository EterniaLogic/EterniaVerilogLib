`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   21:57:09 02/02/2015
// Design Name:   SHIFTER16
// Module Name:   C:/Users/Eternia/Dropbox/Xilinx/Projects/HW2/SHIFTER16_tb.v
// Project Name:  HW2
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: SHIFTER16
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module SHIFTER16_tb;

	// Inputs
	reg [1:0] Select;
	reg [15:0] B;
	reg InL;
	reg InR;

	// Outputs
	wire [15:0] HOut;
	integer i;
	// Instantiate the Unit Under Test (UUT)
	SHIFTER16 uut (
		.Select(Select), 
		.B(B), 
		.InL(InL), 
		.InR(InR), 
		.HOut(HOut)
	);

	initial begin
		// Initialize Inputs
		Select = 0;
		B = 0;
		InL = 0;
		InR = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here
	   for(i=0;i<65535;i=i+1) begin
			Select = 0;
			B = i;
			#5;
			Select = 1;
			#5;
			Select = 2;
			#5;
			Select = 3;
			#5;
		end
	end
      
endmodule

