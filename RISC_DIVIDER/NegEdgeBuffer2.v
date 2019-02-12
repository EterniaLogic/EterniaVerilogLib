`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:20:38 03/30/2015 
// Design Name: 
// Module Name:    NegEdgeBuffer2 
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
module NegEdgeBuffer2(
    input clk,
    input [1:0] In,
    output reg [1:0] Out
    );
	 
	 initial begin
		Out = 0;
	end
	
	always @(negedge clk) begin
		Out = In;
	end


endmodule
