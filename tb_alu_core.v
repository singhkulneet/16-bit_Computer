////////////////////////////////////////////////////////////////////////////////
//
// Filename: tb_alu_core.v
// Author:   Kulneet Singh
// Date:     7 December 2019
// Revision: 1
// 
// Description: 
// This is the testbench module to test the alu core module.
//
////////////////////////////////////////////////////////////////////////////////

`timescale 1 ns/1 ns

module tb_alu_core();
    reg enable;
    reg [3:0] opcode;
    reg [7:0] opA;
    reg [7:0] opB;
    wire [15:0] core_out;

    alu_core_iceqman mod1(enable, opcode, opA, opB, core_out);
    
    initial begin
        enable = 1'b1;
        opcode = 4'b0000;
        opA = 8'h33;
        opB = 8'hff;
        #10; // 0x3328

        opcode = 4'b0001;
        opA = 8'haa;
        opB = 8'hf0;
        #10; // 0x005f
        
        opcode = 4'b0010;
        opA = 8'haa;
        opB = 8'hf0;
        #10; // 0x0005

        opcode = 4'b0011;
        opA = 8'haa;
        opB = 8'hf0;
        #10; // 0x005a

        opcode = 4'b0100;
        opA = 8'haa;
        opB = 8'hf0;
        #10; // 0x0055

        opcode = 4'b0101;
        opA = 8'hec;
        opB = 8'h0f;
        #10; // 0xfffb

        opcode = 4'b0110;
        opA = 8'hec;
        opB = 8'he7;
        #10; // 0x0005

        opcode = 4'b0111;
        opA = 8'h7f;
        opB = 8'he7;
        #10; // 0xff81

        opcode = 4'b1000;
        opA = 8'hff;
        opB = 8'h04;
        #10; // 0xfff0

        opcode = 4'b1001;
        opA = 8'hff;
        opB = 8'h04;
        #10; // 0x000f

        opcode = 4'b1010;
        opA = 8'hff;
        opB = 8'h0f;
        #10; // 0x807f
        
        opcode = 4'b1011;
        opA = 8'hfF;
        opB = 8'h04;
        #10; // 0xf00f
    end
endmodule