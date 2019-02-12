`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Brent Clancy
// 
// Create Date:    19:02:55 02/27/2014 
// Design Name: 
// Module Name:    DebugCommander 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: Takes in a specific command. Performs an action based on this command.
//		Specific commands:
//			help - lists available commands
//			vars - lists available variables
//			commands - lists possible commands that run specific algorithms
//			set var to [0000, 0/1, FFFF] based on bit number
//			get var
//
//		Modifications to the Debug Commander are "application specific". However, there are
//			some standard commands, such as "help", "vars" and "commands".
//
//		// [[Uses 8*64 bits of data]] + specific variables
//
// Dependencies: RS-232 receiver
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module DebugCommander(
	 input MainCLK,
	 input RX, // RX pin (Receive from device)
    output TX, // TX pin (Send to device)
	 input [7:0] IN1,
	 input [7:0] IN2,
	 input [7:0] IN3,
	 input [7:0] IN4,
	 input IN5,
	 input IN6,
	 input IN7,
	 input IN8,
	 output [7:0] OUT1,
	 output [7:0] OUT2,
	 output [7:0] OUT3,
	 output [7:0] OUT4,
	 output OUT5,
	 output OUT6,
	 output OUT7,
	 output OUT8,
	 output GDB1,
	 output GDB2,
	 output GDB3,
	 output GDB4,
	 output GDB5,
	 output GDB6
    );
	 
	 parameter LF = 10; // 0x0A
	 parameter CR = 13; // 0x0D
	 parameter BaudRate = 115200;
	 parameter helpDoc = "Commands: \n";
	 
	 wire RS232CLK, RS232CLK5;
	 
	 integer i; // 64-bit long incrementer
	 reg [5:0] cinc; // statement incrementer (used in string statements to split it)
	 reg [(8*10)-1:0] charList; // list of characters to save, 64 array
	 
	 reg [7:0] sWinc; // send char incrementer for 256-character strings
	 reg [5:0] sendCounter; // wait 8 ticks
	 
	 reg [10*7:0] command; // set command to be used upon (enter)
	 reg [10*7:0] arguments [5:0]; // 3-dim string literal array ((8*10)x6)
	 
	 reg [7:0] watchVar;
	 
	 
	 reg send;
	 reg [(7*256)-1:0] sendData; // data to be sent
	 reg [5:0] sendA, sendB; // accumulator
	 reg [7:0] sendByte;
	 
	 wire RECV, TX_1;
	 reg TX_, SEND, setWatch;
	 wire [7:0] RXData;
	 reg [7:0] TXData, TXData_;
	 
	 reg [23:0] RLoc; // Signal locations
	 reg [15:0] RSel; // signal select
	 reg [7:0] C1,C2,C3,C4;
	 reg C5,C6,C7,C8;
	 reg [7:0] ClkDiv5,ClkDiv6,ClkDiv7,ClkDiv8, PWMRate5,PWMRate6,PWMRate7,PWMRate8;
	 
	 reg GDB1_,GDB2_,GDB3_,GDB4_,GDB5_,GDB6_,GDBCLK_;
	 
	 assign TX = TX_;
	 
	 initial begin
		/*lastChar = 0;
		cinc = 0;
		incrementer = 0; 
		command = 0;
		send = 0;
		sendA = 0;
		sendB = 0;
		sendByte = 0;
		sendData = 0;
		
		C1=0;C2=0;C3=0;C4=0;C5=0;C6=0;C7=0;C8=0;
		ClkDiv5=0;ClkDiv6=0;ClkDiv7=0;ClkDiv8=0;
		PWMRate5=0;PWMRate6=0;PWMRate7=0;PWMRate8=0; */
		
		i = 0;
		repeat(64) begin // clear out the list.
			charList[i] = 0;
			i=i+1;
		end
		
		i = 0;
		repeat(8) begin
			RLoc[3*i +:3] = i;
			i=i+1;
		end
		
		i = 0;
		repeat(8) begin
			RSel[2*i +:2] = 2'b11;
			i=i+1;
		end
		GDB1_ = 0;GDB2_ = 0;GDB3_ = 0;GDB4_ = 0;GDB5_ = 0;GDB6_ = 0;
	 end
	 
	 //assign GDB5 = RS232CLK;
	 
	 
	 // occur only on a cycle (bad, slow logic!)
	 always @(negedge RECV) begin
			GDB1_ <= 0;
			//GDB2_ <= 0;
			// Take in a character
			// These characters are converted into a n-length character string that is
			//		read as strings Only if a LF CR (Line Feed, Carriage Return) is sent.
			// Pressing "Enter" on a terminal will send LF CR. (This presents a newline)
			send <= 0;
			
			cinc <= 0; // reset argument counter
			case(RXData)
				CR: begin // newline executed.
						// determine what command has been executed.
						case(arguments[0])
							"help": begin 
									send <= 1;
									sendData <= helpDoc;
								end
							"set": begin // set [var] ["", "clk", "pwm"]
									if(assertVar(arguments[1], 0)) begin
										case(arguments[2]) 
											"to": begin // direct assign variable
													// variable asserted
													if(assertVar(arguments[3], 1)) begin  // not an output variable
														
													end else begin // set value
														
													end
												end
											"pwm": begin // set duty cycle
													
												end
											"clk": begin // set clock speed
													
												end
										endcase
									end else begin // wrong variable name
										send <= 1;
										sendData <= errorDoc;
									end
									
								end
							"get": begin // return variable
									if(assertVar(arguments[1], 1)) begin // input variable
										send <= 1;
										case(arguments[1][2]) // IN#
											1: sendData <= IN1;
											2: sendData <= IN2;
											3: sendData <= IN3;
											4: sendData <= IN4;
											5: sendData <= IN5;
											6: sendData <= IN6;
											7: sendData <= IN7;
											8: sendData <= IN8;
											default: send <= 0; // do not send
										endcase
									end else if(assertVar(arguments[1], 0)) begin // output variable
										send <= 1;
										case(arguments[1][3]) // IN#
											1: sendData <= C1;
											2: sendData <= C2;
											3: sendData <= C3;
											4: sendData <= C4;
											5: sendData <= C5;
											6: sendData <= C6;
											7: sendData <= C7;
											8: sendData <= C8;
											default: send <= 0; // do not send
										endcase
									end else begin // wrong variable name
										send <= 1;
										sendData <= errorDoc;
									end
								end
							"watch": begin
								if(assertVar(arguments[1], 1)) begin
									setWatch <= 1; // watch loop
									watchVar <= arguments[1];
								end
							"forward": begin
									
								end
							"left": begin
									
								end
							"right": begin
									
								end
							"backward": begin
									
								end
							end
						endcase
					end
				LF: ; // do nothing here.
					
					// splits arguments
				" ": begin // flush and reset charlist
						send <= 1;
						sendData <= charList;
						arguments[cinc] <= charList;
						charList <= 0;
						cinc <= cinc+1;
					end
			endcase
			
			GDB2_<=1;
			TXData_ <= RXData;
	 end
	 
	 // passive speed writer, writes a string if required
	 always @(posedge RS232CLK) begin
		SEND <= 0;
		GDB3_ <= 0;
		GDB4_ <= 0;
		if(send && sendCounter == 0) begin
			// place a new TXData character
			// prevent sending all zeros (null)
			SEND <= 0;
			// Vector bit-select with variable fixed-width
			if(sendData[sendCounter*8 +:8] > 0) begin
				TXData <= sendByte;
				SEND <= 1;
				GDB3_ <= 1;
			end //else send <= 0;
		end else begin // force "Echo"
			TX_ <= (RX) ? RX : TX_;
			if(TXData_) begin
				TXData <= TXData_;
				SEND <= 1;
				GDB4_ <= 1;
			end
		end
		sendCounter <= sendCounter+1; // count up to 64
	 end
	 
	 
	 // Asserts a variable based on input.
	 function assertVar;
		input [(3*8)-1:0] variable; // 4-byte variable
		input inVar;
		begin
			assertVar = (variable[1:0] == "IN" && inVar) | (variable[2:0] == "OUT" && ~inVar);
		end
	 endfunction
	 
	 
	 SubClockDyn clk1 (MainCLK, BaudRate*5, RS232CLK5);
	 SubClockDyn clk2 (MainCLK, BaudRate, RS232CLK);
	 
	 
	 
	 RS232 SerialReceiver(.CLK(RS232CLK5),
    .RX(RX),
    .TX(TX_1),
    .ReceiveCLK(RECV),
	 .sendCLK(SEND),
	 .RXData(RXData),
	 .TXData(TXData));
	 
	 
	 SignalRouter8_1 SR1 (
    .CLK(MainCLK), 
    .IN1(IN1), 
    .IN2(IN2), 
    .IN3(IN3), 
    .IN4(IN4), 
    .IN5(IN5), 
    .IN6(IN6), 
    .IN7(IN7), 
    .IN8(IN8), 
    .C1(C1), 
    .C2(C2), 
    .C3(C3), 
    .C4(C4), 
    .C5(C5), 
    .C6(C6), 
    .C7(C7), 
    .C8(C8), 
    .ClkDiv5(ClkDiv5), 
    .ClkDiv6(ClkDiv6), 
    .ClkDiv7(ClkDiv7), 
    .ClkDiv8(ClkDiv8), 
    .PWMRate5(PWMRate5), 
    .PWMRate6(PWMRate6), 
    .PWMRate7(PWMRate7), 
    .PWMRate8(PWMRate8), 
    .OUT1(OUT1), 
    .OUT2(OUT2), 
    .OUT3(OUT3), 
    .OUT4(OUT4), 
    .OUT5(OUT5), 
    .OUT6(OUT6), 
    .OUT7(OUT7), 
    .OUT8(OUT8), 
    .RLoc(RLoc), 
    .RSel(RSel)
    );
	 


endmodule
