`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    09:17:09 06/30/2015 
// Design Name: 
// Module Name:    GHI_LCD_16x2 
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
module GHI_LCD_16x2(
    input clk,
	 input [7:0] char, // character wanted to display
	 input newline, // send newline to display? (sends charDone)
    output reg [3:0] data,
    output reg rs,
    output reg backlight,
    output reg enable,
	 output reg charDone // character has been set to display
    );
	// LMB162ABC


	// RS = 0 -> CMD set address, instructions
	// RS = 1 -> set character
	
	// enable is used to control output
	reg [4:0] state;
	wire LCDCLK;
	
	// initialize setup commands
	parameter INIT1 = 2'h33; // 0011 0011 0x33 -- 8-bit ??
	parameter INIT2 = 2'h32; // 0011 0010 0x32 -- 8-bit ??
	parameter INIT3 = 2'h28; // 0010 1000 0x28 -- 4-line interface
	parameter INIT4 = 2'h0C; // 0000 1110 0x0C -- disp on, cursor on, no blink
	parameter INIT5 = 2'h06;  // 0000 0110 0x06 -- cursor moving direction right
	parameter INIT6 = 2'h01;  // 0000 0001 0x01 -- clear
	
	parameter LINE1 = 128; // set line 1
	parameter LINE2 = 192; // set line 2
	
	defparam sc1.Divider=5000; // 200MHz/40kHz
	SubClock sc1(clk, LCDCLK);
	
	initial begin
		state=0;
		data=0;
		rs=0;
		backlight=0;
		enable=0;
		charDone=0;
	end
	
	always @(posedge LCDCLK) begin // clock 20kHz, actual out 10kHz
		case(state)
			0:  begin rs=0; data=INIT1[7:4]; end // 0011 0011 0x33 --
			1:  begin rs=0; data=INIT1[3:0]; end // 		8-bit ??
			2:  begin rs=0; data=INIT2[7:4]; end // 0011 0010 0x32 -- 
			3:  begin rs=0; data=INIT2[3:0]; end // 		8-bit ??
			4:  begin rs=0; data=INIT3[7:4]; end // 0010 1000 0x28 -- 
			5:  begin rs=0; data=INIT3[3:0]; end // 		4-line interface
			6:  begin rs=0; data=INIT4[7:4]; end // 0000 1110 0x0C -- 
			7:  begin rs=0; data=INIT4[3:0]; end // 		disp on, cursor on, no blink
			8:  begin rs=0; data=INIT5[7:4]; end // 0000 0110 0x06 -- 
			9:  begin rs=0; data=INIT5[3:0]; end //		cursor moving direction right
			10: begin rs=0; data=INIT6[7:4]; end
			11: begin rs=0; data=INIT6[3:0]; end
			13: begin rs=1; data=char[7:4]; end // write char to display
			14: begin rs=1; data=char[3:0]; end
			15: begin charDone=1; end // finish chars to display
			16: begin rs=0; data=LINE1[7:4]; end // set LINE1
			17: begin rs=0; data=LINE1[3:0]; end
			18: begin charDone=1; end // finish linechange1
			19: begin rs=0; data=LINE2[7:4]; end // set LINE2
			20: begin rs=0; data=LINE2[3:0]; end
			21: begin charDone=1; end // finish linechange2
			22: begin charDone=0; end // endstate
		endcase
		
		// do state
		if(enable) begin
			state = state+1;
			enable = 0;
		end else begin
			if(state!=15 && state!=18 && state!=21 && state!=22) begin
				enable=1;
			end else if(state==15 && state==18 && state==21) begin
				// set end state
				state=22;
			end
		end
	end
endmodule
