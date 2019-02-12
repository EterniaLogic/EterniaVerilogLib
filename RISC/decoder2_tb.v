`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   14:32:16 01/21/2015
// Design Name:   Decoder2
// Module Name:   /home/eternia/Dropbox/Xilinx/Projects/HW2/decoder2_tb.v
// Project Name:  HW2
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: Decoder2
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module decoder2_tb;

	// Inputs
	reg [1:0] select;

	// Outputs
	wire [3:0] out;

	// Instantiate the Unit Under Test (UUT)
	Decoder uut (
		.select(select), 
		.out(out)
	);

	initial begin
		// Initialize Inputs
		select = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here
	end
      
	always begin
		select = select+1;
		#1;
	end
endmodule

