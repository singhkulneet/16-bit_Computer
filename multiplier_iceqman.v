////////////////////////////////////////////////////////////////////////////////
//
// Filename: multiplier_iceqman.v
// Author:   Kulneet Singh
// Date:     7 December 2019
// Revision: 1
// 
// Description: 
// This is the module that serves as multiplier for the alu.
//
////////////////////////////////////////////////////////////////////////////////

module multiplier_iceqman(clock, reset, multiplicand, multiplier, product);
    input        clock, reset;
    input  [7:0] multiplicand;
    input enable;
    output [16:0] multiplier;
    output [15:0] product;

    reg [16:0] multiplier;
    wire Cout;
    wire [7:0] Sum, mux_out;
    reg [1:0] state;
    reg [3:0] count;

    parameter INIT = 2'b00, CALC = 2'b01;

    control u1(multiplier[0], multiplicand, mux_out);
    adder u2(multiplier[15:8], mux_out, Sum, Cout);

    always@(posedge clock or negedge reset) begin
        if(!reset) begin
            state = INIT;
            multiplier = 16'd0;
        end

        else begin
            case(state)
                INIT:
                begin
                    multiplier[16:8] = 9'd0;
                    multiplier[7:0] = multiplicand;
                    count = 4'd0;
                    state = CALC;
                end
                CALC:
                begin
                    multiplier[15:8] = Sum;
                    multiplier[16] = Cout;
                    multiplier = multiplier >> 1'b1;
                    count = count + 1'b1;
                    if(count >= 4'd8) begin
                        state = INIT;
                    end
                end
            endcase
        end
    end

    assign product = multiplier[15:0];
endmodule

module adder(A, B, Sum, Cout);
    input [7:0] A;
    input [7:0] B;
    output [7:0] Sum;
    output Cout;

    assign {Cout, Sum} = A + B;

endmodule

module control(lsb, multiplicand, mux_out);
    input lsb;
    input [7:0] multiplicand;
    output [7:0] mux_out;

    assign mux_out = lsb ? multiplicand : 8'd0;
endmodule