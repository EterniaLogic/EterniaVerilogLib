`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    12:37:21 03/05/2014 
// Design Name: 
// Module Name:    Motor_Speed_Fwd_Back 
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
module Motor_Speed_Fwd_Back(
    input CLK,
    output reg [1:0] Mode,
    output reg [7:0] Duty
    );
	 
	 initial begin
		Mode = 1;
		Duty = 0;
	 end
	 
	always @ (posedge CLK) begin
		Duty <= Duty+1;
		if(Duty == 0) begin
			Mode <=~Mode; // flips binary (1 -> 3 -> 1)
		end
	end

endmodule
