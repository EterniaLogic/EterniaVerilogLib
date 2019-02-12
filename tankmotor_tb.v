`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   15:08:42 02/14/2014
// Design Name:   tankdrive
// Module Name:   C:/Users/bbarr_000/Documents/ECE 3331/tankmotor/tankmotor_tb.v
// Project Name:  tankmotor
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: tankdrive
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module tankmotor_tb;

	// Inputs
	reg sysclk;
	reg [5:0] speed;
	reg [1:0] mode;

	// Outputs
	wire enable;
	wire [1:0] mode_out;
	wire [1:0] mode_out2;
	wire enable2;

	// Instantiate the Unit Under Test (UUT)
	tankdrive uut (
		.sysclk(sysclk), 
		.speed(speed), 
		.mode(mode), 
		.enable(enable), 
		.mode_out(mode_out), 
		.mode_out2(mode_out2), 
		.enable2(enable2)
	);

	initial begin
		// Initialize Inputs
		sysclk = 0;
		speed = 0;
		mode = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here

	end
      
endmodule

