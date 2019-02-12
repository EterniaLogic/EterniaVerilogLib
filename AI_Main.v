`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 	Brent Clancy
// 
// Create Date:    02:28:52 02/05/2014 
// Design Name: 
// Module Name:    AI_Main 
// Project Name: 	 Project Lab 1 - Washer Retriever
// Target Devices: Xilinx 
// Tool versions: 
// Description: All high-level AI state-machine logic is performed here.
//				Subsequent operations are handled in sub-files with AI_ as the 
//				prefix.
//
// Dependencies: 
//
// Revision: 0.02
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module AI(
	 input CLK,
    input MagnetSensorIN,
	 input IRLeftIN, // Infared sensors
	 input IRRightIN,
	 input [7:0] RX_Data,
	 input RX_Tick,
	 input PrinterDNE,
	 
    output reg ElectroMagnetCTL,
	 output reg [7:0] MotorLeftDuty, // duty cycle controller
    output reg [1:0] MotorLeftCTL,
    output reg [7:0] MotorRightDuty,
    output reg [1:0] MotorRightCTL,
    output reg [7:0] TiltServo,
	 output reg [7:0] LArmDuty,
	 output reg [7:0] RArmDuty,
	 output [4:0] StateTest, // test bits for state, use with 7-seg
	 output reg [7:0] TX, // Data to write to transmitter
	 output reg TX_Signal, // turn on to "send", off to reset
	 output reg [7:0] PrinterMode
    );
	 // Brian changed motor speed to 10 at 7:26 pm.
	 //parameter LINECOUNT = 1660; // estimated lines (0x06b3)
	 //parameter LINECOUNT = 1900;
	 parameter SECONDCNT = 5120; // time for 1 second
	 parameter MOTOR_SPEED = 60; // 256-50 = 196 inverted speed
	 parameter ARM_SLEEP = (SECONDCNT*6)/4; // back / forward servo timing
	 parameter TURN_SPEED = 255; // speed used for turning
	 
	 reg [7:0] MotorLeftDuty_; // duty cycle controller
    reg [1:0] MotorLeftCTL_;
    reg [7:0] MotorRightDuty_;
    reg [1:0] MotorRightCTL_;
	 reg ElectromagnetCTL_;
	 //wire IRLeftIN_N, IRRightIN_N;
	 
	 // Assume that enum counts from 0 -> N
	 parameter S_INITIAL = 0;
	 parameter S_METALDETECT = 1;
	 parameter S_ULTRASOUND = 2;
	 parameter S_EDGELEFT = 3;
	 parameter S_EDGECENTER = 4;
	 parameter S_EDGERIGHT = 5;
	 parameter S_TURNLEFT = 6;
	 parameter S_TURNRIGHT = 7;
	 parameter S_MOVEFWD = 8;
	 parameter S_MOVEBACK = 9;
	 parameter S_STOP = 10;		// 	A
	 parameter S_IR = 11;		// 	B
	 parameter S_WAIT = 12;		// 	C
	 parameter S_METAL_FOUND = 13;//	D 	
	 parameter S_RETURN_HEAD = 14;// E	
	 parameter S_SERVOBACK = 15;// 	F
	 parameter S_MOVE_ARMS_BACK = 16;// 	
	 parameter S_DROP = 17;		// 	
	 parameter S_MOVE_ARMS_FORWARD = 18;
	 parameter S_MANAGE_PRINTERHEAD = 19;
	 parameter S_SOUNDSENSE = 20; // move the robot to a specific sound (2-signal phase change)
	 parameter S_ENABLE_MAGNET = 21;
	 parameter S_MOVE_COLLECT = 22;
	 parameter S_TILT_SERVO_BACK = 23;
	 parameter S_STOP_ARMS = 24;
	 parameter S_AUDIO_FILTER_FOLLOW = 25;
	 parameter S_WAIT2 = 26;		// 	C
	 parameter S_MOVE_WAIT = 27;
	 
	 parameter S_PRINTER_STOP = 0;
	 parameter S_PRINTER_CONTROL = 1;
	 parameter S_PRINTER_CENTER = 2;
	 parameter S_PRINTER_COLLECT = 3;
	 parameter S_PRINTER_SLEEP = 4;
	
	 reg [7:0] state;
	 reg enableStateChange;
	 reg RX_X, RX_Y;
	 wire RX_Z;
	
	 // State machine
	 integer meta, meta2; 
				// inter-state data, usually assigned if an action occurs that
				// has a parameter.
	 reg [15:0] Counter; // used for waiting and counting on metal detect
	 
	 
//	 assign StateTest = state; // sets state output
	 
	 initial begin
		state = 0;
		meta = 0;
		meta2 = 0;
		MotorLeftDuty = 0;
		MotorLeftCTL = 0;
		MotorRightDuty = 0;
		MotorRightCTL = 0;
		ElectroMagnetCTL = 0;
		Counter = 0;
		LArmDuty = 0;
		RArmDuty = 0;
		enableStateChange = 1;
		RX_X = 0;
		RX_Y = 0;
		PrinterMode = 0;
	 end
	 
	 xor(RX_Z, RX_X, RX_Y);
	 //assign IRLeftIN_N = IRLeftIN;
	 //assign IRRightIN_N = IRRightIN;
	 //assign IRLeftIN_N = ~IRLeftIN;
	 //assign IRRightIN_N = ~IRRightIN;
	 assign StateTest = state;
	 
	 always @ (posedge RX_Tick) begin
		RX_X <= ~RX_X;
	 end
	 
	 always @ (posedge CLK) begin
		case(state)
				// initial state caller
			S_INITIAL: begin
							//PrinterCTL <= 1;
							PrinterMode <= 0;
							TiltServo <= 8;
							//LArmDuty <= 51; // approx 80% Duty (Clockwise)
							//RArmDuty <= 205; // approx 20% Duty (Counter Clockwise)
							
							LArmDuty <= 127; // approx 50% Duty
							RArmDuty <= 127; // approx 50% Duty
							
							meta <= SECONDCNT;  // ticks to wait
							meta2 <= S_METALDETECT; // Return state
							state = enableStateChange ? S_WAIT : state;
						end
						
			S_METALDETECT: begin // drive printer head
						// stop vex motor
						LArmDuty <= 127; // approx 50% Duty (Neutral)
						RArmDuty <= 127; // approx 50% Duty (Neutral)
						PrinterMode <= S_PRINTER_CONTROL;
						
						
						ElectroMagnetCTL <= 0; // make sure electromagnet is off
						TiltServo <= 8; // make sure servo is down
						
						state = enableStateChange ? S_IR : state; // this state is overridden
						if(MagnetSensorIN) begin // detected!
							ElectroMagnetCTL <= 1;
							state = enableStateChange ? S_METAL_FOUND : state;
						end
					end
			
			S_IR:	begin // IR will work on any surface if a good sensor type is used
						state = enableStateChange ? S_MOVEFWD : state; // else the tank will continue to move forward.
						
						// test if Both are on
						if(IRLeftIN) begin
							if(IRRightIN) begin // both are triggered, turn right
								// turn the bot right
								MotorLeftCTL <= 2'b01; // H-bridge value
								MotorLeftDuty <= TURN_SPEED-40; // PWM (tankmotor) value
								MotorRightCTL <= 2'b10;
								MotorRightDuty <= TURN_SPEED; // half speed
							
								// set wait
								meta <= 2*SECONDCNT;  // ticks to wait for turn
								meta2 <= S_METALDETECT; // Return state
								state = enableStateChange ? S_WAIT : state;
								//PrinterMode <=  S_PRINTER_STOP;
								// test left side
							end else begin
								state = enableStateChange ? S_TURNRIGHT : state;	// turn right until course is corrected.
								//PrinterDuty <= 0;
								//PrinterMode <= S_PRINTER_STOP;
								// test right side
							end
						end else if(IRRightIN) begin
							state = enableStateChange ? S_TURNLEFT : state;	// turn left until course is corrected.
							//PrinterMode <= S_PRINTER_STOP;
						end
					end
					
					//Filter_Left, // Is the filter detecting the left side phase?
					//Filter_Detect, // is a signal being detected?
					//[15:0] Filter_Phase, // Phase between microphones
			/*S_AUDIO_FILTER_FOLLOW: begin
						state = enableStateChange ? S_MOVEFWD : state; // else the tank will continue to move forward.
						if(Filter_Detect) begin
							// go a direction based on PhaseDetector
							// do not use timed system; This will allow
							//	for the printer head to be functional at the same time.
							
							// this only occurs when the robot is > 5 degrees off.
							if(Filter_Phase > (5 )*8) begin
								if(Filter_Left) begin // go left?
										state = enableStateChange ? S_TURNLEFT : state; // else the tank will continue to move forward.
								end else begin // go right?
										state = enableStateChange ? S_TURNRIGHT : state; // else the tank will continue to move forward.
								end
							end else begin
								state = enableStateChange ? S_MOVEFWD : state; // else the tank will continue to move forward.
							end
						end
					end*/
			
			S_MOVEFWD: begin
							// go forward!
							MotorLeftCTL <= 2'b01; // H-bridge value
							MotorLeftDuty <= MOTOR_SPEED; // PWM (tankmotor) value
							MotorRightCTL <= 2'b01;
							MotorRightDuty <= MOTOR_SPEED; // half speed
							
							// reset to state 0
							state = enableStateChange ? S_METALDETECT : state;
						end
						
			S_MOVEBACK: begin
							// go forward!
							MotorLeftCTL <= 2'b10; // H-bridge value
							MotorLeftDuty <= MOTOR_SPEED; // PWM (tankmotor) value
							MotorRightCTL <= 2'b10;
							MotorRightDuty <= MOTOR_SPEED; // half speed
							
							// reset to state 0
							state = enableStateChange ? S_METALDETECT : state;
						end
							
			S_TURNLEFT: begin
							// turn the bot left
							MotorLeftCTL <= 2'b10; // H-bridge value
							MotorLeftDuty <= TURN_SPEED; // PWM (tankmotor) value
							MotorRightCTL <= 2'b01;
							MotorRightDuty <= TURN_SPEED-20; // half speed
							
							//state = enableStateChange ? S_METALDETECT : state;
							
							meta <= 600;  // ticks to wait for turn
							meta2 <= S_METALDETECT; // Return state
							state = enableStateChange ? S_WAIT: state;
						end
			
			S_TURNRIGHT: begin
							// turn the bot right
							MotorLeftCTL <= 2'b01; // H-bridge value
							MotorLeftDuty <= TURN_SPEED-20; // PWM (tankmotor) value
							MotorRightCTL <= 2'b10;
							MotorRightDuty <= TURN_SPEED; // half speed
							
							//state = enableStateChange ? S_METALDETECT : state;
							
							meta <= 600;  // ticks to wait for turn
							meta2 <= S_METALDETECT; // Return state
							state = enableStateChange ? S_WAIT: state;
						end
						
			S_METAL_FOUND: begin // move printerhead to left to collect
						// prepare for collection
						MotorLeftCTL <= 0;
						MotorRightCTL <= 0;
						TiltServo <= 8;
						PrinterMode <= S_PRINTER_STOP;
						
						state = enableStateChange ? S_ENABLE_MAGNET : state; // goto wait.
					end
					
			S_ENABLE_MAGNET: begin // turn the magnet on!
						ElectroMagnetCTL <= 1;
						
						state = enableStateChange ? S_MOVE_COLLECT : state; // goto wait.
					end
					
			S_MOVE_COLLECT: begin
						PrinterMode <= S_PRINTER_COLLECT;
						if(PrinterDNE) begin
								meta <= SECONDCNT;  // ticks to wait for turn
								meta2 <= S_MOVE_WAIT; // Return state
								state =  enableStateChange ? S_WAIT : state;
						end
					end
			
			S_MOVE_WAIT: begin
						PrinterMode <= S_PRINTER_STOP;
						meta <= SECONDCNT/5;  // ticks to wait for turn
						meta2 <= S_RETURN_HEAD; // Return state
						state =  enableStateChange ? S_WAIT : state;
					end
					
			S_RETURN_HEAD: begin // return printer head back to exact middle
							PrinterMode <= S_PRINTER_CENTER;
							if(PrinterDNE) begin
								PrinterMode <= S_PRINTER_STOP; // wait for printer head
								state =  enableStateChange ? S_SERVOBACK : state;
							end
						end
					
			S_SERVOBACK: begin
						TiltServo <= 18; // tilt servo back
						
						meta <= SECONDCNT/2;  // ticks to wait
						meta2 <= S_MOVE_ARMS_BACK; // Return state
						state = enableStateChange ? S_WAIT : state;
					end
					
			S_MOVE_ARMS_BACK: begin // move arms back for deposit
						//LArmDuty <= 51; // approx 20% Duty (Counter clockwise)
						//RArmDuty <= 205; // approx 80% Duty (Clockwise)
						LArmDuty <= 205; // approx 20% Duty (Counter clockwise)
						RArmDuty <= 51; // approx 80% Duty (Clockwise)
						
						meta <= ARM_SLEEP;  // ticks to wait
						meta2 <= S_DROP; // Return state
						state = enableStateChange ? S_WAIT : state;
					end
					
			S_DROP: begin // drop washer
						LArmDuty <= 129; // neutral (50% VEX)
						RArmDuty <= 129; // neutral
						ElectroMagnetCTL <= 0; // electromagnet off.
						
						meta <= SECONDCNT/10;  // ticks to wait
						meta2 <= S_MOVE_ARMS_FORWARD; // Return state
						state = enableStateChange ? S_WAIT : state;
					end
			
			S_MOVE_ARMS_FORWARD: begin // reset arms back to position
						//LArmDuty <= 205; // approx 80% Duty (Clockwise)
						//RArmDuty <= 51; // approx 20% Duty (Counter Clockwise)
						LArmDuty <= 51; // approx 80% Duty (Clockwise)
						RArmDuty <= 205; // approx 20% Duty (Counter Clockwise)
						
						meta <= ARM_SLEEP;  // ticks to wait
						meta2 <= S_STOP_ARMS; // Return state
						state = enableStateChange ? S_WAIT : state;
					end
					
			S_STOP_ARMS: begin
						LArmDuty <= 127; // approx 50% Duty (Off)
						RArmDuty <= 127; // approx 20% Duty (Off)
						state = enableStateChange ? S_TILT_SERVO_BACK : state;
					end
					
			S_TILT_SERVO_BACK: begin
						TiltServo <= 8;
						
						meta <= SECONDCNT/4;  // ticks to wait
						meta2 <= S_METALDETECT; // Return state
						state = enableStateChange ? S_WAIT : state;
					end
			
			S_STOP: begin
							// do not use this state.
							MotorLeftCTL <= 0; 
							MotorLeftDuty <= 0;
							MotorRightCTL <= 0;
							MotorRightDuty <= 0;
							LArmDuty <= 127; // approx 50% Duty (Off)
							RArmDuty <= 127; // approx 20% Duty (Off)
							ElectroMagnetCTL <= 0; // electromagnet off.
							//LineCounterReset <= 0;
							TiltServo <= 8; // 
							
							//PrinterCTL <= 1; // reset ctl
							//PrinterDuty <= 0; // stop printer head!
							PrinterMode <= 0;
						end
						
			// Wait for a given time in meta2, meta determines state
						// meta == 1: "Wait" meta == 2: "done"
			S_WAIT: begin
							Counter <= 0; // reset counter
							state = enableStateChange ? S_WAIT2 : state;
						end
			S_WAIT2: begin
							if(Counter > meta) begin // end wait
								state = enableStateChange ? meta2 : state;
								Counter <= 0;
							end else // do wait
								Counter <= Counter + 1;
						end
		endcase
		
		if(RX_Z) begin
			RX_Y <= ~RX_Y;
			
			
			case (RX_Data) // select the state that is wanted
				"a": state = S_TURNLEFT;
				"d": state = S_TURNRIGHT;
				"w": state = S_MOVEFWD;
				"s": state = S_MOVEBACK;
				"q": state = S_STOP;
				"c": enableStateChange <= ~enableStateChange; // prevents robot from auto state
				"i": state = S_IR; // goto Infrared detector state
				"p": state = S_MANAGE_PRINTERHEAD; // goto manage printerhead state
				"e": state = S_ENABLE_MAGNET;
				"r": state = S_DROP;
				"z": state = S_MOVE_ARMS_FORWARD;
				"x": state = S_MOVE_ARMS_BACK;
				"v": state = S_SERVOBACK; // tilt servo
				"m": state = S_METAL_FOUND; // found metal!
			endcase
		end
	 end
endmodule
