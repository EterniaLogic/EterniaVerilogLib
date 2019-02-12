`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Brent Clancy
// 
// Create Date:    19:30:08 03/01/2014 
// Design Name: 
// Module Name:    SignalRouter8_1 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: Input signal router:
//					<RSel> Map:
//						00 - Route to nothing
//						01 - Route PWM
//						10 - Route Clock
//						11 - Route IN Signal
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module SignalRouter8_1(
	 input CLK,
    input [7:0] IN1,
	 input [7:0] IN2,
	 input [7:0] IN3,
	 input [7:0] IN4,
	 input IN5,
	 input IN6,
	 input IN7,
	 input IN8,
	 input [7:0] C1,
	 input [7:0] C2,
	 input [7:0] C3,
	 input [7:0] C4,
	 input C5,
	 input C6,
	 input C7,
	 input C8,
	 input [25:0] ClkDiv5,
	 input [25:0] ClkDiv6,
	 input [25:0] ClkDiv7,
	 input [25:0] ClkDiv8,
	 input [7:0] PWMRate5,
	 input [7:0] PWMRate6,
	 input [7:0] PWMRate7,
	 input [7:0] PWMRate8,
	 output [7:0] OUT1,
	 output [7:0] OUT2,
	 output [7:0] OUT3,
	 output [7:0] OUT4,
	 output OUT5,
	 output OUT6,
	 output OUT7,
	 output OUT8,
	 input [23:0] RLoc, // 8*4-1
	 input [15:0] RSel  // 8*2-1
    );
	 
	 reg [1:0] R;
	 reg [7:0] OUT1_,OUT2_,OUT3_,OUT4_,OUT5_,OUT6_,OUT7_,OUT8_;
	 reg [7:0] RMAP [7:0]; // two-dimensional array
	 wire [7:0] CLK5,CLK6,CLK7,CLK8;
	 wire [7:0] PWM5,PWM6,PWM7,PWM8;
	 integer incrementer;
	 
	 assign OUT1 = OUT1_;
	 assign OUT2 = OUT2_;
	 assign OUT3 = OUT3_;
	 assign OUT4 = OUT4_;
	 assign OUT5 = OUT5_;
	 assign OUT6 = OUT6_;
	 assign OUT7 = OUT7_;
	 assign OUT8 = OUT8_;
	 
	 initial begin
		OUT1_ = 0;
		OUT2_ = 0;
		OUT3_ = 0;
		OUT4_ = 0;
		OUT5_ = 0;
		OUT6_ = 0;
		OUT7_ = 0;
		OUT8_ = 0;
		RMAP[0] = 0;
		RMAP[1] = 0;
		RMAP[2] = 0;
		RMAP[3] = 0;
		RMAP[4] = 0;
		R=0;
	 end
	 
	 // High speed signal router
	 always @(negedge CLK) begin
		// Load values into the map
		// 8-bit routers
		RMAP[0] <= (RSel[1:0] == 3) ? IN1 : C1;
		RMAP[1] <= (RSel[3:2] == 3) ? IN2 : C2;
		RMAP[2] <= (RSel[5:4] == 3) ? IN3 : C3;
		RMAP[3] <= (RSel[7:6] == 3) ? IN4 : C4;
		
		// 1-bit routers
		RMAP[4][4]  <= (RSel[9:8] == 3) ? IN5 :      // 11
							(RSel[9:8] == 2) ? CLK5 :     // 10
							(RSel[9:8] == 1) ? PWM5 : C5; // 01 : 00
							
		RMAP[4][5]  <= (RSel[11:10] == 3) ? IN6 :     // 11 
							(RSel[11:10] == 2) ? CLK6 :    // 10 
							(RSel[11:10] == 1) ? PWM6 : C6;// 01 : 00
							
		RMAP[4][6]  <= (RSel[13:12] == 3) ? IN7 :     // 11 
							(RSel[13:12] == 2) ? CLK7 :    // 10  
							(RSel[13:12] == 1) ? PWM7 : C7;// 01 : 00
							
		RMAP[4][7]  <= (RSel[15:14] == 3) ? IN8 :     // 11
							(RSel[15:14] == 2) ? CLK8 :    // 10 
							(RSel[15:14] == 1) ? PWM8 : C8;// 01 : 00
		OUT8_ <= RMAP[4][RLoc[21 +:3]];
	 
		// set 8-bit signals with pathway routing
		OUT1_ <= RMAP[RLoc[0 +:3]]; // [2:0]
		OUT2_ <= RMAP[RLoc[3 +:3]]; // [5:3]
		OUT3_ <= RMAP[RLoc[6 +:3]];
		OUT4_ <= RMAP[RLoc[9 +:3]];
		OUT5_ <= RMAP[4][RLoc[12 +:3]];
		OUT6_ <= RMAP[4][RLoc[15 +:3]];
		OUT7_ <= RMAP[4][RLoc[18 +:3]];
		OUT8_ <= RMAP[4][RLoc[21 +:3]]; // [23:21]
	 end
	 
	 
	SubClockDyn clk5 (.CLK(CLK), .Freq(ClkDiv5), .OUTCLK(CLK5));
	SubClockDyn clk6 (.CLK(CLK), .Freq(ClkDiv6), .OUTCLK(CLK6));
	SubClockDyn clk7 (.CLK(CLK), .Freq(ClkDiv7), .OUTCLK(CLK7));
	SubClockDyn clk8 (.CLK(CLK), .Freq(ClkDiv8), .OUTCLK(CLK8));
	 
	PWM pwm5 (CLK5,PWMRate5,PWM5);
	PWM pwm6 (CLK6,PWMRate6,PWM6);
	PWM pwm7 (CLK7,PWMRate7,PWM7);
	PWM pwm8 (CLK8,PWMRate8,PWM8);
		 
	

endmodule
