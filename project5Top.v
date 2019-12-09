////////////////////////////////////////////////////////////////////////////////
//
// Filename: project5Top.v
// Author:   Kulneet Singh
// Date:     7 December 2019
// Revision: 1
// 
// Description: 
// This is the top level module for ECE 3544 Project 5.
//
////////////////////////////////////////////////////////////////////////////////

module project5Top(CLOCK_50, KEY, SW, HEX5, HEX4, HEX3, HEX2, HEX1, HEX0, LED);
	input        CLOCK_50;
	input  [3:0] KEY;
	input  [9:0] SW;
	output [6:0] HEX5;
	output [6:0] HEX4;
	output [6:0] HEX3;
	output [6:0] HEX2;
	output [6:0] HEX1;
	output [6:0] HEX0;
	output [9:0] LED;
	
// You should add your reg/wire/parameter declarations here.
	wire enAlu, enMul, button;
	wire [7:0] opA_o, opB_o;
	wire [3:0] opcode_o;
	wire [15:0] aluOut;
	wire [15:0] dispOut;
	wire [16:0] multiplier;
	wire [15:0] product;
	wire [4:0] state;

//=======================================================
// Module instantiantions
//=======================================================
	buttonpressed mod1(CLOCK_50, KEY[0], KEY[1], button);
	alu_controller_iceqman mod2(CLOCK_50, KEY[0], button, SW[7:0], enAlu, enMul, opcode_o, opA_o, opB_o, state);
	alu_core_iceqman mod3(enAlu, opcode_o, opA_o, opB_o, aluOut);
	multiplier_iceqman mod4(CLOCK_50, KEY[0], button, opA_o, multiplier, product);
	alu_register_iceqman mod5(CLOCK_50, KEY[0], enAlu, enMul, button, aluOut, product, dispOut);

	proc7segdecoder_iceqman disp0(dispOut[3:0], HEX0);
	proc7segdecoder_iceqman disp1(dispOut[7:4], HEX1);
	proc7segdecoder_iceqman disp2(dispOut[11:8], HEX2);
	proc7segdecoder_iceqman disp3(dispOut[15:12], HEX3);
	proc7segdecoder_iceqman disp5(state, HEX5);

//=======================================================
// Continuous Assignments
//=======================================================
	assign LED = SW;
	assign HEX4 = 7'b1111111;
	// assign HEX5 = 7'b1111111;

endmodule
