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
module MUX2(
    input select,
    input [BITS-1:0] in1,
    input [BITS-1:0] in2,
    output wire [BITS-1:0] out
    );
	 
	 parameter BITS = 32;
	 
	 assign out = (select == 0) ? in1 : // select input 1
					  (select == 1) ? in2 : 32'hXXXXXXXX; // select input 2
endmodule