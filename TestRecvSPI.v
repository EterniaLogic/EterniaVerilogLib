`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   02:42:03 02/19/2014
// Design Name:   SPI_RECV
// Module Name:   /home/eternia/Dropbox/Project Lab 1/Verilog/TestRecvSPI.v
// Project Name:  InfaredElectromagnetDemo
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: SPI_RECV
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module TestRecvSPI;

	// Inputs
	reg CLK;
	reg SerialIN;
	reg Enable;
	
	
	wire [9:0] DataIN;
	wire DataCLK;
	
	reg [3:0] State;
	integer i,j;
	// Instantiate the Unit Under Test (UUT)
	SPI_RECV uut (
		.CLK(CLK), 
		.Enable(Enable), 
		.SerialIN(SerialIN), 
		.DataIN(DataIN),
		.DataCLK(DataCLK)
	);

	initial begin
		// Initialize Inputs
		CLK = 0;
		SerialIN = 0;
		Enable = 0;
		State = 0;
		i = 0;
		j = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here
		// test SPI
		
		while(1) begin
			for(i=0;i<1024;i=i+1) begin
				for(j=0;j<15;j=j+1) begin
					case (State)
							0: Enable <= 1;
							2: SerialIN <= 0; 
							3: SerialIN <= i[9]; // bit 9
							4: SerialIN <= i[8];
							5: SerialIN <= i[7];
							6: SerialIN <= i[6];
							7: SerialIN <= i[5];
							8: SerialIN <= i[4];
							9: SerialIN <= i[3];
							10:SerialIN <= i[2];
							11:SerialIN <= i[1];
							12:SerialIN <= i[0];
							
							15: begin Enable <= 0; 
									j=100;
								end
							default: SerialIN <= 0;
					endcase
					
					#160;
					CLK = 0;
					#160;
					CLK = 1;
					State = State+1;
				end
			end
		end
	end
      
endmodule

