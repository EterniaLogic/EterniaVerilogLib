`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   22:55:16 02/02/2015
// Design Name:   ALU
// Module Name:   C:/Users/Eternia/Dropbox/Xilinx/Projects/HW2/ALu_tb.v
// Project Name:  HW2
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: ALU
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module ALU_tb;

	// Inputs
	reg Cin;
	reg [2:0] Sel;
	reg [3:0] A;
	reg [3:0] B;
	integer i,j,k;

	// Outputs
	wire [3:0] Out;
	wire Cout, statV;

	// Instantiate the Unit Under Test (UUT)
	defparam uut.BITS=4; // smaller bits
	ALU uut (
		.Cin(Cin), 
		.Sel(Sel), 
		.A(A), 
		.B(B), 
		.Out(Out), 
		.Cout(Cout),
		.statV(statV)
	);

	initial begin
		// Initialize Inputs
		Cin = 0;
		Sel = 0;
		A = 0;
		B = 0;

		// Wait 100 ns for global reset to finish
		#100;
		
		
		// Test most cases for the ALU
		for(j=0;j<16;j=j+1) begin
			A = j;
			for(k=0;k<16;k=k+1) begin
				B = k;
				for(i=0;i<16;i=i+1) begin
					{Sel,Cin} = i;
					#1;
				end
			end
		end
	end
      
endmodule

