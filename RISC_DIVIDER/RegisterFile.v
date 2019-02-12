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
module RegisterFile_32Bit(
	 input clk,
    input Write,
    input [4:0] AddrA,
    input [4:0] AddrB,
    input [4:0] DestAddr,
    input [BITS-1:0] DestData,	// Problem MDOut Red X
    output wire [BITS-1:0] DataA, // After 2 clks
    output wire [BITS-1:0] DataB  // After 2 clks
    );
	 
	 parameter BITS = 32;
	 
	 reg [BITS-1:0] Registers [BITS-1:0];
	 reg [5:0] i;
	 
	 initial begin
		for(i=0;i<32;i=i+1) begin
			Registers[i] = 0;
		end
	 end
	 
	 assign DataA = Registers[AddrA];
	 assign DataB = Registers[AddrB];
	 
	 // More understandable register file in/out
	 always @(posedge clk) begin
		if(Write) begin
			Registers[DestAddr] = DestData;
		end
	 end
endmodule
