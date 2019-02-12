`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:50:57 02/27/2014 
// Design Name: 
// Module Name:    RS232 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: RS232 Receiver; Used to debug the Basys board by setting certain 
//						variables.
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module RS232_1(
	 input clk, // clk*5
    input RX, // rx pin (TX as seen from device)
    output reg TX, // tx pin (RX seen from device)
    output reg ReceiveCLK, // clocked when a full char has been received.
	 input sendCLK, // clocked when a full char has been put into the buffer.
	 output reg SentCLK, // data has been sent, useful for Async Senders
	 output reg [BITS1:0] RXData, // data received from device
	 input [BITS1:0] TXData // data sending (en route, clocked by sendCLK)
    );
	 
	 parameter BITS=16;	// Bits in/out
	 parameter MAJ=3; 	// Majority Bits
	 parameter CLKSPD=100000000; // input clock speed
	 parameter RSSPD=10000000; // input clock speed
	 
	 
	 // Calculated parameters
	 parameter BITS1=BITS-1;
	 parameter MAJ1=2;
	 parameter MAJR=2; // 5>>1 => 2
	 
	 reg Receiving, Sending; // receiving data
	 reg [7:0] ReceiveCounter, SendingCounter;
	 wire CLK;
	 
	 // Majority Rule counters
	 reg [4:0] Majority, MajorityCounter, MajorityCounter2;
	 reg TSet;
	 
	 initial begin
		ReceiveCLK = 0;
		Receiving = 0;
		ReceiveCounter = 0;
		Sending = 0;
		SendingCounter = 0;
		Majority=0;
		MajorityCounter=0;
		MajorityCounter2=0;
		TSet=0;
		TX=0;
		SentCLK=0;
		RXData=0;
	 end
	 
	 defparam clk1.Divider=100000000/((BITS+MAJ)*RSSPD);
	 SubClock clk1(clkin, CLK);
	 
	 // RX will clock, first clock will activate the cycle.
	 // Perform Majority rule with 5 clocks, Majority rule improves efficiency
	 always @ (posedge CLK) begin
		ReceiveCLK <= 0;
	 
	   if(Receiving) begin
			TSet <= 0;
			if(MajorityCounter >= 4) begin // majority rule count
				MajorityCounter <= 0;
				// Receive data! Set to true if majority ruled
				RXData[ReceiveCounter] <= ~(Majority > MAJR); // RXData is reverse

				
				// reset receiving counter
				if(ReceiveCounter >= BITS1) begin
					ReceiveCounter <= 0;
					Receiving <= 0;
					ReceiveCLK <= 1;
				// ELSE: increment receivecounter	
				end else ReceiveCounter <= ReceiveCounter + 1;
				
				Majority <= 0; //reset majority
			end else begin
				MajorityCounter <= MajorityCounter+1; //keep track
				Majority <= (RX) ? Majority+1 : Majority; // increment by 1
			end
		end
		
		// Start receiving if RX == 1
		TSet <= (~Receiving && RX) ? 1 : TSet; // keep on
		if(TSet)	begin
			if(MajorityCounter >= MAJ1) begin // use counter to offset
				MajorityCounter <= 0;
				
				ReceiveCounter <= 0;
				RXData <= 1; // RXData is reverse
				Receiving <= 1; // clock receiving clock
				Majority <= 0;
				TSet <= 0;
			end else begin
				MajorityCounter <= MajorityCounter+1;
			end
		end
	 end
	 
	 
	 // Sending occurs on the negative edge.
	 // This allows for dedicated outputs.
	 always @(negedge CLK) begin
		SentCLK <= 0;
		
		if(sendCLK && ~Sending) begin
			TX <= 1; // Send start bit!
			SendingCounter <= 0;
			Sending <= 1; // start sending information over
		end
		
		// Sending section; Send information over!
		if(Sending) begin
			if(MajorityCounter2 >= MAJ1) begin // majority rule count
				MajorityCounter2 <= 0; // reset counter
				TX <= ~TXData[SendingCounter];

				
				// reset receiving counter if at byte size
				if(SendingCounter >= BITS1) begin
					SendingCounter <= 0;
					Sending <= 0;
					TX <= 1;
					SentCLK <= 1;
				// ELSE: increment sending counter
				end else SendingCounter <= SendingCounter + 1;
			end else begin // count the region
				MajorityCounter2 <= MajorityCounter2+1; 
			end
		end
	end
endmodule
