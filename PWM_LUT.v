`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Brent Clancy
// 
// Create Date:    09:05:56 01/21/2014 
// Design Name: 	 Pulse Width Modulation Controller
// Module Name:    PWM
// Project Name:   Ultrasound Range finder
// Target Devices: Spartan-3E (XC3S100E)
// Tool versions: Xilinx 14.6
// Description: This module converts a known CLK input to a PWM signal that
//					works a specified amount of time.
//
// Dependencies: none
//
// Revision: 
// Revision 0.02 - Added basic PWM layout
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module PWM(
    input CLK, // input clock
    input [7:0] DUTY_CYCLE, // 0-255 duty cycle (255 means 100% output)
    output PWM_OUT
    );
	 
	 // pwm to output
	 
	 integer cycle; // 65535
	 integer i; // cycle counter
	 
	 reg pwm;
	 assign PWM_OUT = pwm;
	 initial begin
		cycle = 0;
		pwm = 0;
	 end
	 
	 
	 parameter CYCLE_SIZE = 256; // tune this to fit exact
	 
	 
	 
	 // PWM signal 
	 always @(posedge CLK) begin
	   // cycle incrementer
		cycle <= (cycle >= CYCLE_SIZE) ? 0 : cycle+1;
		
		// assign pwm based on percentage (duty cycle) of the cycle size
		// for advanced
		//pwm <= (cycle < PWMLut(DUTY_CYCLE)) ? 1 : 0;
		pwm <= (cycle < DUTY_CYCLE) ? 1 : 0;
		// ^^ Complex expression
	 end
	 
	 // Calculated LUT:
	 // 	CYCLE_SIZE 
	 //	(CYCLE_SIZE*DUTY_CYCLE)>>8
	 //	Divide by 256 to provide a stable percentage
	 function [15:0] PWMLut;	 
		 input Duty;
		 begin
			case(Duty)
				0: PWMLut = 0;
				1: PWMLut = 0;
				2: PWMLut = 0;
				3: PWMLut = 1;
				4: PWMLut = 1;
				5: PWMLut = 1;
				6: PWMLut = 1;
				7: PWMLut = 2;
				8: PWMLut = 2;
				9: PWMLut = 2;
				10: PWMLut = 2;
				11: PWMLut = 3;
				12: PWMLut = 3;
				13: PWMLut = 3;
				14: PWMLut = 3;
				15: PWMLut = 4;
				16: PWMLut = 4;
				17: PWMLut = 4;
				18: PWMLut = 4;
				19: PWMLut = 4;
				20: PWMLut = 5;
				21: PWMLut = 5;
				22: PWMLut = 5;
				23: PWMLut = 5;
				24: PWMLut = 6;
				25: PWMLut = 6;
				26: PWMLut = 6;
				27: PWMLut = 6;
				28: PWMLut = 7;
				29: PWMLut = 7;
				30: PWMLut = 7;
				31: PWMLut = 7;
				32: PWMLut = 8;
				33: PWMLut = 8;
				34: PWMLut = 8;
				35: PWMLut = 8;
				36: PWMLut = 8;
				37: PWMLut = 9;
				38: PWMLut = 9;
				39: PWMLut = 9;
				40: PWMLut = 9;
				41: PWMLut = 10;
				42: PWMLut = 10;
				43: PWMLut = 10;
				44: PWMLut = 10;
				45: PWMLut = 11;
				46: PWMLut = 11;
				47: PWMLut = 11;
				48: PWMLut = 11;
				49: PWMLut = 11;
				50: PWMLut = 12;
				51: PWMLut = 12;
				52: PWMLut = 12;
				53: PWMLut = 12;
				54: PWMLut = 13;
				55: PWMLut = 13;
				56: PWMLut = 13;
				57: PWMLut = 13;
				58: PWMLut = 14;
				59: PWMLut = 14;
				60: PWMLut = 14;
				61: PWMLut = 14;
				62: PWMLut = 15;
				63: PWMLut = 15;
				64: PWMLut = 15;
				65: PWMLut = 15;
				66: PWMLut = 15;
				67: PWMLut = 16;
				68: PWMLut = 16;
				69: PWMLut = 16;
				70: PWMLut = 16;
				71: PWMLut = 17;
				72: PWMLut = 17;
				73: PWMLut = 17;
				74: PWMLut = 17;
				75: PWMLut = 18;
				76: PWMLut = 18;
				77: PWMLut = 18;
				78: PWMLut = 18;
				79: PWMLut = 19;
				80: PWMLut = 19;
				81: PWMLut = 19;
				82: PWMLut = 19;
				83: PWMLut = 19;
				84: PWMLut = 20;
				85: PWMLut = 20;
				86: PWMLut = 20;
				87: PWMLut = 20;
				88: PWMLut = 21;
				89: PWMLut = 21;
				90: PWMLut = 21;
				91: PWMLut = 21;
				92: PWMLut = 22;
				93: PWMLut = 22;
				94: PWMLut = 22;
				95: PWMLut = 22;
				96: PWMLut = 23;
				97: PWMLut = 23;
				98: PWMLut = 23;
				99: PWMLut = 23;
				100: PWMLut = 23;
				101: PWMLut = 24;
				102: PWMLut = 24;
				103: PWMLut = 24;
				104: PWMLut = 24;
				105: PWMLut = 25;
				106: PWMLut = 25;
				107: PWMLut = 25;
				108: PWMLut = 25;
				109: PWMLut = 26;
				110: PWMLut = 26;
				111: PWMLut = 26;
				112: PWMLut = 26;
				113: PWMLut = 26;
				114: PWMLut = 27;
				115: PWMLut = 27;
				116: PWMLut = 27;
				117: PWMLut = 27;
				118: PWMLut = 28;
				119: PWMLut = 28;
				120: PWMLut = 28;
				121: PWMLut = 28;
				122: PWMLut = 29;
				123: PWMLut = 29;
				124: PWMLut = 29;
				125: PWMLut = 29;
				126: PWMLut = 30;
				127: PWMLut = 30;
				128: PWMLut = 30;
				129: PWMLut = 30;
				130: PWMLut = 30;
				131: PWMLut = 31;
				132: PWMLut = 31;
				133: PWMLut = 31;
				134: PWMLut = 31;
				135: PWMLut = 32;
				136: PWMLut = 32;
				137: PWMLut = 32;
				138: PWMLut = 32;
				139: PWMLut = 33;
				140: PWMLut = 33;
				141: PWMLut = 33;
				142: PWMLut = 33;
				143: PWMLut = 34;
				144: PWMLut = 34;
				145: PWMLut = 34;
				146: PWMLut = 34;
				147: PWMLut = 34;
				148: PWMLut = 35;
				149: PWMLut = 35;
				150: PWMLut = 35;
				151: PWMLut = 35;
				152: PWMLut = 36;
				153: PWMLut = 36;
				154: PWMLut = 36;
				155: PWMLut = 36;
				156: PWMLut = 37;
				157: PWMLut = 37;
				158: PWMLut = 37;
				159: PWMLut = 37;
				160: PWMLut = 38;
				161: PWMLut = 38;
				162: PWMLut = 38;
				163: PWMLut = 38;
				164: PWMLut = 38;
				165: PWMLut = 39;
				166: PWMLut = 39;
				167: PWMLut = 39;
				168: PWMLut = 39;
				169: PWMLut = 40;
				170: PWMLut = 40;
				171: PWMLut = 40;
				172: PWMLut = 40;
				173: PWMLut = 41;
				174: PWMLut = 41;
				175: PWMLut = 41;
				176: PWMLut = 41;
				177: PWMLut = 41;
				178: PWMLut = 42;
				179: PWMLut = 42;
				180: PWMLut = 42;
				181: PWMLut = 42;
				182: PWMLut = 43;
				183: PWMLut = 43;
				184: PWMLut = 43;
				185: PWMLut = 43;
				186: PWMLut = 44;
				187: PWMLut = 44;
				188: PWMLut = 44;
				189: PWMLut = 44;
				190: PWMLut = 45;
				191: PWMLut = 45;
				192: PWMLut = 45;
				193: PWMLut = 45;
				194: PWMLut = 45;
				195: PWMLut = 46;
				196: PWMLut = 46;
				197: PWMLut = 46;
				198: PWMLut = 46;
				199: PWMLut = 47;
				200: PWMLut = 47;
				201: PWMLut = 47;
				202: PWMLut = 47;
				203: PWMLut = 48;
				204: PWMLut = 48;
				205: PWMLut = 48;
				206: PWMLut = 48;
				207: PWMLut = 49;
				208: PWMLut = 49;
				209: PWMLut = 49;
				210: PWMLut = 49;
				211: PWMLut = 49;
				212: PWMLut = 50;
				213: PWMLut = 50;
				214: PWMLut = 50;
				215: PWMLut = 50;
				216: PWMLut = 51;
				217: PWMLut = 51;
				218: PWMLut = 51;
				219: PWMLut = 51;
				220: PWMLut = 52;
				221: PWMLut = 52;
				222: PWMLut = 52;
				223: PWMLut = 52;
				224: PWMLut = 53;
				225: PWMLut = 53;
				226: PWMLut = 53;
				227: PWMLut = 53;
				228: PWMLut = 53;
				229: PWMLut = 54;
				230: PWMLut = 54;
				231: PWMLut = 54;
				232: PWMLut = 54;
				233: PWMLut = 55;
				234: PWMLut = 55;
				235: PWMLut = 55;
				236: PWMLut = 55;
				237: PWMLut = 56;
				238: PWMLut = 56;
				239: PWMLut = 56;
				240: PWMLut = 56;
				241: PWMLut = 56;
				242: PWMLut = 57;
				243: PWMLut = 57;
				244: PWMLut = 57;
				245: PWMLut = 57;
				246: PWMLut = 58;
				247: PWMLut = 58;
				248: PWMLut = 58;
				249: PWMLut = 58;
				250: PWMLut = 59;
				251: PWMLut = 59;
				252: PWMLut = 59;
				253: PWMLut = 59;
				254: PWMLut = 60;
				255: PWMLut = 60;
			endcase
		 end
	 endfunction


endmodule
