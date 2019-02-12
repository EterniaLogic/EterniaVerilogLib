`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:15:51 02/02/2015 
// Design Name: 
// Module Name:    TinyCPU 
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
module TinyCPU(
	 input clk,
    input LoadEnable,
    input [1:0] ASelect,
    input [1:0] BSelect,
    input [1:0] DestinationSelect,
    input [BITS-1:0] ConstantIn,
    input MBSelect,
    input MDSelect,
	 input [3:0] GSelect,
	 input [1:0] HSelect,
	 input MFSelect,
    output [BITS-1:0] AddressOut,
    output [BITS-1:0] DataOut,
    input [BITS-1:0] DataIn,
	 output statC,
	 output statV,
	 output statN,
	 output statZ
    );
	 
	 parameter BITS = 16;
	 
	 
	 wire [15:0] DestinationData, AData, BData, BIn, Out;
	 
	 assign DataOut = BIn;
	 assign AddressOut = AData;
	 
	 defparam regFile.BITS=BITS;
	 RegisterFile_2Bit regFile (
		 .clk(clk),
		 .Write(LoadEnable), 
		 .AddrA(ASelect), 
		 .AddrB(BSelect), 
		 .DestAddr(DestinationSelect), 
		 .DestData(DestinationData), 
		 .DataA(AData), 
		 .DataB(BData)
    );
	 
	 defparam functionUnit1.BITS=BITS;
	 FunctionUnit functionUnit1 (
		 .A(AData), 
		 .B(BIn), 
		 .GSel(GSelect), 
		 .HSel(HSelect), 
		 .MFSel(MFSelect), 
		 .statC(statC), 
		 .statN(statN), 
		 .statV(statV), 
		 .statZ(statZ), 
		 .Out(Out)
    );
	 
	 defparam muxMB.BITS=BITS;
	 defparam muxMD.BITS=BITS;
	 MUX1 muxMB(MBSelect, BData, ConstantIn, BIn);
	 MUX1 muxMD(MDSelect, Out, DataIn, DestinationData);

endmodule
