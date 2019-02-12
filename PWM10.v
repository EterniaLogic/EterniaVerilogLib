`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:08:41 12/04/2014 
// Design Name: 
// Module Name:    PWM10 
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
module PWM10(
    input clk,
    input [3:0] duty,
    output pwm_out
    );
	 
	 // pwm to output
	 reg [4:0] cycle; // 65535
	 
	 reg pwm;
	 assign pwm_out = pwm;
	 initial begin
		cycle = 0;
		pwm = 0;
	 end
	 
	 parameter CYCLE_SIZE = 10; // tune this to fit exact
	 
	 // PWM signal 
	 always @(posedge clk) begin
	   // cycle incrementer
		cycle <= (cycle >= CYCLE_SIZE) ? 0 : cycle+1;
		
		// assign pwm based on percentage (duty cycle) of the cycle size
		// for advanced
		pwm <= (cycle < duty) ? 1 : 0;
		// ^^ Complex expression
	 end

endmodule
