`timescale 1ns / 1ps
module PacketScheduler(
    input clk, // 200MHz
	 input [23:0] DCDC_VSense1,
    input [23:0] DCDC_CSense1,
    input [23:0] DCDC_VSense2,
    input [23:0] DCDC_CSense2,
    input [23:0] SMPS_50V_VSense,
    input [23:0] SMPS_50V_CSense,
	 input [23:0] PFC_In_VSense,
    input [23:0] PFC_Out_VSense,
	 output voltageSet1,
	 output currentSet1,
	 output voltageSet2,
	 output currentSet2,
	 output smpsRelay // relay to allow 120VAC to the SMPS
    );
	 
	 // The Packet Scheduler has a buffer, which allows for packets to be sent at specific intervals, which allow the software to cope.
	 // The expected UART Speed is 1-3MHz, so all respective orders are given with higher priority.
	 reg [14:0] memIndex,endmemIndex; // index used to determine the current length in a circular buffer
	 wire RS232CLK,SENDINGCLK;
	 wire [8:0] RX;
	 reg [8:0] TX; // sendX
	 wire ReceiveCLK;
	 reg sendCLK;
	 wire [7:0] RXData;
	 reg [7:0] TXData;
	 wire sendDoneCLK;
	 reg [5:0] parity_DCDCV1;
	 reg [5:0] parity_DCDCV2;
	 reg [5:0] parity_DCDCC1;
	 reg [5:0] parity_DCDCC2;
	 reg [5:0] parity_SMPSV;
	 reg [5:0] parity_SMPSC;
	 reg [5:0] parity_PFC_INV;
	 reg [5:0] parity_PFC_OUTV;
	 
	 //always parity_DCDCV1=parity(DCDC_VSense1) = 0;

	 kBMemory30kB mem(.clka(clka), // input clka
		  .rsta(rsta), // input rsta
		  .wea(wea), // input [0 : 0] wea
		  .addra(addra), // input [14 : 0] addra
		  .dina(dina), // input [15 : 0] dina
		  .douta(douta) // output [15 : 0] douta
	 );
	 
	 defparam sclk1.Divider=14;//Approx 5*(2.86 MHz)
	 SubClock sclk1(clk,RS232CLK);
	 
	 RS232 serial(RS232CLK,RX,TX,ReceiveCLK,sendCLK,RXData,TXData,sendDoneCLK);
	 
	 defparam sclk2.Divider=667;//Approx 299850 Hz
	 SubClock sclk2(clk,SENDINGCLK);
	 
	 
	 initial begin
		 memIndex=0;
		 endmemIndex = 0;
		 TX = 0;
		 sendCLK = 0;
		 TXData = 0;
		 parity_DCDCV1 = 0;
		 parity_DCDCV2 = 0;
		 parity_DCDCC1 = 0;
		 parity_DCDCC2 = 0;
		 parity_SMPSV = 0;
		 parity_SMPSC = 0;
		 parity_PFC_INV = 0;
		 parity_PFC_OUTV = 0;
	 end
	 
	 always @(posedge SENDINGCLK) begin
		// loop through buffer 300kHz
		if(memIndex!=endMemIndex) begin
			addra = memIndex;
			// figure out the location for the data
			memIndex = memIndex+1;
		end
	 end
	 
	 always @(*) begin // detect change in memory
		if(parity_DCDCV1 != ^DCDC_VSense1) begin
			// change detected
			parity_DCDCV1 = ^DCDC_VSense1;
			// figure out the slot in the memory
			// if the 8 divider is lower than value, do next 8 divider
			// |  -     | 3/8 20021 -> index 2502
		end
	 end
endmodule
