`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:28:25 01/23/2015 
// Design Name: 
// Module Name:    FunctionUnit 
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
module FunctionUnit(
    input [BITS-1:0] A,
    input [BITS-1:0] B,
    input [3:0] GSel,
    input [1:0] HSel,
    input MFSel,
    output statC,
    output statN,
    output statV,
    output statZ,
	 output [BITS-1:0] Out
    );
	 
	parameter BITS = 16;
	 
	
	assign statZ = (aluOut == 0);
	assign statN = (aluOut < 0);
	
	wire [BITS-1:0] aluOut;
	
	defparam alu1.BITS = BITS;
	ALU alu1(GSel[0], GSel[3:1], A, B, aluOut, statV, statC);
	SHIFTER16 shift1(HSel, B, 0,0, ShiftOut);
	
	MUX1 muxF(MFSel, aluOut, ShiftOut, Out);
endmodule
