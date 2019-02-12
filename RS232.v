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
module RS232(
	 input CLK,
    input RX, // rx pin (TX as seen from device)
    output TX, // tx pin (RX seen from device)
    output ReceiveCLK, // clocked when a full char has been received.
	 input sendCLK, // clocked when a full char has been put into the buffer.
	 output [7:0] RXData, // data received from device
	 input [7:0] TXData // data sending (en route, clocked by sendCLK)
    );
	 
	 reg ReceiveCLK_, TX_;
	 reg [7:0] RXData_;
	 reg Receiving, Sending; // receiving data
	 reg [5:0] ReceiveCounter, SendingCounter;
	 
	 // Majority Rule counters
	 reg [2:0] Majority, MajorityCounter, MajorityCounter2;
	 reg TSet;
	 
	 initial begin
		ReceiveCLK_ = 0;
		RXData_ = 0;
		Receiving = 0;
		ReceiveCounter = 0;
		Sending = 0;
		SendingCounter = 0;
		Majority=0;
		MajorityCounter=0;
		MajorityCounter2=0;
		TSet=0;
		TX_ = 0;
	 end
	 
	 assign ReceiveCLK = ReceiveCLK_;
	 assign RXData = ~RXData_;
	 assign TX = TX_;
	 
	 // RX will clock, first clock will activate the cycle.
	 // Perform Majority rule with 5 clocks, Majority rule improves efficiency
	 always @ (posedge CLK) begin
		ReceiveCLK_ <= 0;
	 
	   if(Receiving) begin
			TSet <= 0;
			if(MajorityCounter >= 4) begin // majority rule count
				MajorityCounter <= 0;
				// Receive data! Set to true if majority ruled
				RXData_[ReceiveCounter] <= (Majority > 2);

				
				// reset receiving counter
				if(ReceiveCounter >= 7) begin
					ReceiveCounter <= 0;
					Receiving <= 0;
					ReceiveCLK_ <= 1;
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
			if(MajorityCounter >= 4) begin // use counter to offset
				MajorityCounter <= 0;
				
				ReceiveCounter <= 0;
				RXData_ <= 0;
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
		if(sendCLK && ~Sending) begin
			TX_ <= 1; // Send start bit!
			SendingCounter <= 0;
			Sending <= 1; // start sending information over
		end
		
		// Sending section; Send information over!
		if(Sending) begin
			if(MajorityCounter2 >= 4) begin // majority rule count
				MajorityCounter2 <= 0; // reset counter
				TX_ <= ~TXData[SendingCounter];

				
				// reset receiving counter if at byte size
				if(SendingCounter >= 8) begin
					SendingCounter <= 0;
					Sending <= 0;
					TX_ <= 0;
				// ELSE: increment sending counter
				end else SendingCounter <= SendingCounter + 1;
			end else begin // count the region
				MajorityCounter2 <= MajorityCounter2+1; 
			end
		end
	end
endmodule
