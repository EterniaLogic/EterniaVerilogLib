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
module Segment7(
    input CLK,
    input [7:0] DATA1, // multiple data variables,
	 input [7:0] DATA2, // this version of verilog
	 input [7:0] DATA3, // doesnt support 2D I/O arrays.
	 input [7:0] DATA4,
    output [7:0] SEGMENT,
    output [3:0] DIG
    );
	 
	 reg [3:0] DigitState; // which digit is selected?
	 reg [7:0] SEGMENT_, DIG_;
	 reg [7:0] DATA [0:3];
	 
	 assign SEGMENT = SEGMENT_;
	 assign DIG = DIG_;
	 
	 initial begin
		DigitState = 0;
	 end
	 
	 always @(posedge CLK) begin
		DATA[3] <= DATA1;
		DATA[2] <= DATA2;
		DATA[1] <= DATA3;
		DATA[0] <= DATA4;
		if(DigitState > 3) DigitState = 0; // reset state
		// set the digit's segments
		SEGMENT_ <= getBCDFromASCII( DATA[DigitState] ); 
		// select the current digit.
		DIG_ <= getSELDigit(DigitState); 
		
		DigitState = DigitState+1; // increment digit state
	 end
	 
	 // Converts ASCII character codes to BCD codes via case mapping
	 function [7:0] getBCDFromASCII;
		input [7:0] DataSelect; // ascii code
		begin
			// only applicable for 7-segment options are shown...
			//	most misc ASCII cannot be show because they can cause conflicts...
			// and they will probably not even look close to the symbol.
			case(DataSelect)
				"!": getBCDFromASCII = ~8'b10000110; // 32
				"\"":getBCDFromASCII = ~8'b00100010; // 38
				"'": getBCDFromASCII = ~8'b00100000; // 39
				"-": getBCDFromASCII = ~8'b01000000; // 45
				".": getBCDFromASCII = ~8'b10000000; // 46
				
				
				// numbers (starting from ASCII 48)
				"0": getBCDFromASCII = ~8'b00111111; //ABCDEF      0
				"1": getBCDFromASCII = ~8'b00110000; //BC          1
				"2": getBCDFromASCII = ~8'b01011011; //ABDEG       2
				"3": getBCDFromASCII = ~8'b01001111; //ABCDG       3
				"4": getBCDFromASCII = ~8'b01100110; //BCFG        4
				"5": getBCDFromASCII = ~8'b01101101; //ACDFG       5
				"6": getBCDFromASCII = ~8'b01111101; //ACDEFG      6
				"7": getBCDFromASCII = ~8'b00000111; //ABC         7
				"8": getBCDFromASCII = ~8'b01111111; //ABCDEFG     8
				"9": getBCDFromASCII = ~8'b01100111; //ABCFG       9
				
				// other optional ascii
				"=": getBCDFromASCII = ~8'b01001000; // 61
				
				"A": getBCDFromASCII = ~8'b01110111; //ABCEFG      A
				"B": getBCDFromASCII = ~8'b01111100; //CDEFG       b            Lower case
				"C": getBCDFromASCII = ~8'b00111001; //ADEF        C
				"D": getBCDFromASCII = ~8'b01011110; //BCDEG       d            Lower case
				"E": getBCDFromASCII = ~8'b01111001; //ADEFG       E
				"F": getBCDFromASCII = ~8'b01110001; //AEFG        F
				"G": getBCDFromASCII = ~8'b00111101; //ACDEF       G
				"H": getBCDFromASCII = ~8'b00110100; //CEF         h            Lower case
				"I": getBCDFromASCII = ~8'b00110000; //EF          i            Lower case
				"J": getBCDFromASCII = ~8'b00001110; //DEF         J
				"K": getBCDFromASCII = ~8'b00110110; //BCEF        K            (looks like H)
				"L": getBCDFromASCII = ~8'b00111000; //DEF         L
				"M": getBCDFromASCII = ~8'b00110111; //ABCEF       M            (looks like tall pi)
				"N": getBCDFromASCII = ~8'b01010100; //CEG         N            (looks like pi)
				"O": getBCDFromASCII = ~8'b01011100; //CDEG        o            Lower case
				"P": getBCDFromASCII = ~8'b01111011; //ABEFG       P
				"Q": getBCDFromASCII = ~8'b10111111; //ABCDEF.     Q            Q with dot for tail
				"R": getBCDFromASCII = ~8'b00110001; //AEF         r            Lower case
				"S": getBCDFromASCII = ~8'b00101101; //ACDF        S            5 without middle
				"T": getBCDFromASCII = ~8'b01111000; //DEFG        t            E without top
				"U": getBCDFromASCII = ~8'b00011100; //CDE         u            upside-down pi
				"V": getBCDFromASCII = ~8'b00101010; //BDF         V            tall U w/o sides
				"W": getBCDFromASCII = ~8'b00111110; //BCDEF       W            tall pi
				"X": getBCDFromASCII = ~8'b00110110; //BCEF        X            two tall bars
				"Y": getBCDFromASCII = ~8'b01101110; //BCDFG       y            tall Lower case            
				"Z": getBCDFromASCII = ~8'b00011011; //ABDE        Z            2 without middle
				
				// other optional ASCII
				"_": getBCDFromASCII = ~8'b00001000; // 95
				
				// clone of above capitol letters.
				"a": getBCDFromASCII = ~8'b01110111; //ABCEFG      A
				"b": getBCDFromASCII = ~8'b01111100; //CDEFG       b            Lower case
				"c": getBCDFromASCII = ~8'b00111001; //ADEF        C
				"d": getBCDFromASCII = ~8'b01011110; //BCDEG       d            Lower case
				"e": getBCDFromASCII = ~8'b01111001; //ADEFG       E
				"f": getBCDFromASCII = ~8'b01110001; //AEFG        F
				"g": getBCDFromASCII = ~8'b00111101; //ACDEF       G
				"h": getBCDFromASCII = ~8'b00110100; //CEF         h            Lower case
				"i": getBCDFromASCII = ~8'b00110000; //EF          i            Lower case
				"j": getBCDFromASCII = ~8'b00001110; //DEF         J
				"k": getBCDFromASCII = ~8'b00110110; //BCEF        K            (looks like H)
				"l": getBCDFromASCII = ~8'b00111000; //DEF         L
				"m": getBCDFromASCII = ~8'b00110111; //ABCEF       M            (looks like tall pi)
				"n": getBCDFromASCII = ~8'b01010100; //CEG         N            (looks like pi)
				"o": getBCDFromASCII = ~8'b01011100; //CDEG        o            Lower case
				"p": getBCDFromASCII = ~8'b01111011; //ABEFG       P
				"q": getBCDFromASCII = ~8'b10111111; //ABCDEF.     Q            Q with dot for tail
				"r": getBCDFromASCII = ~8'b00110001; //AEF         r            Lower case
				"s": getBCDFromASCII = ~8'b00101101; //ACDF        S            5 without middle
				"t": getBCDFromASCII = ~8'b01111000; //DEFG        t            E without top
				"u": getBCDFromASCII = ~8'b00011100; //CDE         u            upside-down pi
				"v": getBCDFromASCII = ~8'b00101010; //BDF         V            tall U w/o sides
				"w": getBCDFromASCII = ~8'b00111110; //BCDEF       W            tall pi
				"x": getBCDFromASCII = ~8'b00110110; //BCEF        X            two tall bars
				"y": getBCDFromASCII = ~8'b01101110; //BCDFG       y            tall Lower case            
				"z": getBCDFromASCII = ~8'b00011011; //ABDE        Z            2 without middle
				
				
				
				default: getBCDFromASCII = 8'b11111111;
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
