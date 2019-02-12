`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:12:53 01/21/2015 
// Design Name: 
// Module Name:    Decoder2 
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
module Decoder(
    input [1:0] select,
    output [3:0] out
    );
	 // 2 to 4 decoder

	assign out = 1 << select;
endmodule
