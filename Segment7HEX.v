`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Brent Clancy
// 
// Create Date:    09:05:56 01/21/2014 
// Design Name: 
// Module Name:    Segment7
// Project Name:   Ultrasound Range finder
// Target Devices: Spartan-3E (XC3S100E)
// Tool versions: Xilinx 14.6
// Description: This driver helps manage the 7-segment display when using
//				a set input clock (60Hz (60/4 Hz) to 240Hz (60/4 = 60Hz)
//				Frequency is divided by 4 because there are 4 7-segment displays.
//
// Dependencies: none
//
// Revision: 
// Revision 0.2 - Set main
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module Segment7HEX(
    input CLK,
    input [3:0] DATA1, // multiple data variables,
	 input [3:0] DATA2, // this version of verilog
	 input [3:0] DATA3, // doesnt support 2D I/O arrays.
	 input [3:0] DATA4,
    output [7:0] SEGMENT,
    output [3:0] DIG
    );
	 reg [7:0] String [9:0];
	 reg [3:0] DigitState; // which digit is selected?
	 reg [7:0] SEGMENT_, DIG_;
	 reg [3:0] DATA [0:3];
	 
	 assign SEGMENT = SEGMENT_;
	 assign DIG = DIG_;
	 
	 initial begin
		DigitState = 0;
	 end
	 
	// run the clock and push the digits to the display.
	 always @(posedge CLK) begin
		DATA[3] <= DATA1; // update the data from inputs
		DATA[2] <= DATA2;
		DATA[1] <= DATA3;
		DATA[0] <= DATA4;

		if(DigitState > 3) DigitState = 0; // reset state
		// set the digit's segments
		SEGMENT_ <= getBCDFromHEX( DATA[DigitState] ); 
		// select the current digit.
		DIG_ <= getSELDigit(DigitState); 
		
		DigitState = DigitState+1; // increment digit state
	 end
	 
	 // Converts HEX character codes to BCD codes via case mapping
	 function [7:0] getBCDFromHEX;
		input [3:0] DataSelect; // HEX code
		begin
			case(DataSelect)
				0: getBCDFromHEX = ~8'b00111111; //ABCDEF      0
				1: getBCDFromHEX = ~8'b00110000; //BC          1
				2: getBCDFromHEX = ~8'b01011011; //ABDEG       2
				3: getBCDFromHEX = ~8'b01001111; //ABCDG       3
				4: getBCDFromHEX = ~8'b01100110; //BCFG        4
				5: getBCDFromHEX = ~8'b01101101; //ACDFG       5
				6: getBCDFromHEX = ~8'b01111101; //ACDEFG      6
				7: getBCDFromHEX = ~8'b00000111; //ABC         7
				8: getBCDFromHEX = ~8'b01111111; //ABCDEFG     8
				9: getBCDFromHEX = ~8'b01100111; //ABCFG       9
				
				10: getBCDFromHEX = ~8'b01110111; //ABCEFG      A
				11: getBCDFromHEX = ~8'b01111100; //CDEFG       b            Lower case
				12: getBCDFromHEX = ~8'b00111001; //ADEF        C
				13: getBCDFromHEX = ~8'b01011110; //BCDEG       d            Lower case
				14: getBCDFromHEX = ~8'b01111001; //ADEFG       E
				15: getBCDFromHEX = ~8'b01110001; //AEFG        F
				
				default: getBCDFromHEX = 8'b11111111;
			endcase
			
		end
	 endfunction
	 
	 // function returns the required code to select a certain 7-segment Anode.
	 function [3:0] getSELDigit;
		input [3:0] digit; // digit id
		begin
			// list of cases
			case(digit)
				0: getSELDigit = ~4'b0001;
				1: getSELDigit = ~4'b0010;
				2: getSELDigit = ~4'b0100;
				3: getSELDigit = ~4'b1000;
				
				default: getSELDigit = ~4'b0000; // select NONE.
			endcase
		end
	 endfunction
endmodule
