`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:41:09 02/15/2014 
// Design Name: 
// Module Name:    Split8to2 
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
module Split8to2(
		input [7:0] Bus8,
		output [3:0] Bus4_1,
		output [7:4] Bus4_2
    );
		assign Bus4_1 = Bus8[3:0];
		assign Bus4_2 = Bus8[7:4];

endmodule
