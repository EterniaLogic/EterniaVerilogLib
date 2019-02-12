`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    05:07:53 07/27/2015 
// Design Name: 
// Module Name:    ADC_Driver 
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
module ADC_Driver(
    input clk,
    input SDI,
    output SDO,
    output SCLK,
    output [23:0] DCDC_VSense1,
    output [23:0] DCDC_CSense1,
    output [23:0] DCDC_VSense2,
    output [23:0] DCDC_CSense2,
    output [23:0] V50_VSense,
    output [23:0] V50_CSense,
    output [23:0] PFC_VSense,
    outpu [23:0]t PFC_CSense
    );
	
	// Drive the CS5528 ADC

endmodule
