`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    00:23:31 03/27/2015 
// Design Name: 
// Module Name:    Instruction32BitMemory 
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
module Instruction32BitMemory(
    input clk,
    input [31:0] Addr,
    output wire [31:0] DataOut
    );
	 
	 parameter SIZE = 64; // 32*64
	 
	 reg [31:0] mem [SIZE-1:0];
	 integer i;
	 integer file, eof;

	 initial begin
		// load in the memory
		//$readmemb("instructions.mem", mem) ;
		for(i=0;i<SIZE;i=i+1) begin
			mem[i] = 0;
		end
		
		//$readmemb("/home/eternia/Dropbox/Xilinx/Projects/Project4/Cpp/Div.bin", mem);
		//$readmemb("Cpp/prog.bin", mem);
		//$readmemh("Cpp/Div.hex", mem);
		
		file = $fopen("Cpp/Div.bin", "r");
		i=0;
		while(!$feof(file)) begin
			$fread(file, mem[0], 0, 32);
			i=i+32;
		end
		
		//$display("loadup?");
		/*mem[0] = 32'h00000000;
		mem[1] = 32'h00000000;
		mem[2] = 32'h00000000;
		mem[3] = 32'h44108001; 
		mem[4] = 32'h44210002;
		mem[5] = 32'h44318003;
		mem[6] = 32'h44528001;
		mem[7] = 32'h42108000;
		mem[8] = 32'h42210000;
		mem[9] = 32'h42318000;
		mem[10] = 32'h00000000; 
		mem[11] = 32'hCA608C00; 
		mem[12] = 32'hC0600008; 
		mem[13] = 32'h0A118400; 
		mem[14] = 32'h44420001; 
		mem[15] = 32'h88000002; 
		mem[16] = 32'h00000000; 
		mem[17] = 32'h40200003; 
		mem[18] = 32'h4A210001; 
		mem[19] = 32'h44420003; 
		mem[20] = 32'h60420003; 
		mem[21] = 32'h04120400; 
		mem[22] = 32'h88000003; 
		mem[23] = 32'h80108000;*/
	end

	 assign DataOut = mem[Addr]; // High speed output
endmodule
