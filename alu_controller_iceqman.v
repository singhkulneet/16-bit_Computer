////////////////////////////////////////////////////////////////////////////////
//
// Filename: alu_controller_iceqman.v
// Author:   Kulneet Singh
// Date:     7 December 2019
// Revision: 1
// 
// Description: 
// This is the module that serves as the control unit for the FSMD.
//
////////////////////////////////////////////////////////////////////////////////

module alu_controller_iceqman(clock, reset, button, data, enAlu, enMul, opcode_o, opA_o, opB_o, state);
    input  clock, reset, button;
    input [7:0] data;
    output enAlu, enMul;
    output [3:0] opcode_o;
    output [7:0] opA_o, opB_o;
    output [3:0] state;
    
    parameter   INIT = 4'b0000, OPCODE = 4'b0001, OnlyA = 4'b0010, AndB1 = 4'b0011, 
                AndB2 = 4'b0100, RESULT = 4'b0101, MULT0 = 4'b0110, MULT1 = 4'b0111,
                MULT2 = 4'b0111, MULT3 = 4'b0111, MULT4 = 4'b0111, MULT5 = 4'b0111,
                MULT6 = 4'b0111, MULT7 = 4'b0111, MULT8 = 4'b0111;

    reg [3:0] state, next_state;
    reg enAlu, enMul;
    reg [7:0] opA, opB, opA_o, opB_o;
    reg [3:0] opcode, opcode_o;

    initial begin 
        state <= INIT;
    end

    always@(posedge clock or negedge reset) begin
        if(~reset)
            state <= INIT;
        else
            state <= next_state;
    end

    always@(button or state) begin
        case(state)
            INIT: 
            begin
                opcode = 4'hx;
                opB = 8'hxx;
                opA = 8'hxx;
                next_state = OPCODE;
            end
            OPCODE: 
            begin
                if(button) begin
                    opcode = data[3:0];
                    if(opcode == 4'd4 || opcode == 4'd7) begin 
                        next_state = OnlyA;
                    end
                    else if(opcode == 4'd12) begin
                        next_state = MULT0;
                    end
                    else begin 
                        next_state = AndB1;
                    end
                end
            end
            AndB1: 
            begin
                if(button) begin
                    opA = data[7:0];
                    next_state = AndB2;
                end
            end
            AndB2: 
            begin
                if(button) begin
                    opB = data[7:0];
                    next_state = RESULT;
                end
            end
            OnlyA: 
            begin
                if(button) begin
                    opA = data[7:0];
                    next_state = RESULT;
                end
            end
            RESULT: 
            begin
                next_state = OPCODE;
            end
            MULT0: 
            begin
                if(button) begin
                    opA = data[7:0];
                    next_state = MULT1;
                end
            end
            MULT1: 
            begin
                if(button) begin
                    opA = data[7:0];
                    next_state = MULT2;
                end
            end
            MULT2: 
            begin
                if(button) begin
                    opA = data[7:0];
                    next_state = MULT3;
                end
            end
            MULT3: 
            begin
                if(button) begin
                    opA = data[7:0];
                    next_state = MULT4;
                end
            end
            MULT4: 
            begin
                if(button) begin
                    opA = data[7:0];
                    next_state = MULT5;
                end
            end
            MULT5: 
            begin
                if(button) begin
                    opA = data[7:0];
                    next_state = MULT6;
                end
            end
            MULT6: 
            begin
                if(button) begin
                    opA = data[7:0];
                    next_state = MULT3;
                end
            end
            MULT7: 
            begin
                if(button) begin
                    opA = data[7:0];
                    next_state = MULT8;
                end
            end
            MULT8: 
            begin
                if(button) begin
                    opA = data[7:0];
                    next_state = OPCODE;
                end
            end
            default:   next_state = 3'bxxx;
        endcase
    end

    always @(state) begin
        case(state)
            INIT: 
            begin 
                enAlu = 1'b0;
                enMul = 1'b0;
                opcode_o = 4'bxxxx;
                opA_o = 8'bxxxxxxxx;
                opB_o = 8'bxxxxxxxx;
            end
            OPCODE: 
            begin 
                enAlu = 1'b0;
                enMul = 1'b0;
                opcode_o = 4'bxxxx;
                opA_o = 8'bxxxxxxxx;
                opB_o = 8'bxxxxxxxx;
            end
            OnlyA: 
            begin 
                enAlu = 1'b0;
                enMul = 1'b0;
                opcode_o = opcode;
                opA_o = opA;
                opB_o = 8'bxxxxxxxx;
            end
            AndB1: 
            begin 
                enAlu = 1'b0;
                enMul = 1'b0;
                opcode_o = 4'bxxxx;
                opA_o = 8'bxxxxxxxx;
                opB_o = 8'bxxxxxxxx;
            end
            AndB2: 
            begin 
                enAlu = 1'b0;
                enMul = 1'b0;
                opcode_o = 4'bxxxx;
                opA_o = 8'bxxxxxxxx;
                opB_o = 8'bxxxxxxxx;
            end
            RESULT: 
            begin 
                enAlu = 1'b1;
                enMul = 1'b0;
                opcode_o = opcode;
                opA_o = opA;
                opB_o = opB;
            end
            default: 
            begin 
                enAlu = 1'b0;
                enMul = 1'b1;
                opcode_o = 4'bxxxx;
                opA_o = opA;
                opB_o = 8'bxxxxxxxx;
            end
        endcase
    end

endmodule