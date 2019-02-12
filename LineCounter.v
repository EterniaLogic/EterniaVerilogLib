`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:26:45 03/08/2014 
// Design Name: 
// Module Name:    LineCounter 
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
module LineCounter(
			input CLK,
			input LineCounter,
			input Reset,
			output [15:0] Counted
    );
	
	reg [15:0] Count;
	assign Counted = Count;
	reg SET1, SET2;
	wire SET;
	
	initial begin
		Count = 0;
		SET1 = 0;
		SET2 = 0;
	end
	
	// use xor to have cross-block communication
	xor(SET, SET1, SET2); 
	
	always @(posedge LineCounter) begin
		SET1 <= ~SET1;
	end
	
	// the line counter directly counts the inputs.
	// if a reset occurs, set count to 0.
	always @(posedge CLK) begin
		Count <= (Reset) ? 0 : ((SET) ? Count+1 : Count);
		SET2 <= (SET) ? ~SET2 : SET2; // reset set
	end

endmodule
