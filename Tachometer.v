`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Brent Clancy
// 
// Create Date:    12:27:05 03/05/2014 
// Design Name: 
// Module Name:    Tachometer_PWM 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: Takes in a Tachometer input and compares it to re-adjust for
//				a dynamic value based off of input.
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module AngularEncoder(
    input AE_CLK,
	 input PWM_CLK,
    input [7:0] Duty_In,
    input TachometerA, // White wire
    output PWM_Out,
	 output [7:0] Rate
	 );
	 
	 reg [7:0] NewDuty, Counter, Rate_;
	 reg First;
	 
	 assign Rate = Rate_;
	 
	 initial begin
		First = 1;
		NewDuty = 0;
		Counter = 0;
		Rate_ = 0;
	 end
	 
	 // Measured frequencies:
	 //	0 to 145 Hz
	 
	 always @ (posedge Tachometer_CLK) begin
		if(First) begin // first check on posedge
			if(TachometerA) begin
				Counter <= Counter+1; // increment counter
			end else begin
				First <= 0; // end of pulse
				Rate_ <= Counter;
			end
		end else if(TachometerA) begin
			First <= 1; // Allow for next pulse
			Counter <= 1; // Count this pulse
		end
	 end
	 
	 
	 PWM pwm1 (
		 .CLK(PWM_CLK), 
		 //.DUTY_CYCLE(NewDuty), 
		 .DUTY_CYCLE(Rate_), 
		 .PWM_OUT(PWM_Out)
    );
endmodule
