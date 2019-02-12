`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    02:47:06 03/27/2015 
// Design Name: 
// Module Name:    BarrelShifter32 
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
module BarrelShifter32(
    input [4:0] SH,
    input LR,
    input [31:0] Input,
    output wire [31:0] Output
    );

	assign Output = LR ? (Input << SH) : (Input >> SH);
endmodule
