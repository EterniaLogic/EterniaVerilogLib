`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   14:34:10 01/21/2015
// Design Name:   MUX
// Module Name:   /home/eternia/Dropbox/Xilinx/Projects/HW2/MUX_tb.v
// Project Name:  HW2
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: MUX
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module MUX_tb;

	// Inputs
	reg [1:0] select;
	reg [15:0] in1;
	reg [15:0] in2;
	reg [15:0] in3;
	reg [15:0] in4;

	// Outputs
	wire [15:0] out;

	// Instantiate the Unit Under Test (UUT)
	MUX uut (
		.select(select), 
		.in1(in1), 
		.in2(in2), 
		.in3(in3), 
		.in4(in4), 
		.out(out)
	);

	initial begin
		// Initialize Inputs
		select = 0;
		in1 = 11111;
		in2 = 22222;
		in3 = 33333;
		in4 = 44444;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here

	end
	
	always begin
		select = select+1;
		#1;
	end
      
endmodule

