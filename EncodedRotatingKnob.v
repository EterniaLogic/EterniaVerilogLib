`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    03:02:28 12/05/2014 
// Design Name: 
// Module Name:    EncodedRotatingKnob 
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
module EncodedRotatingKnob(
    input clk,
    input knob,
    output reg [17:0] value
    );
	 
	 reg reset;
	 wire [15:0] vcount;
	 LineCounter VKnob(clk,volt,reset,vcount);

	initial begin
		reset = 0;
		value = 0;
	end
endmodule
