`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Brent Clancy
// 
// Create Date:    19:34:25 01/30/2014 
// Design Name: 
// Module Name:    Math_Divide 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: Takes in a Divisor and a Divider.
//				Allows for 32-bit division.
//			   {{ Do not use for massively difficult tasks }}
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module Math_Divide(
	input CLK, // pulse
	input [31:0] Divisor, // integer == [31:0]
	input [31:0] Divider,
	output [31:0] result, 
	output [31:0] remainder,
	inout done // signal sent when done
    );

	// OLD memory (sets up a new set)
	reg [31:0] divisor_, divider_;

	// assignment variables
	reg [31:0] result_, remainder_;
	reg done_;
	wire NEW;
	
	// assign variables to their outputs
	assign result = result_;
	assign remainder = remainder_;
	assign done = done_;
	integer i; // loop counter
	
	// reset detection gates
	nand(NEW, Divisor, divisor_);
	nand(NEW2, Divider, divider_);
	
	// counter begin
	initial begin
		i = 0;
		done_ = 1;
	end
	
	
	// main loop!
	// divide by removing n times from itself
	always @(posedge CLK) begin
		if(NEW || NEW2) begin
			divisor_ = Divisor;
			divider_ = Divider;
			remainder_ = Divider;
			result_ = 0;
			done_ = 0; // enable main loop
		end
	
		// prevent it from going when done
		if(~done_) begin 
			// remove x0 from the current x until x-x0 is less than
			//	or equal to 0
			if(remainder_ > 0 && remainder_-Divisor > 0) begin
				//$display("Remainder = %d - %d = %d", remainder_, Divisor, (remainder_-Divisor));
				remainder_ = remainder_-Divisor;
				result_=result_+1;
			end else begin
				// pulse done
				done_ = 1;
			end
			
			i = i+1;
		end
	end


endmodule
