`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:10:50 01/30/2015 
// Design Name: 
// Module Name:    FullAdder 
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
module FullAdder(
    input Cin,
    input A,
    input B,
    output Cout,
    output Out
    );
	 
	 // Full Adder outputs
	 assign Out = (Cin)^(A^B);
	 assign Cout= ((A^B) & (Cin)) | (A&B);
endmodule
