`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Brent Clancy
// 
// Create Date:    09:05:56 01/21/2014 
// Design Name: 
// Module Name:    ClockModule
// Project Name:   Ultrasound Range finder
// Target Devices: Spartan-3E (XC3S100E)
// Tool versions: Xilinx 14.6
// Description: This clock module handles all clock timing functions and outputs them
//					The output clocks are very accurate because there is no extra interference.				
//
// Dependencies: none
//////////////////////////////////////////////////////////////////////////////////
module ClockModule(
    input CLK, 
	 output CLK20Hz,
    output CLK240Hz, // Used for 7-SEG
	 output CLK5120Hz,	// 20Hz * 256
	 output CLK9600Hz,
	 output CLK12800Hz,
	 output CLK51_2kHz, // 256*200 Hz
	 output CLK84_48kHz, // Used for VEX Motor
	 output CLK576_kHz,	// 256* 147
	 output CLK6_25MHz
    );
	 
	 // Instantiate the module
	 defparam c0.Divider = 2500000;// 20 Hz
	 defparam c1.Divider = 208333;// 240 Hz
	 defparam c2.Divider = 9766;// 	5.12 kHz
	 defparam c3.Divider = 5208; // 	9.6 kHz
	 defparam c4.Divider = 3906; // 	12.8 kHz
	 defparam c5.Divider = 977; // 	37.12 kHz
	 defparam c6.Divider = 592;// 330*256 Hz (84480 Hz)
	 defparam c7.Divider = 87;	// 	576 kHz
	 defparam c8.Divider = 8;
	 SubClock c0 (CLK, CLK20Hz);
	 SubClock c1 (CLK, CLK240Hz);
	 SubClock c2 (CLK, CLK5120Hz);
	 SubClock c3 (CLK, CLK9600Hz);
	 SubClock c4 (CLK, CLK12800Hz);
	 SubClock c5 (CLK, CLK51_2kHz);
	 SubClock c6 (CLK, CLK84_48kHz);
	 SubClock c7 (CLK, CLK576_kHz);
	 SubClock c8 (CLK, CLK6_25MHz);

endmodule
