`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   06:16:50 02/03/2015
// Design Name:   TinyCPU
// Module Name:   C:/Users/Eternia/Dropbox/Xilinx/Projects/HW2/TinyCPU_tb.v
// Project Name:  HW2
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: TinyCPU
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module TinyCPU_tb;

	// Inputs
	reg clk;
	reg LoadEnable;
	reg [1:0] ASelect;
	reg [1:0] BSelect;
	reg [1:0] DestinationSelect;
	reg [15:0] ConstantIn;
	reg MBSelect;
	reg MDSelect;
	reg [3:0] GSelect;
	reg [1:0] HSelect;
	reg MFSelect;
	reg [15:0] DataIn;

	// Outputs
	wire [15:0] DataOut, AddressOut;
	wire statC;
	wire statV;
	wire statN;
	wire statZ;

	// Instantiate the Unit Under Test (UUT)
	TinyCPU uut (
		.clk(clk), 
		.LoadEnable(LoadEnable), 
		.ASelect(ASelect), 
		.BSelect(BSelect), 
		.DestinationSelect(DestinationSelect), 
		.ConstantIn(ConstantIn), 
		.MBSelect(MBSelect), 
		.MDSelect(MDSelect), 
		.GSelect(GSelect), 
		.HSelect(HSelect), 
		.MFSelect(MFSelect), 
		.AddressOut(AddressOut), 
		.DataOut(DataOut), 
		.DataIn(DataIn), 
		.statC(statC), 
		.statV(statV), 
		.statN(statN), 
		.statZ(statZ)
	);

	initial begin
		// Initialize Inputs
		clk = 0;					  // Register clock system
		LoadEnable = 0;		  // Allow storing data from ALU/Shifter or DataIn
		ASelect = 0;			  // Register1 select (in asm instruction)
		BSelect = 0;			  // Register2 select (in asm instruction)
		DestinationSelect = 0; // select register
		ConstantIn = 0;		  // Constant Generator
		MBSelect = 0;			  // Constant Select (if 1, a constant is used instead of B)
		MDSelect = 0;			  // Input data select (if 0, store data in register, if 1, retrieve data from external RAM)
		GSelect = 0;			  // Select operation for ALU
		HSelect = 0;			  // Select operation for shifter
		MFSelect = 0;			  // Function select (ALU or Shifter)
		//AddressOut = 0;		  // Address to the RAM
		DataIn = 0;				  // input data from RAM

		// Wait 100 ns for global reset to finish
		#100;
        
		// Insert basic memory for add operation
		LoadEnable=1;
		DestinationSelect=0;
		DataIn=12345;
		MDSelect=1;
		#20;
		DestinationSelect=1;
		#20; // Wait for data input
		DataIn=22222;
		#20;
		LoadEnable=0;
		
		// Perform add operation
		ASelect = 0; // R0
		BSelect = 1; // R1
		
		GSelect = 4'b0010; // A+B;
		#20;
		
		// Store result in R3
		DestinationSelect=3;
		#20; // Set Dest
		
		MDSelect=0; // Force output of ALU back into registers
		LoadEnable=1;
		#40;
		LoadEnable=0;
		
		#20;
		
		// Output results to DataOut
		BSelect = 3; // R3
	end
	
	always #10 clk=~clk;
      
endmodule

