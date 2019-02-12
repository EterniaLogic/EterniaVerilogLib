`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Brent Clancy
// 
// Create Date:    09:05:56 01/21/2014 
// Design Name: 
// Module Name:    UART
// Project Name:   Ultrasound Range finder
// Target Devices: Spartan-3E (XC3S100E)
// Tool versions: Xilinx 14.6
// Description: This Serial converter converts UART to raw data.
//					Uart receives raw data bit-per-bit. This can be easily changed
//					to handle Shift registers. Use the DATAOUT and SEND inputs to send a
//					message. The NEGEDGE of SEND is flipped when a byte has been sent.
//					
//
// Dependencies: none
//
// Revision: 
// Revision 0.02 - changed a bit.
// Additional Comments: 
//
// 0
// START BIT (1 bit)
// DATA (8 bits)
// END BITS (2 bits)
// 0
//////////////////////////////////////////////////////////////////////////////////
module UART(
    input CLK, // clock signal, automatically determines speed based on bit-rate.
    input BW, // Block Wait (Wait until this is 0)
	 inout SEND, // USE
	 input [7:0] DATAOUT, // USE Data that is going to the device.
	 input RX, // receive from the device
    output TX, // output to the device
    output [7:0] DATAIN, // Data that is being "shoved" out of the converter
	 output RECV // has received data (acts like a clk signal)
    );

	reg setSEND; // SEND has been set.
	reg [12:0] clkDiv, clkCounter;
	reg [7:0] DATAIN_, DATAOUT_;
	reg [3:0] rxCount, txCount; // current signal count 0-7
	reg TX_D, RECV_; // TX data holder
	reg SEND_; // is it being sent?
	
	assign DATAIN = DATAIN_;
	assign TX = TX_D;
	assign RECV = RECV;
	assign SEND = SEND_;
	
	// clear out variables.
	initial begin
		clkDiv = 0;
		clkCounter = 0;
		DATAIN_ = 0;
		DATAOUT_= 0;
		rxCount = 0;
		txCount = 0;
	end

	// UART controller
	always @(posedge CLK) begin
		RECV_ = 0;
		// handle RX
		if(~BW) begin // ~Block wait?
			// take in signals one by one; once signal counter reaches 8, 
			// wait for hold
			
			if(rxCount == 0) begin
				// nothing. START BIT
			end else if(rxCount < 9) begin
				// insert value into data (LSB is first)
				DATAIN_[7-(rxCount-1)] = RX;
			end else if(rxCount < 10)begin
				// nothing. END BIT (single bit instead of two)
			end else begin
				rxCount = -1; // account for increment after
				RECV_ = 1; // single byte has been received.
			end
			
			rxCount=rxCount+1;
		end else begin
			// handle TX
			if(SEND || setSEND) begin // send bits.
				// use txCount to count the number of output sends.
				setSEND = 1;
				
				if(txCount < 1) begin
					// send start bit
					TX_D = 1;
				end else if(txCount < 9) begin
					TX_D = DATAOUT_[txCount-1];
				end else if(txCount < 11 && txCount >= 9) begin
					// send end bits
					TX_D = 1;
				end else begin // reset variables upon getting to 8.
					setSEND = 0;
					txCount = -1;
					SEND_ = 0;
					TX_D = 0; // Zero TX
				end
				
				
				
				txCount = txCount+1;
			end
		end
	end
	
	
endmodule
