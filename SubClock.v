`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    23:25:30 03/01/2014 
// Design Name: 
// Module Name:    SubClock 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module SubClock(
		input CLK,
		output OUTCLK
    );
	 
	 parameter Divider = 1;
	 //parameter Bits = 32;
	 integer wait1;
	 reg CLK_;
	 
	 assign OUTCLK = CLK_; // output clock
	 
	 // clear out variables
	 initial begin
		wait1 = 0;
		CLK_ = 0;
	 end
	 
	 always @(posedge CLK) begin
		// wait until clock hits half of the counted time.
		if(wait1 >= (Divider/2)) begin
			wait1 = 0; // reset clock
			CLK_ = ~CLK_;
		end
		
		wait1 = wait1+1; // count up 1
	 end
endmodule
