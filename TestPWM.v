`timescale 1ps / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   22:49:58 01/21/2014
// Design Name:   PWM
// Module Name:   /media/MStuffs/Dev/ise/testAISystem/TestPWM.v
// Project Name:  testAISystem
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: PWM
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module TestPWM(input CLK);

	// Inputs
	reg [7:0] DUTY_CYCLE;
	
	integer i;

	// Outputs
	wire PWM_OUT;

	// Instantiate the Unit Under Test (UUT)
	PWM uut (
		.CLK(CLK), 
		.DUTY_CYCLE(DUTY_CYCLE), 
		.PWM_OUT(PWM_OUT)
	);

	initial begin
		// Initialize Inputs
		DUTY_CYCLE = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here
		for(i=0;i<100;i=i+1) begin
			DUTY_CYCLE=i;
			#1;
		end

	end
	
      
endmodule

