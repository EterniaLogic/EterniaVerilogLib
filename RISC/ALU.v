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
    input Cin,
    input [2:0] Sel,
    input [BITS-1:0] A,
    input [BITS-1:0] B,
    output [BITS-1:0] Out,
	 output statV,
    output Cout
    );
	 
	 parameter BITS = 16;
	 
	 reg [BITS-1:0] Cout_;
	 reg [BITS-1:0] Out_; // Out is 1 bit wider for COut
	 reg statV_;
	 
	 initial begin
		Cout_ 	= 	0;
		Out_ 		= 	0;
		statV_	=	0;
	 end
	 
	 assign Out = Out_;
	 assign Cout= Cout_;
	 assign statV=statV_;
	 
	 //assign Out = ? ({{Sel},{Cin}} == 0) ? A :
	 
	 always @(*) begin
		case({{Sel}, {Cin}})
			4'b0000: {{Cout_}, {Out_}} = A;		// Transfer A
			4'b0001: {{Cout_}, {Out_}} = A+1;		// A+ Carry In
			4'b0010: {{Cout_}, {Out_}} = A+B;		// A+B
			4'b0011: {{Cout_}, {Out_}} = A+B+1;	// A+B+ Carry In
			4'b0100: {{Cout_}, {Out_}} = A+~B;	// A+ 1's Complement B
			4'b0101: {{Cout_}, {Out_}} = A+~B+1;	// Subtraction
			4'b0110: {{Cout_}, {Out_}} = A-1;		// Decrement
			4'b0111: {{Cout_}, {Out_}} = A;		// Transfer A
			4'b100x: {{Cout_}, {Out_}} = A&B;		// AND
			4'b101x: {{Cout_}, {Out_}} = A|B;		// OR
			4'b110x: {{Cout_}, {Out_}} = A^B;		// XOR
			4'b111x: {{Cout_}, {Out_}} = ~A;		// NOT
		endcase
		
		// Test for overflow
		//
		// A-B = negative  OR  A+B >= 65536
		// Neg-Neg = positive 
		// Neg-Pos = positive
		// Pos+Pos = negative
		// Pos+Neg = negative
		
		// Addition Cases
		if(1 <= {{Sel},{Cin}} <= 4'b0101) begin
			if(((A+B) > 1<<BITS) && A[BITS-1] == 0) begin // Test Pos+Neg=Neg
				// true ... positively Guilty!
				statV_ = 1;
			end else statV_ = 0;
		end else if({{Sel}, {Cin}} == 4'b0101 && A<B) begin
			if((A-B)>0 && A[BITS-1] == 1) begin
				// True ... Guilty!
				statV_ = 1;
			end else statV_ = 0;
		end else statV_ = 0;
	 end
endmodule
