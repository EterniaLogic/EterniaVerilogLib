`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    08:46:27 06/30/2015 
// Design Name: 
// Module Name:    FrontPanel 
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
module FrontPanel(
    input clk,
    input RotaryVa1,
	 input RotaryVb1,
    input RotaryCa1,
	 input RotaryCb1,
    input RotaryVa2,
	 input RotaryVb2,
    input RotaryCa2,
	 input RotaryCb2,
    output DisplayEnable,
    output [3:0] DisplayData, // 7-4 bits
    output DisplayRS, // Register select
	 output backlight
    );

	wire charDone; 
	wire RV1; // used to detect if V1 is going clockwise or counter-clockwise
	reg [7:0] setCharacter;
	reg changeline; // toggle lines
	reg [15:0] voltage1, voltage2, current1, current2;
	reg [15:0] V1count, V2count, C1count, C2count;
	
	GHI_LCD_16x2 lcd1(clk, setCharacter, changeline, DisplayData, DisplayRS, backlight, DisplayEnable, charDone);
	
	defparam sclk.Divider=40000000; //Approx 200 mS, 5 Hz
	SubClock sclk(clk,secCLK);
	
	initial begin
		setCharacter=0;
		changeline=0;
		voltage1=0;
		voltage2=0;
		current1=0;
		current2=0;
		V1count=32768; // middle of 65536 for differential
		V2count=32768; 
		C1count=32768;
		C2count=32768;
	end
	
	xor(RV1,RotaryVa1,RotaryVb1);
	xor(RC1,RotaryCa1,RotaryCb1);
	xor(RV2,RotaryVa2,RotaryVb2);
	xor(RC2,RotaryCa2,RotaryCb2);

	// PPR increase -> faster rotation (max 24 ppr => 1V per 200mS)
	// 1pps => 1mV per second

	// detect if Va1 is before or after Vb1
	// speed is defined by time in between the two
	always @(posedge RotaryVa1) begin
		if(RV1) begin
			// RV1=1 -> this is forward, CW
			V1count=V1count+1;
		end else begin
			// RV1=0 -> this is forward, CCW
			V1count=V1count-1;
		end
	end
	
	always @(posedge RotaryCa1) begin
		if(RC1) begin
			// RC1=1 -> this is forward, CW
			C1count=C1count+1;
		end else begin
			// RC1=0 -> this is forward, CCW
			C1count=C1count-1;
		end
	end
	
	always @(posedge RotaryVa2) begin
		if(RV2) begin
			// RV2=1 -> this is forward, CW
			V2count=V2count+1;
		end else begin
			// RV2=0 -> this is forward, CCW
			V2count=V2count-1;
		end
	end
	
	always @(posedge RotaryCa2) begin
		if(RC2) begin
			// RC2=1 -> this is forward, CW
			C2count=C2count+1;
		end else begin
			// RC2=0 -> this is forward, CCW
			C2count=C2count-1;
		end
	end
	
	always @(posedge secCLK) begin
		// 200mS, decide how much goes into the voltage/current based on PPR
		if(V1count > 32768) begin
			voltage1 <= voltage1+PPRGet(V1count-32768);
		end else if(V1count < 32768) begin
			voltage1 <= voltage1-PPRGet(32768-V1count);
		end
		if(C1count > 32768) begin
			current1 <= current1+PPRGet(C1count-32768);
		end else if(C1count < 32768) begin
			current1 <= current1-PPRGet(32768-C1count);
		end
		if(V2count > 32768) begin
			voltage2 <= voltage2+PPRGet(V2count-32768);
		end else if(voltage2 < 32768) begin
			voltage2 <= voltage2-PPRGet(32768-V2count);
		end
		if(C1count > 32768) begin
			current2 <= current2+PPRGet(C1count-32768);
		end else if(C1count < 32768) begin
			current2 <= current2-PPRGet(32768-C1count);
		end
		//V1count<=0;
	end
	
	function [15:0] PPRGet;
	input [15:0] PPR;
		begin
			case(PPR)
				1: PPRGet=5;
				2: PPRGet=15;
				3: PPRGet=45;
				4: PPRGet=94;
				5: PPRGet=163;
				6: PPRGet=253;
				7: PPRGet=361;
				8: PPRGet=490;
				9: PPRGet=639;
				10: PPRGet=807;
				11: PPRGet=995;
				12: PPRGet=1203;
				13: PPRGet=1431;
				14: PPRGet=1678;
				15: PPRGet=1945;
				16: PPRGet=2233;
				17: PPRGet=2539;
				18: PPRGet=2866;
				19: PPRGet=3213;
				20: PPRGet=3579;
				21: PPRGet=3965;
				22: PPRGet=4371;
				23: PPRGet=4797;
				24: PPRGet=5242;
			endcase
		end
	endfunction
endmodule
