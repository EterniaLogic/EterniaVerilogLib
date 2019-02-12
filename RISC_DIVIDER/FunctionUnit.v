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
    input [4:0] FS, // Function Select
	 input [4:0] SH, // Shift by N
    output wire statC,
    output wire statN,
    output wire statV,
    output wire statZ,
	 output wire [BITS-1:0] Out
    );
	 
	parameter BITS = 32;
	 
	assign statZ = (Out == 0);
	assign statN = (Out < 0);
	
	wire [BITS-1:0] aluOut, ShiftOut;
	wire LR, shift;
	
	defparam alu1.BITS = BITS;
	ALU alu1(FS, A, B, aluOut, statV, statC, shift, LR);
	BarrelShifter32 bs1(SH, LR, A, ShiftOut);
	
	MUX2 muxF(shift, aluOut, ShiftOut, Out);
endmodule
