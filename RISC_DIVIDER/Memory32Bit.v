`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    22:22:26 03/26/2015 
// Design Name: 
// Module Name:    Memory32Bit 
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
module DataMemory32Bit(
    input clk,
    input MW,
    input [31:0] DataInAddr,
	 input [31:0] DataOutAddr,
    input [31:0] DataIn,
    output wire [31:0] DataOut
    );
	 
	 integer i;
	 
	 initial begin
		for(i=0;i<SIZE;i=i+1) begin
			mem[i] = 0;
		end
		mem[1] = 32'b11001000111011001100100011101101; // 1.44781678214E+19 
		mem[2] = 32'b11001000111011001100100011101100;
		mem[3] = 32'b11111111111111101111111111111110; // 4294901758
		
		// Expected output of division:
		// 11001000111011011001000111011011 => 3371012571
		// 
	 end
	 
	 parameter SIZE = 20; // 32*20
	 
	 reg [31:0] mem [SIZE-1:0]; // 32^2 ... Massive

	assign DataOut = mem[DataOutAddr];

	 // manage the input and output
	 always @(posedge clk) begin
		if(MW) begin
			mem[DataInAddr] = DataIn;
		end
	 end

endmodule
