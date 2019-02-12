`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:54:06 02/15/2014 
// Design Name: 
// Module Name:    Average4 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: Averages an input sample 4 times automatically
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module Average4(
    input CLK,
    input [7:0] SampleIN,
    output [7:0] AverageOUT
    );

	 // hold the 8 averages
	 reg [7:0] Average [3:0];
	 reg [7:0] AverageOUT_;
	 reg [1:0] AvgIndex;
	 integer Adder;
	 // averages all values

	 initial begin
		Adder = 0;
		AvgIndex = 0;
		repeat(4) begin // reset data
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
		
		Adder = Average[0]+Average[1]+Average[2]+Average[3];
		Adder = Adder>>2; // divide by 4
		AverageOUT_ = Adder;
	 end

endmodule
