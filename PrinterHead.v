`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    22:44:13 05/02/2014 
// Design Name: 
// Module Name:    PrinterHead 
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
module PrinterHead(
    input CLK,
    input [7:0] Mode,
	 input [15:0] LineCounter,
    output PrinterDutyO,
    output reg [1:0] PrinterCTL, 
	 output reg LineCounterReset,
	 output reg Done // middle-izer done
    );
	 
	 reg [17:0] PCounter, lastLineCount;
	 reg [7:0] PrinterDuty;
	 /*reg SW1, SW2;
	 wire SW; // force-switch for printer head*/
	 
	 parameter S_PRINTER_STOP = 0;
	 parameter S_PRINTER_CONTROL = 1;
	 parameter S_PRINTER_CENTER = 2;
	 parameter S_PRINTER_COLLECT = 3;
	 parameter S_PRINTER_WAIT = 4;
	 
	 //parameter LINECOUNT = (1600*3)/2;
	 parameter LINECOUNT = 2400;
	 parameter SECONDCNT = 5120; // time for 1 second
	 parameter ADJUST_Middle = 150; // helps attune for speed to middle
	 parameter PSEC_LINES = 500; // min lines per second
	 
	 
	 initial begin
		PrinterDuty = 0;
		PrinterCTL = 0;
		LineCounterReset = 0;
		PCounter = 0;
		Done = 0;
		//TCounter = 0;
		lastLineCount = 0;
		//lastLineCount2 = 0;
	 end
	 
	 //xor(SW, SW1, SW2);
	 
	 always @ (posedge CLK) begin
		case (Mode)
			S_PRINTER_STOP: begin
					PrinterDuty <= 0;
					PrinterCTL <= 1;
					Done <= 0;
					LineCounterReset <= 1;
					PCounter <= 0;
				end
			S_PRINTER_CONTROL: begin
					Done <= 0;
					LineCounterReset <= 0; // reset line counter reset
					if((PrinterCTL == 2'b00) || (PrinterCTL == 2'b11))
						PrinterCTL <= 1;
					else if(LineCounter > LINECOUNT || PCounter > 500/* || SW*/) begin
						LineCounterReset <= 1; // reset line counter
						lastLineCount <= 0; // reset last line counter
						PrinterDuty <= 255;
						PrinterCTL <= ~PrinterCTL; // Reverse (GETS STUCK!)
						
						//SW1 <= (SW) ? ~SW1 : SW1; // Reset force switch
						PCounter <= 0; // time counter reset
					end else if(LineCounter-lastLineCount > 1) begin
						// something is happening, reset PCounter
						lastLineCount <= LineCounter;
						PCounter <= 0;
						PrinterDuty <= 255; // speed up!
					end else begin // find if stuck
						if(PCounter > 300) begin // nothing is happening
							PrinterDuty <= 60; // slow down, to prevent damage
						end
						PCounter <= PCounter + 1;
					end
					
					if(LineCounter > LINECOUNT-250) begin // slow down printer head!
						PrinterDuty <= 90; // slow down
					end
				end
			
			S_PRINTER_CENTER: begin
					LineCounterReset <= 0; // set to 0
					PrinterDuty <= 90; // 2/5 speed
					PrinterCTL <= 1; // move left
					
					if(LineCounter > (LINECOUNT/2-ADJUST_Middle) || PCounter > 2000 || Done) begin
						// stop printer head here.
						PrinterDuty <= 0; // 0 speed
						PCounter <= 0;
						Done <= 1;
					end else if(LineCounter-lastLineCount > 1) begin
						// nothing is happening, reset PCounter
						lastLineCount <= LineCounter;
						PCounter <= 0;
					end else begin // find if stuck
						PCounter <= PCounter + 1;
					end
				end
				
				
			S_PRINTER_COLLECT: begin
					LineCounterReset <= 0;
					PrinterDuty <= 100; // 0 speed
					PrinterCTL <= 2;
					
					if(LineCounter > 300 || Done) begin // 310?
							// stop printer head here.
							PrinterDuty <= 120; // 2/5 speed
							PrinterCTL <= 2; // move left to rail
							LineCounterReset <= 1;
							PCounter <= 0;
							Done <= 1;
							//meta <= SECONDCNT;  // wait 100 ms for printer head to goto right side
							//meta2 <= S_RETURN_HEAD; // Return state
							//state = enableStateChange ? S_WAIT : state; // goto wait.
						end
				end
		endcase
	 end
	 
	 // used to determine if number of counts per second is invalid
	 // This is used to get a stuck printer head
	 /*always @ (negedge CLK) begin
		if(TCounter >= SECONDCNT/8) begin
			if((LineCounter - lastLineCount2)*8 < PSEC_LINES) begin
				SW2 <= ~SW2;
				TCounter <= 0;
				lastLineCount2 <= LineCounter;
			end
		end else begin
			TCounter <= TCounter+1;
		end
	 end*/

	PWM pwmout(CLK, PrinterDuty, PrinterDutyO);
endmodule
