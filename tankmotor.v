`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:59:27 01/26/2014 
// Design Name: 
// Module Name:    H-Bridge 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
// Adapted from blink2
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module tankdrive(
    input sysclk,
	 input [5:0] speed,
	 input [1:0] mode,
    output reg enable,
	 output [1:0] mode_out,
	 output [1:0] mode_out2,
	 /*output light,*/
	 output enable2
    );

	parameter T = 1048576;  // Constant defining one period
	parameter slice = 16384; // Constant defining 1/64th of the period T
	reg [23:0] Tdepth =0; // Tracks how far we are into the current period
	reg [20:0] Sdepth = 0; // Tracks how far we are into the current "slice"

	reg [5:0] whichslice = 0; // Tracks how many "slices" have elapsed since
										// start of the most recent period
//	reg [1:0] modein_reg;
//	reg [1:0] modeout_reg;

	//reg lightreg = 0;
	assign mode_out = mode;
	assign enable2 = enable;
	assign mode_out2 = mode;
	//assign light = lightreg;

initial
	begin
		enable = 0;
	end
	
always @ (posedge sysclk)
begin

	if (whichslice <= speed)
		enable = 1;
	else
		enable = 0;
end

always @ (negedge sysclk)
begin

		if (Sdepth > slice)
		begin
			if (Tdepth > T)
				Tdepth = 0;
			whichslice = whichslice + 1;
			Sdepth = 0; 	
		end
		else
			begin
				Sdepth = Sdepth + 1;
				Tdepth = Tdepth + 1;
			end
end
endmodule
