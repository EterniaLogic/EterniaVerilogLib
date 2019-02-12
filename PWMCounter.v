`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Brent Clancy
// 
// Create Date:    19:16:49 01/30/2014 
// Design Name: 
// Module Name:    PWMCounter 
// Project Name:   Ultrasound Range finder
// Target Devices: Spartan-3E (XC3S100E)
// Tool versions: Xilinx 14.6
// Description:	This PWM Counter counts the percentage of duty cycle
//				out of 255. The counter counts by using the positive edge and negative edge.
//
// Dependencies: none
//////////////////////////////////////////////////////////////////////////////////module PWMCounter(

module PWMCounter(
	 input CLK,	// cycle counter clock (PWM Freq * 256)
	 //input [7:0] BaseFreq, // frequency in which the PWM samples
    input PWMIn,
    output [7:0] CountOut,
	 output CLKOut	// Clocks when count has been modified.
    );
	 
	 reg [7:0] count;
	 reg [7:0] CountOut_;
	 reg CLKOut_, FirstOff;
	 
	 assign CountOut = CountOut_;
	 assign CLKOut = CLKOut_;
	 
	 reg reset_count;
	 
	 // initialize some variables
	 initial begin
		count = 0;
		CLKOut_ = 0;
		FirstOff = 0;
	 end
	 
	 // primary counter
	 always @(posedge CLK) begin
		case(PWMIn)
			0: begin
					// if PWM is off
					if(FirstOff) begin
						CountOut_ = count;
						CLKOut_ = 1;
						count = 0;
						
						FirstOff = 0;
					end else CLKOut_ = 0;
					
					count = 0;
				end
			1:begin
					// PWM is on
					FirstOff = 1; // First time off for PWM in, used when pwm is off
					count = count+1;
				end
		endcase
	 end
endmodule
