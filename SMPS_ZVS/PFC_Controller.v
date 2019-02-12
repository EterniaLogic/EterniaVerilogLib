`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    01:44:31 06/22/2015 
// Design Name: 
// Module Name:    PFC_Controller 
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
module PFC_Controller(
    input clk,
    input [23:0] PFC_InVSense,
    output [23:0] PFC_OutVSense,
    output wire PFC_Driver
    );
	
	 // The PFC Controller is just a boost converter, but with one catch:
	 // 	Since PFC_InVSense is being pulled from, it will variate, so any variations can
	 // 	be accounted for by increasing the Duty Cycle based on InVSense.
	 // 	OutVSense will also play a factor in increasing the duty cycle.
	 //	PFC_In < 30V: 40% Duty increase
	 //	PFC_OutVSense < 90V: 40% Duty increase
	 // 0-200V
	 // 200/2^24
	parameter V120=10066329; // 120V ADC
	wire PWMCLK;
	reg [7:0] DutyCycle; // 0 to 200
	
	PWM200(clk, DutyCycle, PFC_Driver); // PWM running at 200MHz
	
	always @(posedge clk) begin
		if(PFC_OutVSense < V120) begin
			// lop on 40% duty cycle with the difference between voltages
			DutyCycle=80+ADV(PFC_OutVSense-PFC_InVSense);
			end else begin
			DutyCycle=0; // nil output
		end
	end
	
	//16777216
	// difference between PFCout and pfcin
	function [23:0] ADCV;
		input [23:0] DValue;
		begin
			if(Dvalue < 40000) ADCV=0; else
			if(Dvalue < 84308) ADCV=1; else
			if(Dvalue < 168615) ADCV=2; else
			if(Dvalue < 252923) ADCV=3; else
			if(Dvalue < 337230) ADCV=4; else
			if(Dvalue < 421538) ADCV=4; else
			if(Dvalue < 505846) ADCV=5; else
			if(Dvalue < 590153) ADCV=6; else
			if(Dvalue < 674461) ADCV=7; else
			if(Dvalue < 758769) ADCV=8; else
			if(Dvalue < 843076) ADCV=9; else
			if(Dvalue < 927384) ADCV=10; else
			if(Dvalue < 1011691) ADCV=11; else
			if(Dvalue < 1095999) ADCV=12; else
			if(Dvalue < 1180307) ADCV=12; else
			if(Dvalue < 1264614) ADCV=13; else
			if(Dvalue < 1348922) ADCV=14; else
			if(Dvalue < 1433230) ADCV=15; else
			if(Dvalue < 1517537) ADCV=16; else
			if(Dvalue < 1601845) ADCV=17; else
			if(Dvalue < 1686152) ADCV=18; else
			if(Dvalue < 1770460) ADCV=19; else
			if(Dvalue < 1854768) ADCV=20; else
			if(Dvalue < 1939075) ADCV=20; else
			if(Dvalue < 2023383) ADCV=21; else
			if(Dvalue < 2107690) ADCV=22; else
			if(Dvalue < 2191998) ADCV=23; else
			if(Dvalue < 2276306) ADCV=24; else
			if(Dvalue < 2360613) ADCV=25; else
			if(Dvalue < 2444921) ADCV=26; else
			if(Dvalue < 2529229) ADCV=27; else
			if(Dvalue < 2613536) ADCV=28; else
			if(Dvalue < 2697844) ADCV=28; else
			if(Dvalue < 2782151) ADCV=29; else
			if(Dvalue < 2866459) ADCV=30; else
			if(Dvalue < 2950767) ADCV=31; else
			if(Dvalue < 3035074) ADCV=32; else
			if(Dvalue < 3119382) ADCV=33; else
			if(Dvalue < 3203689) ADCV=34; else
			if(Dvalue < 3287997) ADCV=35; else
			if(Dvalue < 3372305) ADCV=36; else
			if(Dvalue < 3456612) ADCV=36; else
			if(Dvalue < 3540920) ADCV=37; else
			if(Dvalue < 3625228) ADCV=38; else
			if(Dvalue < 3709535) ADCV=39; else
			if(Dvalue < 3793843) ADCV=40; else
			if(Dvalue < 3878150) ADCV=41; else
			if(Dvalue < 3962458) ADCV=42; else
			if(Dvalue < 4046766) ADCV=43; else
			if(Dvalue < 4131073) ADCV=44; else
			if(Dvalue < 4215381) ADCV=44; else
			if(Dvalue < 4299689) ADCV=45; else
			if(Dvalue < 4383996) ADCV=46; else
			if(Dvalue < 4468304) ADCV=47; else
			if(Dvalue < 4552611) ADCV=48; else
			if(Dvalue < 4636919) ADCV=49; else
			if(Dvalue < 4721227) ADCV=50; else
			if(Dvalue < 4805534) ADCV=51; else
			if(Dvalue < 4889842) ADCV=52; else
			if(Dvalue < 4974149) ADCV=52; else
			if(Dvalue < 5058457) ADCV=53; else
			if(Dvalue < 5142765) ADCV=54; else
			if(Dvalue < 5227072) ADCV=55; else
			if(Dvalue < 5311380) ADCV=56; else
			if(Dvalue < 5395688) ADCV=57; else
			if(Dvalue < 5479995) ADCV=58; else
			if(Dvalue < 5564303) ADCV=59; else
			if(Dvalue < 5648610) ADCV=59; else
			if(Dvalue < 5732918) ADCV=60; else
			if(Dvalue < 5817226) ADCV=61; else
			if(Dvalue < 5901533) ADCV=62; else
			if(Dvalue < 5985841) ADCV=63; else
			if(Dvalue < 6070149) ADCV=64; else
			if(Dvalue < 6154456) ADCV=65; else
			if(Dvalue < 6238764) ADCV=66; else
			if(Dvalue < 6323071) ADCV=67; else
			if(Dvalue < 6407379) ADCV=67; else
			if(Dvalue < 6491687) ADCV=68; else
			if(Dvalue < 6575994) ADCV=69; else
			if(Dvalue < 6660302) ADCV=70; else
			if(Dvalue < 6744609) ADCV=71; else
			if(Dvalue < 6828917) ADCV=72; else
			if(Dvalue < 6913225) ADCV=73; else
			if(Dvalue < 6997532) ADCV=74; else
			if(Dvalue < 7081840) ADCV=75; else
			if(Dvalue < 7166148) ADCV=75; else
			if(Dvalue < 7250455) ADCV=76; else
			if(Dvalue < 7334763) ADCV=77; else
			if(Dvalue < 7419070) ADCV=78; else
			if(Dvalue < 7503378) ADCV=79; else
			ADCV=80;
		end
	endfunction
endmodule
