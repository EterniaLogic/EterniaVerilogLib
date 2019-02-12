`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    22:43:10 03/26/2015 
// Design Name: 
// Module Name:    Adder 
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
module Adder(
    input [31:0] A,
    input [31:0] B,
    output [31:0] C
    );
	 
	 assign C = A+B;
endmodule
