`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    22:13:39 06/27/2015 
// Design Name: 
// Module Name:    PWM200 
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
module PWM(
    input CLK, // input clock
    input [7:0] DUTY_CYCLE, // 0-65535 duty cycle (65535 means 100% output)
    output PWM_OUT
    );
	 
	 // pwm to output
	 
	 reg [7:0] cycle; // 65535
	 
	 reg pwm;
	 assign PWM_OUT = pwm;
	 initial begin
		cycle = 0;
		pwm = 0;
	 end
	 
	 parameter CYCLE_SIZE = 200; // tune this to fit exact
	 
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
