`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:54:06 02/15/2014 
// Design Name: 
// Module Name:    Average8 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: Averages 8 times
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module Average8(
    input CLK,
    input [7:0] SampleIN,
    output [7:0] AverageOUT
    );

	 // hold the 128 averages
	 reg [7:0] Average [127:0];
	 reg [7:0] AverageOUT_;
	 reg [6:0] AvgIndex;
	 reg [6:0] AvgTIndex; // base index 
	 integer Adder;
	 // averages all values

	 initial begin
		Adder = 0;
		AvgIndex = 0;
		repeat(128) begin // reset data
			Average[AvgIndex] = 0;
			AvgIndex = AvgIndex+1;
		end
		AvgIndex = 0;
	 end

	 assign AverageOUT = AverageOUT_;
	 // take in values
	 always @ (posedge CLK) begin
		// add this value to the set
		Average[AvgIndex] = SampleIN;
		AvgIndex = AvgIndex+1;
		
		repeat(128) begin
		        Adder = Adder+Average[AvgTIndex];
		        AvgTIndex = AvgTIndex+1;		
	        end
	        AvgTIndex = 0;
		Adder = Adder>>7;
		AverageOUT_ = Adder;
	 end

endmodule

