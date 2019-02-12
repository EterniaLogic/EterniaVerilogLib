`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:53:35 04/21/2014 
// Design Name: 
// Module Name:    PhaseDetector 
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
module PhaseDetector(
    input CLK,
    input Phase1,
    input Phase2,
    output [15:0] PhaseOUT,
	 output LeftFirst, // << Is left is before right signal?
	 output SignalDetect // are the phases being detected?
    );
	 
	 // The Phase Detector takes in two signals and gets an output phase 
	 //		after Nth degree Averaging. Phase is in 2880 resolution.
	 // 		1 degree = 8, 180 degree = 1440
	 
	 // Note: this is determined for 19kHz, clock == 50 MHz
	 // 		::: Left == Phase 1
	 
	 reg SetPhase, Left, LeftO, Detect, P1, P2, PSet1, PSet2; 
	 reg [11:0] Counter, PhaseO;
	 reg [26:0] SignalCounter;
	 
	 wire P1O, P2O;
	 
	 initial begin // initialize all parameters
		SetPhase = 0;
		Left = 0;
		LeftO = 0;
		Counter = 0;
		PhaseO = 0;
		SignalCounter = 0;
		P1 = 0;
		P2 = 0;
		PSet1 = 0;
		PSet2 = 0;
	 end
	 
	 assign LeftFirst = LeftO; // set left or not?
	 assign PhaseOUT = PhaseO; // set phase on end
	 assign SignalDetect = Detect; // is signal detected?
	 
	 xor(P1O, P1, PSet1); // Synchronize toggle gate
	 xor(P2O, P2, PSet2); // Synchronize toggle gate
	 
	 always @(posedge Phase1) begin
		P1 = ~P1; // toggle P1O on xor
	 end
	 
	 always @(posedge Phase2) begin
		P2 = ~P2; // toggle P2O on xor
	 end
	 
	 always @(posedge CLK) begin
		// detect if low signal
		if(Phase1 | Phase2) begin // either signal is detected
			SignalCounter <= 0;
			Detect <= 1;
		end else begin
			if(SignalCounter > 100_000_000) begin // wait for 2 seconds
				Detect <= 0; // signal is disrupted
			end else begin
				SignalCounter <= SignalCounter+1; // increment if no signal
			end
		end
	  end
	  
	  // Detect the phase (Synchronize)
	  always @ (negedge CLK) begin
		if(SetPhase) begin
			// A phase has been detected. Test for end-phase.
			if(Left) begin // Left phase, detect for right on
				if(P2O) begin // right phase detect
					PSet2 <= ~PSet2; // untoggle P2O
					PhaseO <= Counter;
					LeftO <= 1; // is left
					SetPhase <= 0;
				end
			end else begin // Right phase, detect for left on.
				if(P1O) begin
					PSet1 <= ~PSet1; // Untoggle P1O
					PhaseO <= Counter;
					LeftO <= 0; // not left!
					SetPhase <= 0;
				end
			end
			Counter <= Counter+1;
		end else begin // A start phase has not yet been detected.
			if(P1O) begin // left is first
				PSet1 <= ~PSet1;
				Left <= 1;
				SetPhase <= 1;
			end else if(P2O) begin // Right first
				PSet2 <= ~PSet2;
				Left <= 0;
				SetPhase <= 1;
			end else begin // no phase detected!
				
				Counter <= 0; // keep counter set to reset
			end
		end
	 end
endmodule
