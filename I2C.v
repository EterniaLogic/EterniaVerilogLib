`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:26:04 12/04/2014 
// Design Name: 
// Module Name:    I2 
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
module I2C(
    input clk,
    inout sda,
    inout scl,
    input master,
    input [7:0] addr
    );

	wire sda_in;
	wire scl_in;
	
	assign sda_in = sda;
	assign scl_in = scl;
	
	pullup(sda);
	pullup(scl);

endmodule
