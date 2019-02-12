`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    21:57:05 03/26/2015 
// Design Name: 
// Module Name:    RISC 
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
module RISC(input clk);

	// Pre-IF
	wire [31:0] PC;
	wire [1:0] PCSelect;
	assign PCSelect = {{BS[0] & (BS[1] | (PS_EX^Z))}, {BS[1]}};
	MUX4 mC(PCSelect, PC_DOF, BrA, RAA_EX, BrA, PC); // Branch Select


	 // IF
	 wire [31:0] PC_IF, IR;
	 NegEdgeBuffer32 pcif(clk, PC, PC_IF);
	 
	 Instruction32BitMemory InstMem(clk, PC_IF, IR);
	 
	 // DOF
	 wire [31:0] IR_DOF, PC_DOF, DecBusA, DecBusB, RAA, MBd, MbConstIM;
	 wire [4:0] RegA, RegB, RegD;
	 wire RW, PS, MW;
	 wire [1:0] BS, MD;
	 wire [4:0] FS, SH;
	 NegEdgeBuffer32 pcdof(clk, PC_IF+1, PC_DOF);
	 NegEdgeBuffer32 irdof(clk, IR, IR_DOF);
	 
	 assign RegA = IR_DOF[19:15];
	 assign RegB = IR_DOF[14:10];
	 assign RegD = IR_DOF[24:20];
	 
	 assign SH = IR[4:0];
	 assign MbConstIM = CS ? (IR_DOF[14] ? ~IR_DOF[14:0]+1 : IR_DOF[14:0]) : IR_DOF[14:0];
	 InstructionDecoder id1(IR_DOF, RW, MD, BS, PS, MW, FS, MA, MB, CS);
	 RegisterFile_32Bit RegFile(clk, RW_WB, RegA, RegB, DA_WB, MDOut, DecBusA, DecBusB);
	 
	 MUX4 mA({{HA},{MA}}, DecBusA, PC_DOF, MDOut2, 0, RAA); // Decode A
	 MUX4 mB({{HB},{MB}}, DecBusB, MbConstIM, MDOut2, 0, MBd); // Decode B
	 
	 // EXECUTE
	 wire [31:0] PC_EX, RAA_EX, MBd_EX, BrA;
	 wire [4:0] FS_EX, SH_EX, DA_EX;
	 wire [1:0] MD_EX, BS_EX;
	 wire RW_EX, MW_EX, PS_EX, Z, C, N, V;
	 wire [31:0] MemDataOut, FuncOut;
	 
	 // Data Forwarding
	 wire CompBA_EX, CompAA_EX, HA, HB;
	 wire [31:0] MDOut2;
	 assign CompAA_EX = (RegA == DA_EX);
	 assign CompBA_EX = (RegB == DA_EX);
	 assign HA = CompAA_EX && ~MA && RW_EX;
	 assign HB = CompBA_EX && ~MB && RW_EX;
	 
	 MUX4 mD2(MD_EX, FuncOut, MemDataOut, {{31'b0000000000000000000000000000000},{N^V}}, 0, MDOut2); // Writeback
	 
	 
	 
	 // Buffers
	 NegEdgeBuffer32 pcex(clk, PC_DOF, PC_EX);
	 NegEdgeBuffer1  rwex(clk, RW, RW_EX);
	 NegEdgeBuffer5  daex(clk, RegD, DA_EX);
	 NegEdgeBuffer2  mdex(clk, MD, MD_EX);
	 NegEdgeBuffer2  bsex(clk, BS, BS_EX);
	 NegEdgeBuffer1  psex(clk, PS, PS_EX);
	 NegEdgeBuffer1  mwex(clk, MW, MW_EX);
	 NegEdgeBuffer5  fsex(clk, FS, FS_EX);
	 NegEdgeBuffer5  shex(clk, SH, SH_EX);
	 NegEdgeBuffer32 busaex(clk, RAA, RAA_EX);
	 NegEdgeBuffer32 busbex(clk, MBd, MBd_EX);
	 
	 DataMemory32Bit DataMem(clk, MW_EX, RAA_EX, RAA_EX, MBd_EX, MemDataOut);
	 FunctionUnit fu1(RAA_EX, MBd_EX, FS_EX, SH_EX, C, N, V, Z, FuncOut);
	 Adder add1(PC_EX, MBd_EX, BrA);
	 
	 // Write Back
	 wire [31:0] FO_WB, MEM_WB;
	 wire [4:0] DA_WB;
	 wire [1:0] MD_WB;
	 wire RW_WB, NV_WB;
	 wire [31:0] MDOut;
	 NegEdgeBuffer1  rwWB(clk, RW_EX, RW_WB);
	 NegEdgeBuffer5  daWB(clk, DA_EX, DA_WB); // goes to register file up in DOF
	 NegEdgeBuffer1  NVWB(clk, (N^V), NV_WB);
	 NegEdgeBuffer32 FOWB(clk, FuncOut, FO_WB);
	 NegEdgeBuffer32 memWB(clk, MemDataOut, MEM_WB);
	 NegEdgeBuffer2  mdwb(clk, MD_EX, MD_WB);
	 
	 MUX4 mD(MD_WB, FO_WB, MEM_WB, {{31'b0000000000000000000000000000000},{NV_WB}}, 0, MDOut); // Writeback
	 
	 
	 
	 
	 
	 function [1:0] OneTo4;
		input ins;
		begin
			OneTo4 = {{1'b0},{ins}};
		end
	 endfunction
endmodule
