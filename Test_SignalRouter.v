`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   02:03:51 03/02/2014
// Design Name:   SignalRouter8_1
// Module Name:   /home/eternia/Dropbox/Project Lab 1/Verilog/Test_SignalRouter.v
// Project Name:  SerialDebugger
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: SignalRouter8_1
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module Test_SignalRouter;

	// Inputs
	reg CLK;
	reg [7:0] IN1;
	reg [7:0] IN2;
	reg [7:0] IN3;
	reg [7:0] IN4;
	reg IN5;
	reg IN6;
	reg IN7;
	reg IN8;
	reg [7:0] C1;
	reg [7:0] C2;
	reg [7:0] C3;
	reg [7:0] C4;
	reg C5;
	reg C6;
	reg C7;
	reg C8;
	reg [7:0] ClkDiv5;
	reg [7:0] ClkDiv6;
	reg [7:0] ClkDiv7;
	reg [7:0] ClkDiv8;
	reg [7:0] PWMRate5;
	reg [7:0] PWMRate6;
	reg [7:0] PWMRate7;
	reg [7:0] PWMRate8;

	// Outputs
	wire [7:0] OUT1;
	wire [7:0] OUT2;
	wire [7:0] OUT3;
	wire [7:0] OUT4;
	wire OUT5;
	wire OUT6;
	wire OUT7;
	wire OUT8;

	// Bidirs
	 reg [23:0] RLoc;
	 reg [15:0] RSel;
	
	integer i,j;

	// Instantiate the Unit Under Test (UUT)
	SignalRouter8_1 uut (
		.CLK(CLK), 
		.IN1(IN1), 
		.IN2(IN2), 
		.IN3(IN3), 
		.IN4(IN4), 
		.IN5(IN5), 
		.IN6(IN6), 
		.IN7(IN7), 
		.IN8(IN8), 
		.C1(C1), 
		.C2(C2), 
		.C3(C3), 
		.C4(C4), 
		.C5(C5), 
		.C6(C6), 
		.C7(C7), 
		.C8(C8), 
		.ClkDiv5(ClkDiv5), 
		.ClkDiv6(ClkDiv6), 
		.ClkDiv7(ClkDiv7), 
		.ClkDiv8(ClkDiv8), 
		.PWMRate5(PWMRate5), 
		.PWMRate6(PWMRate6), 
		.PWMRate7(PWMRate7), 
		.PWMRate8(PWMRate8), 
		.OUT1(OUT1), 
		.OUT2(OUT2), 
		.OUT3(OUT3), 
		.OUT4(OUT4), 
		.OUT5(OUT5), 
		.OUT6(OUT6), 
		.OUT7(OUT7), 
		.OUT8(OUT8), 
		.RLoc(RLoc), 
		.RSel(RSel)
	);

	initial begin
		// Initialize Inputs
		CLK = 0;
		IN1 = 10;
		IN2 = 20;
		IN3 = 30;
		IN4 = 40;
		IN5 = 1;
		IN6 = 0;
		IN7 = 1;
		IN8 = 0;
		C1 = 1;
		C2 = 2;
		C3 = 3;
		C4 = 4;
		C5 = 0;
		C6 = 1;
		C7 = 0;
		C8 = 1;
		ClkDiv5 = 2;
		ClkDiv6 = 2;
		ClkDiv7 = 2;
		ClkDiv8 = 2;
		PWMRate5 = 50;
		PWMRate6 = 100;
		PWMRate7 = 200;
		PWMRate8 = 255;
		
		i = 0;
		repeat(8) begin
			RLoc[3*i +:3] = i;
			i=i+1;
		end
		
		i = 0;
		repeat(8) begin
			RSel[2*i +:2] = 2'b11;
			i=i+1;
		end

		// Wait 100 ns for global reset to finish
		#100;
        
		// loop through the first 4 outputs and set them to constants
		for(i=0;i<4;i=i+1) begin
			RSel[2*i +:2] = 0;
			#10;
		end
		
		// Loop through the next 4 outputs and loop through their settings (0->3)
		#100;
		for(i=4;i<8;i=i+1) begin
			for(j=0;j<4;j=j+1) begin
				RSel[2*i +:2] = j;
				#1000000;
			end
		end
		
		// Test routing function (output to selected bit)
		#100;
		RLoc[3*4 +:3] = 6; // set selected output
		RLoc[3*5 +:3] = 6;
		//RLoc[3*6 +:3] = 6;
		RLoc[3*7 +:3] = 6;
		
		// set output 6 to 
		for(j=0;j<4;j=j+1) begin
			RSel[2*6 +:2] = j;
			#1000000;
		end
	end
      
endmodule

