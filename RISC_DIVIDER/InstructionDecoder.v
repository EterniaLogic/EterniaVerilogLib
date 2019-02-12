`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    22:24:50 03/26/2015 
// Design Name: 
// Module Name:    InstructionDecoder 
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
module InstructionDecoder(
    input [31:0] InputIR,
    output reg RW,	// Register Memory Read/Write
    output reg [1:0] MD, // Mux D Select
    output reg [1:0] BS, // Mux C Branch Select?
    output reg PS, // 
    output reg MW, // Data Memory Write
    output reg [5:0] FS, // Function Select
    output reg MA, // Mux A Select
    output reg MB, // Mux B Select
    output reg CS);// Constant Select
	 
	 initial begin
		RW=0;
		MD=0;
		BS=0;
		PS=0;
		MW=0;
		FS=0;
		MA=0;
		MB=0;
		CS=0;
	 end
	 
	 wire [6:0] Select;
	 assign Select = InputIR[31:25];
	 
	 
	 always @(InputIR) begin
		RW=0;
		MD=0;
		BS=0;
		PS=0;
		MW=0;
		FS=0;
		MA=0;
		MB=0;
		CS=0;
		case(InputIR[31:25])
			7'b0000000: begin		// NOP 
							RW=0;
							BS=0;
							MW=0;
						end
			7'b0000010: begin		// ADD
							RW=1;
							MD=0;
							BS=0;
							MW=0;
							FS=2;
							MB=0;
							MA=0;
						end
			7'b0000101: begin		// SUB
							RW=1;
							MD=0;
							BS=0;
							MW=0;
							FS=5;
							MB=0;
							MA=0;
						end
			7'b1100101: begin		// SLT
							RW=1;
							MD=2;
							BS=0;
							MW=0;
							FS=5;
							MB=0;
							MA=0;
						end
			7'b0010000: begin		// AND
							RW=1;
							MD=0;
							BS=0;
							MW=0;
							FS=8;
							MB=0;
							MA=0;
						end
			7'b0001010: begin		// OR
							RW=1;
							MD=0;
							BS=0;
							MW=0;
							FS=10;
							MB=0;
							MA=0;
						end
			7'b0001100: begin		// XOR
							RW=1;
							MD=0;
							BS=0;
							MW=0;
							FS=12;
							MB=0;
							MA=0;
						end
			7'b0000001: begin		// ST
							RW=0;
							MD=0;
							BS=0;
							MW=1;
							MB=0;
							MA=0;
						end
			7'b0100001: begin		// LD
							RW=1;
							MD=1;
							BS=0;
							MW=0;
							MA=0;
						end
			7'b0100010: begin		// ADI
							RW=1;
							MD=0;
							BS=0;
							MW=0;
							FS=2;
							MB=1;
							MA=0;
							CS=1;
						end
			7'b0100101: begin		// SBI
							RW=1;
							MD=0;
							BS=0;
							MW=0;
							FS=3;
							MB=1;
							MA=0;
							CS=1;
						end
			7'b0101110: begin		// NOT
							RW=1;
							MD=0;
							BS=0;
							MW=0;
							FS=3;
							MB=13;
							MA=0;
						end
			7'b0101000: begin		// ANI
							RW=1;
							MD=0;
							BS=0;
							MW=0;
							FS=8;
							MB=1;
							MA=0;
							CS=0;
						end
			7'b0101010: begin		// ORI
							RW=1;
							MD=0;
							BS=0;
							MW=0;
							FS=10;
							MB=1;
							MA=0;
							CS=0;
						end
			7'b0101100: begin		// XRI
							RW=1;
							MD=0;
							BS=0;
							MW=0;
							FS=12;
							MB=1;
							MA=0;
							CS=0;
						end
			7'b1100010: begin		// AIU
							RW=1;
							MD=0;
							BS=0;
							MW=0;
							FS=2;
							MB=1;
							MA=0;
							CS=0;
						end
			7'b1000101: begin		// SIU
							RW=1;
							MD=0;
							BS=0;
							MW=0;
							FS=15;
							MB=1;
							MA=0;
							CS=0;
						end
			7'b1000000: begin		// MOV
							RW=1;
							MD=0;
							BS=0;
							MW=0;
							FS=0;
							MA=0;
						end
			7'b0110000: begin		// LSL
							RW=1;
							MD=0;
							BS=0;
							MW=0;
							FS=20;
							MA=0;
						end
			7'b0110001: begin		// LSR
							RW=1;
							MD=0;
							BS=0;
							MW=0;
							FS=24;
							MA=0;
						end
			7'b1100001: begin		// JMR
							RW=0;
							BS=2;
							MW=0;
							FS=0;
						end
			7'b0100000: begin		// BZ
							RW=0;
							BS=1;
							PS=0;
							MW=0;
							FS=0;
							MB=1;
							MA=0;
							CS=1;
						end
			7'b1100000: begin		// BNZ
							RW=0;
							BS=1;
							PS=1;
							MW=0;
							FS=0;
							MB=1;
							MA=0;
							CS=1;
						end
			7'b0000111: begin		// JMP
							RW=0;
							BS=3;
							MW=0;
							MB=1;
							CS=1;
						end
			7'b1100000: begin		// JML
							RW=1;
							MD=0;
							BS=3;
							MW=0;
							FS=7;
							MB=1;
							MA=1;
							CS=1;
						end
		endcase
	 end
endmodule
