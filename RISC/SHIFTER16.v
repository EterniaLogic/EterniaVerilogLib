`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:47:35 02/02/2015 
// Design Name: 
// Module Name:    SHIFTER16 
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
module SHIFTER16(
    input [1:0] Select,
    input [BITS-1:0] B,
    input InL,
    input InR,
    output [15:0] HOut
    );
	 
	 parameter BITS=16;
	 
	 reg [BITS-1:0] HOut_;
	 
	 assign HOut = HOut_;
	 
	 initial begin
		HOut_=0;
	 end
	 
	 always @(*) begin
		case(Select)
			0: HOut_=B;
			1: HOut_=(InL<<(BITS-1))	+ B>>1; // shift left 1, add carry
			2: HOut_=B<<1 + InR; // Shift left twice
			3: HOut_=B;
		endcase
	 end
endmodule
