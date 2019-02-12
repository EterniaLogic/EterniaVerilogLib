`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    06:38:57 02/03/2015 
// Design Name: 
// Module Name:    MUX1 
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
module MUX1(
    input select,
    input [BITS-1:0] in1,
    input [BITS-1:0] in2,
    output [BITS-1:0] out
    );
	 
	 parameter BITS = 16;
	 
	 assign out = (select == 0) ? in1 : // select input 1
					  (select == 1) ? in2 : 1'bx; // who knows!
endmodule
