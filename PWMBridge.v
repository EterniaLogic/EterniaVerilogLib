`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:13:02 03/08/2014 
// Design Name: 
// Module Name:    PWMBridge 
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
module PWMBridge(
    input CLK,
    input [7:0] DUTY_CYCLE_1,
    input [7:0] DUTY_CYCLE_2,
    //input [7:0] DUTY_CYCLE_3,
    //input [7:0] DUTY_CYCLE_4,
    output PWM_1,
    output PWM_2
    //output PWM_3,
    //output PWM_4
    );
	 
	 PWM pwm1(CLK, DUTY_CYCLE_1, PWM_1);
	 PWM pwm2(CLK, DUTY_CYCLE_2, PWM_2);
	 //PWM pwm3(CLK, DUTY_CYCLE_3, PWM_3);
	 //PWM pwm4(CLK, DUTY_CYCLE_4, PWM_4);


endmodule
