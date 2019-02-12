`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:11:50 03/30/2015 
// Design Name: 
// Module Name:    NegEdgeBuffer32 
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
module NegEdgeBuffer32(
    input clk,
    input [31:0] In,
    output reg [31:0] Out
    );
	 
	initial begin
		Out = 0;
	end
	
	always @(negedge clk) begin
		Out = In;
	end

endmodule
