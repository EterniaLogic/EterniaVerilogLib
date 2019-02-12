`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   04:40:03 04/28/2014
// Design Name:   SpeedController
// Module Name:   /home/eternia/Dropbox/Project Lab 1/Projects/MAIN_DEMOS/Full_March/AngularEncoderTest.v
// Project Name:  Full_March
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: SpeedController
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module AngularEncoderTest;

	// Inputs
	reg AE_CLK;
	reg PWM_CLK;
	reg [7:0] Duty_In;
	reg AngularEncoder;
	
	integer CC,CC2, CC3, TRate;

	// Outputs
	wire PWM_Out;
	wire [7:0] Rate;

	// Instantiate the Unit Under Test (UUT)
	SpeedController uut (
		.AE_CLK(AE_CLK), 
		.PWM_CLK(PWM_CLK), 
		.Duty_In(Duty_In), 
		.AngularEncoder(AngularEncoder), 
		.PWM_Out(PWM_Out), 
		.Rate(Rate)
	);

	initial begin
		// Initialize Inputs
		AE_CLK = 0;
		PWM_CLK = 0;
		Duty_In = 0;
		AngularEncoder = 0;
		CC=0;
		CC2=0;
		CC3=0;
		TRate = 130;

		// Wait 100 ns for global reset to finish
		#100;
		Duty_In = 100;
        
		// Add stimulus here
		while(1) begin
			AE_CLK = ~AE_CLK; // run clock
			#9766; // 5.12 kHz in nanoseconds
			
			if(CC2 == (10)) begin // 5120 Hz
				PWM_CLK = ~PWM_CLK;
				CC2 = 0;
			end
			
			if(CC3 >= 2560) begin //2560 is normal, set different for unstable
				CC3 = 0;
				//TRate = (TRate >= 130) ? 20 : TRate+1;
			end
			
			// wait for first 400Hz signal timeout
			if(CC >= (TRate*2)) begin
				CC=0;
				AngularEncoder = ~AngularEncoder; // set opposite
			end
			CC = CC+1;
			CC2 = CC2+1;
			CC3 = CC3+1;
		end

	end
      
endmodule

