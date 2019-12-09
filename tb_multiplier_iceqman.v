////////////////////////////////////////////////////////////////////////////////
//
// Filename: tb_multiplier_iceqman.v
// Author:   Kulneet Singh
// Date:     7 December 2019
// Revision: 1
// 
// Description: 
// This is the module that serves as the testbench for the
// multiplier module.
//
////////////////////////////////////////////////////////////////////////////////

`timescale 1 ns/1 ns

module tb_multiplier_iceqman();
    reg clock, reset;
    reg [7:0] multiplicand;
    wire [16:0] register;
    wire [15:0] product;

    multiplier_iceqman dut(clock, reset, multiplicand, register, product);

    initial begin
        clock = 1'b1;
        reset = 1'b0;
        multiplicand = 8'd9; // multiplier
        #20;
        reset = 1'b1;
        #20;
        multiplicand = 8'd5; // multiplicand
        #160; // = 16'd45
        multiplicand = 8'd200; // multiplier
        #20;
        multiplicand = 8'd220; // multiplicand
        #160; // = 16'd44000
	end

	// Procedural block modeling 50 MHz Clock
	always begin
		#10 clock = !clock; // 50 MHz frequency = 20 ns period
	end

endmodule