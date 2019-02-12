`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    00:02:39 07/14/2015 
// Design Name: 
// Module Name:    ADCDriver 
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
module ADCDriver(input clk
    );
	 
	 // Driver for CS5528
	// Instantiate the module
		
		
		 parameter INIT=0;
		 parameter CSRS=1;
		 parameter SELFCAL=2; // 
		 parameter GAINSET=3; // set the gain for all channels
		 parameter AQCONV=4; // get data
		 parameter WAIT=15;
		 
		 reg waitTime; // cycles to wait
		 reg waitNextState; // next state for wait
		 reg [3:0] state;
		 
		 defparam sc1.Divider=4; // 100 Mhz * 5 accuracy
		 SubClock sc1(clk, SPICLK);
		 
		 initial begin
			state=0;
			waitTime=0;
			waitNextTime=0;
		 end
		 
		 always @(posedge spiclk) begin
			case(state)
				INIT: begin // initialize
						// send 0xFF 15 times through SPI
						
					end
				CSRS: begin // Channel setup registers
						
					end
				SELFCAL: begin // callibrate the ADC
						
					end
			endcase
		 end
endmodule
