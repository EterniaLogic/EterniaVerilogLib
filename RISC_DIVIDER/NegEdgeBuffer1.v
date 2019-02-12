`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:12:10 03/30/2015 
// Design Name: 
// Module Name:    NegEdgeBuffer1 
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
module NegEdgeBuffer1(
    input clk,
    input In,
    output reg Out
    );

	initial begin
		Out = 0;
	end
	
	always @(negedge clk) begin
		Out = In;
	end

endmodule
