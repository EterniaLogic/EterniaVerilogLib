`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Brent Clancy
// 
// Create Date:    09:05:56 01/21/2014 
// Design Name: 	 Pulse Width Modulation Controller
// Module Name:    PWM
// Project Name:   Ultrasound Range finder
// Target Devices: Spartan-3E (XC3S100E)
// Tool versions: Xilinx 14.6
// Description: This module converts a known CLK input to a PWM signal that
//					works a specified amount of time.
//
// Dependencies: none
//
// Revision: 
// Revision 0.02 - Added basic PWM layout
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module PWM(
    input CLK, // input clock
    input [9:0] DUTY_CYCLE, // 0-255 duty cycle (255 means 100% output)
    output PWM_OUT
    );
	 
	 // pwm to output
	 
	 reg [15:0] cycle; // 65535
	 
	 reg pwm;
	 assign PWM_OUT = pwm;
	 initial begin
		cycle = 0;
		pwm = 0;
	 end
	 
	 parameter CYCLE_SIZE = 1024; // tune this to fit exact
	 
	 // PWM signal 
	 always @(posedge CLK) begin
	   // cycle incrementer
		cycle <= (cycle >= CYCLE_SIZE) ? 0 : cycle+1;
		
		// assign pwm based on percentage (duty cycle) of the cycle size
		// for advanced
		pwm <= (cycle < DUTY_CYCLE) ? 1 : 0;
		// ^^ Complex expression
	 end
endmodule
