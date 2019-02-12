`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    01:37:55 06/22/2015 
// Design Name: 
// Module Name:    Controller 
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
module DCDCController(
	input clk,
	input [15:0] voltageSet,
	input [15:0] currentSet,
	input [23:0] DCDC_VSense,
	input [23:0] DCDC_CSense,
	output DCDC_Driver, // Output 
	output reg DCDC_CV
    );
	 
	 initial begin
		DCDC_CV = 0;
		DutyCycle=0;
	 end
	 
	// CSense approximate ADC input for 2.5mV
	parameter adc2_5mv = 12710; 
	wire PWMCLK;
	reg [15:0] DutyCycle; // 0 to 200
	
	defparam p1.CYCLE_SIZE = 255;
	PWM200 p1(clk, DutyCycle, DCDC_Driver); // PWM running at 200MHz
	
	// use PWM to keep voltage on
	// also use a table to approximate the voltage
	// after the table, make sure that the returned voltage is true
	// if the voltage is too high, use CV, else slightly increase until true
	
	always @ (posedge clk) begin
		// Manage the duty cycle to synchronize with the wanted voltage
		// Same idea as the ZVS phase
		// if CSense > CSet, decrease, else increase
		// if VSense < VSet, increase, else decrease
		DutyCycle <= maxDifference(maxDifference(voltageSet,DCDC_VSense>>8),
											maxDifference(currentSet,DCDC_CSense>>8))>>8;
											
		// turn off in overstating conditions
		if(DCDC_VSense>>8 > voltageSet) DutyCycle <= 0; 
		if(DCDC_CSense>>8 > currentSet) DutyCycle <= 0;		
		
		// Run CV: If Voltage > Wanted Voltage, convert 24 -> 16-bit
		DCDC_CV <= (DCDC_VSense<<8 > voltageSet) ? 1 : 0;
	end
	
	// finds the max value, then takes the difference
	// same as |a|-|b|
	function [15:0] maxDifference;
		input [15:0] a,b;
		begin
			maxDifference = (a<b) ? b-a : a-b;
		end
	endfunction
endmodule
