`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    12:05:33 03/13/2014 
// Design Name: 
// Module Name:    Split16to2 
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
module Split16to2(
    input [15:0] Bus16,
    output [7:0] Bus_8_1,
    output [7:0] Bus_8_2
    );

		assign Bus_8_1 = Bus16[7:0];
		assign Bus_8_2 = Bus16[15:8];
endmodule
