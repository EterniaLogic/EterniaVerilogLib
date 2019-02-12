`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:09:09 01/30/2015 
// Design Name: 
// Module Name:    ALU 
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
module ALU(
    input [4:0] Select,
    input [BITS-1:0] A,
    input [BITS-1:0] B,
    output wire [BITS-1:0] Out,
	 output wire statV,
    output wire Cout,
	 output reg shift, // do a shift op?
	 output reg LR
    );
	 
	 parameter BITS = 32;
	 
	 reg [BITS-1:0] Cout_;
	 reg [BITS-1:0] Out_; // Out is 1 bit wider for COut
	 reg statV_;
	 
	 initial begin
		Cout_ 	= 	0;
		Out_ 		= 	0;
		statV_	=	0;
		shift=0;
		LR=0;
	 end
	 
	 assign Out = Out_;
	 assign Cout= Cout_;
	 assign statV=statV_;
	 
	 //assign Out = ? ({{Sel},{Cin}} == 0) ? A :
	 
	 always @(*) begin
		shift=0;
		case(Select)
			5'b00000: 	{{Cout_}, {Out_}} = A;			// Transfer A
			5'b00010: 	{{Cout_}, {Out_}} = A+B;		// A+B
			5'b00101: 	{{Cout_}, {Out_}} = A+~B+1;	// Subtraction
			5'b00111: 	{{Cout_}, {Out_}} = A+~B+1;	// Subtraction
			5'b01000: 	{{Cout_}, {Out_}} = A&B;		// AND
			5'b01010: 	{{Cout_}, {Out_}} = A|B;		// OR
			5'b01110: 	{{Cout_}, {Out_}} = ~A;			// NOT A
			5'b10100:	begin shift=1; LR=1; end			// Shift Left
			5'b11000:	begin shift=1; LR=0; end			// Shift Right
		endcase
		
		// Test for overflow
		//
		// A-B = negative  OR  A+B >= 65536
		// Neg-Neg = positive 
		// Neg-Pos = positive
		// Pos+Pos = negative
		// Pos+Neg = negative
		
		// Addition Cases
		if(1 <= Select <= 4'b0101) begin
			if(((A+B) > 1<<BITS) && A[BITS-1] == 0) begin // Test Pos+Neg=Neg
				// true ... positively Guilty!
				statV_ = 1;
			end else statV_ = 0;
		end else if(Select == 4'b0101 && A<B) begin
			if((A-B)>0 && A[BITS-1] == 1) begin
				// True ... Guilty!
				statV_ = 1;
			end else statV_ = 0;
		end else statV_ = 0;
	 end
endmodule
