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
module SpeedController(
    input AE_CLK, // Clock for angular encoder
	 input PWM_CLK, // Clock for PWM
    input [7:0] Duty_In,
    input AngularEncoder, // AE Wire
    output PWM_Out,
	 output [7:0] Rate
	 );
	 
	 reg [7:0] Counter;//, SetCounted;
	 reg [9:0] Wait_Count;
	 reg [8:0] Duty_Offset;
	 reg [9:0] Count60Hz;
	 integer Rate_;
	 reg First;
	 
	 wire [7:0] SetCounted;
	 
	 assign Rate = Rate_;
	 
	 reg Average_CLK;
	 
	 initial begin
		First = 1;
		Counter = 0;
		Rate_ = 0;
		Wait_Count=0;
		Count60Hz = 0;
		//SetCounted=100;
	 end
	 
	 // Measured frequencies:
	 //	0 to 200 Hz
	 
	 always @ (posedge AE_CLK) begin
		//Average_CLK <= 0;
		if(First) begin // first check on posedge
			if(AngularEncoder) begin
				Wait_Count <= 0;
				Counter <= Counter+1; // increment counter
			end else begin
				First <= 0; // end of pulse
				//Average_CLK <= 1;
				//Counter <= 0; // reset counter
				//SetCounted <= Counter;
				//Rate_ <= ((Duty_In*2)-Counter == 0 && Duty_In > 0) ? 
				//					Duty_In : 
				//					(Duty_In*2)-Counter; // take difference
			end
		end else if(AngularEncoder) begin
			First <= 1; // Allow for next pulse
			Counter <= 1; // Count this pulse
		end else if(Wait_Count > 1000) begin
			// nothing is happening... speed stuck at 0!
			Wait_Count <= 0;
			Rate_ <= Duty_In;
		end else begin
			Wait_Count <= Wait_Count+1;
			Counter <= 0; // reset counter
		end
		
		// take offset between the two signals.
		//Duty_Offset <= (Duty_In*2)-SetCounted; // Accounts for real-time offset
		Duty_Offset <= 2*Duty_In-(Duty_In+SetCounted)/2;
		//Duty_Offset <= (Duty_In-SetCounted)*2;
		Rate_ <= ((Rate_ <= 10 && Duty_In > 10) || SetCounted == 0) ? 
						Duty_In : 
						(Duty_Offset > 255) ? 255 : Duty_Offset;
	 end
	 
	 
	 always @ (negedge AE_CLK) begin
		// 51.2k / 60Hz = 
		Count60Hz <= Count60Hz+1;
		Average_CLK <= 0;
		if(Count60Hz > 1707) begin // set
			Count60Hz <= 0;
			Average_CLK <= 1;
		end
	 end
	 
	 
	 PWM pwm1 ( 
		 .CLK(PWM_CLK), 
		 .DUTY_CYCLE(Rate_), 
		 .PWM_OUT(PWM_Out)
    );
	 
	 Average8 averager ( // provides concise averaging over time
		.CLK(Average_CLK), 
		.SampleIN(Counter), 
		.AverageOUT(SetCounted)
    );
endmodule
