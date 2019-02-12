`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    03:05:05 12/05/2014 
// Design Name: 
// Module Name:    PowerChannel 
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
module PowerChannel(
    input clk,
    input voltknob,
    input currentknob,
	 input powered, // Force value_out to 0 if 0
    output mode, // 0=voltage, 1=current
    output reg [17:0] value_out
    );
	 
	 reg [17:0] voltage, current;
	 
	 reg vreset, ireset, clkslow;
	 wire [15:0] clktimer;
	 EncodedRotatingKnob VKnob(clk,voltknob,voltage);
	 EncodedRotatingKnob IKnob(clk,currentknob,current);
	 initial begin
		vreset = 0;
		ireset = 0;
		voltage = 0;
		current = 0;
		value_out = 0;
	 end
	
	always @(posedge clk) begin
		clktimer = clktimer+1;
		if(clktimer >= 10000/2) begin // 10kHz clock
			clktimer = 0;
			clkslow = ~clkslow;
		end
	end
	
	always @(posedge clkslow) begin
		// determine the change in the encoder detectors
		
		
		
		if(~powered) begin // force to 0 if unpowered
			value_out = 0;
		end
	end
endmodule
