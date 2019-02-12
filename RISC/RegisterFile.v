`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:17:34 01/21/2015 
// Design Name: 
// Module Name:    RegisterFile_2Bit 
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
module RegisterFile_2Bit(
	 input clk,
    input Write,
    input [1:0] AddrA,
    input [1:0] AddrB,
    input [1:0] DestAddr,
    input [BITS-1:0] DestData,
    output wire [BITS-1:0] DataA,
    output wire [BITS-1:0] DataB
    );
	 
	 parameter BITS = 16;
	 
	 reg [BITS-1:0] R0;
	 reg [BITS-1:0] R1;
	 reg [BITS-1:0] R2;
	 reg [BITS-1:0] R3;
	 wire enA, enB, enC, enD;
	 wire [3:0] decodedDAddr;
	 
	 initial begin
		R0=0;
		R1=0;
		R2=0;
		R3=0;
	 end
	 
	 // Write Enables for registers
	 and(enA, Write, decodedDAddr[0]);
	 and(enB, Write, decodedDAddr[1]);
	 and(enC, Write, decodedDAddr[2]);
	 and(enD, Write, decodedDAddr[3]);

	// 2/16-bit MUXes and 2-to-4 decoder
	 defparam mux1.BITS=BITS;
	 defparam mux2.BITS=BITS;
	 MUX mux1(AddrA, R0, R1, R2, R3, DataA),
			mux2(AddrB, R0, R1, R2, R3, DataB);
	 Decoder decoder1(DestAddr, decodedDAddr);
	 
	 
	 always @(posedge clk) begin
		R0 = enA ? DestData : R0;
		R1 = enB ? DestData : R1;
		R2 = enC ? DestData : R2;
		R3 = enD ? DestData : R3;
	 end
endmodule
