`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    01:47:19 06/22/2015 
// Design Name: 
// Module Name:    SMPS_ZVS_Controller 
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
module SMPS_ZVS_Controller(
    input clk,
    input [23:0] SMPS_50V_VSense,
    input [23:0] SMPS_50V_CSense,
    output SMPS_Driver1,
    output SMPS_Driver2,
    output SMPS_Driver3,
    output SMPS_Driver4
    );
	 
	// Manages the SMPS Driver, VSense and CSense are useful for keeping a stable 50V value
	// CSense allows to sense a large and sudden current draw to force the SMPS drivers to max out if over spec.
	reg [7:0] DutyCycle; // 0 to 65535
	reg CLK1,CLK2,CLK3,CLK4;
	reg [7:0] phase; // main phase
	reg [8:0] mainPhase1; // phase of first pwm
	wire PWMCLK;
	reg [7:0] phase2,phase4; // 180* phase out of sync
	reg rst3, rst4;
	
	initial begin
		DutyCycle=102; // enforced 40% Duty cycle
		CLK1=0;
		CLK2=0;
		CLK3=0;
		CLK4=0;
		phase=0; // primary phase that is calculated
		phase2=255; // phase length is doubled due to CLK*2 (would be 127)
		phase4=255;
		rst3=0;
		rst4=0;
		mainPhase1=0;
	end
	
	defparam sc1.Divider=4; // approx 5MHz
	SubClock sc1(clk, PWMCLK);
	
	PWMR p1(CLK1, 0, DutyCycle, SMPS_Driver1); // 90kHz
	PWMR p2(CLK2, 0, DutyCycle, SMPS_Driver2); // 90kHz
	PWMR p3(CLK3, rst3, DutyCycle, SMPS_Driver3); // 90kHz
	PWMR p4(CLK4, rst4, DutyCycle, SMPS_Driver4); // 90kHz
	
	always @(posedge PWMCLK) begin
		// phase changes div=9 (8.7)
		rst3=0;
		rst4=0;
		
		CLK1=~CLK1; // CLK1 is enforced
		mainPhase1 = mainPhase1+1; // mainPhase used to sync other phases
		
		// enforce CLK2 is 180* out of sync
		if(phase2==0) begin
			CLK2=~CLK2;
		end
		phase2 = (phase2>0) ? phase2-1 : 0;
		
		// doubly enforce that the other phases are different
		if(phase==0) begin // phase complete
			CLK3=~CLK3;
			if(phase4==0) begin // phase complete
				CLK4=~CLK4;
			end else phase4 = (phase4==0) ? 255 : phase4;
			phase4 = (phase4>0) ? phase4-1 : 0;
			
			// recalculate phase difference
			// 	reset PWM after mainPhase1 hits 0
			if(mainPhase1 == 0) begin
				// recalc
				rst3=1;
				rst4=1;
				phase4=255;
				// double 24-bit variables make the LUT expensive, better/easier to just calculate
				// if over 50.5V, no duty
				if(SMPS_50V_VSense < 12007693) begin
					phase = ((SMPS_50V_VSense>SMPS_50V_CSense) ? // Find Max value
								(SMPS_50V_VSense-SMPS_50V_CSense) : // find difference
								(SMPS_50V_CSense-SMPS_50V_VSense)
							  )>>17;     // 25-bit to 8-bit
				end else phase=0;
			end
		end else phase = (phase==0) ? 255 : phase;
		phase = (phase>0) ? phase-1 : 0;
	end
endmodule
