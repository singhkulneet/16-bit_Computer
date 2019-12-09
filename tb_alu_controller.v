////////////////////////////////////////////////////////////////////////////////
//
// Filename: tb_alu_controller.v
// Author:   Kulneet Singh
// Date:     7 December 2019
// Revision: 1
// 
// Description: 
// This is the testbench module to test the alu controller module.
//
////////////////////////////////////////////////////////////////////////////////

`timescale 1 ns/1 ns

module tb_alu_controller();
    reg clock, reset, button;
    reg [7:0] data_in;
    wire enAlu, enMul, disp_alu;
    wire [2:0] state;
    wire [3:0] opcode_o;
    wire [7:0] opA_o, opB_o;

    alu_controller_iceqman mod1(clock, reset, button, data_in, enAlu, enMul, opcode_o, opA_o, opB_o, disp_alu, state);
    
    initial begin
        // Reset
        clock = 1'b0;
        reset = 1'b0;
        data_in = 8'd0;
        button = 1'b1;
        #20;

        // Opcode: pid && (A, B)
        reset = 1'b1;
        button = 1'b0;
        data_in = 8'd0;
        #20;

        // A = 0x33
        data_in = 8'h33;
        #20;

        // B = 0xff
        data_in = 8'hff;
        #20;
    end

    // Procedural block modeling 50 MHz Clock
	always begin
		#10 clock = !clock; // 50 MHz frequency = 20 ns period
	end

endmodule