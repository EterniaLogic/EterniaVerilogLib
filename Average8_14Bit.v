`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:21:41 01/31/2014 
// Design Name: 
// Module Name:    Average8_14Bit 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: Takes in continuous values; Averages them over time.
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////

module Average8_14Bit(
	 input CLK,
    input [13:0] DATA_IN,
    output [13:0] AVG_OUT
    );
	 
	 reg [13:0] AVGMem [0:7]; // memory used to store average data
	 reg [2:0] AVGIndex; // memory index
	 reg [23:0] AVGAccumulator; // accumulator used in averaging
	 reg [2:0] i;
	 
	 reg OUT_;
	 assign AVG_OUT=OUT_;
	 
	 wire new; // IN has changed
	 
	 initial begin
		AVGIndex = 0;
		AVGAccumulator = 0;
		i=0;
		repeat(8) begin
			AVGAccumulator = 0;
			i=i+1;
		end
	 end
	 
	 // Only happens when IN is changed
	 always @(posedge CLK) begin
		AVGMem[AVGIndex] = DATA_IN;
		AVGIndex = AVGIndex+1; // (AVGMem will reset on it's own 2^3-1 = 7)
		
		// Do average
		// SUM all values in array
		i=0;
		repeat(8) begin
			AVGAccumulator = AVGAccumulator + AVGMem[i];
			i=i+1;
		end
		OUT_ = AVGAccumulator >> 3; // divide by 8
	 end

endmodule
