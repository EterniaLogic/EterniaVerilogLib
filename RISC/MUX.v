`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:07:02 01/21/2015 
// Design Name: 
// Module Name:    MUX 
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
module MUX(
    input [1:0] select,
    input [BITS-1:0] in1,
    input [BITS-1:0] in2,
    input [BITS-1:0] in3,
    input [BITS-1:0] in4,
    output [BITS-1:0] out
    );
	 
	 parameter BITS = 16;
	 
	 assign out = (select == 0) ? in1 : // select input 1
					  (select == 1) ? in2 : // select input 2
					  (select == 2) ? in3 : // select input 3
					  (select == 3) ? in4 : 1'bx; // who knows!
endmodule
