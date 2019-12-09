////////////////////////////////////////////////////////////////////////////////
//
// Filename: alu_core_iceqman.v
// Author:   Kulneet Singh
// Date:     7 December 2019
// Revision: 1
// 
// Description: 
// This is the module that serves as the core for the ALU.
//
////////////////////////////////////////////////////////////////////////////////

module alu_core_iceqman(enable, opcode, opA, opB, core_out);
    input enable;
    input  [3:0] opcode;
    input [7:0] opA, opB;
    output [15:0] core_out;

    reg signed [15:0] core_out;
    reg signed [15:0] temp_core;
    wire signed [7:0] opA, opB;

    initial begin
        core_out = 15'd0;
    end

    always@* begin
        if(enable) begin
            case(opcode)
                4'b0000: core_out = ({opA, opB} & 16'h7728);
                4'b0001: core_out = {8'h00, ~(opA & opB)};
                4'b0010: core_out = {8'h00, ~(opA | opB)};
                4'b0011: core_out = {8'h00, opA ^ opB};
                4'b0100: core_out = {8'h00, ~opA};
                4'b0101: core_out = opA + opB;
                4'b0110: core_out = opA - opB;
                4'b0111: core_out = -opA;
                4'b1000: 
                begin
                    temp_core = (opA[7]) ? {8'hff, opA} : {8'h00, opA};
                    core_out = temp_core << opB[3:0];
                end
                4'b1001: 
                begin
                    temp_core = (opA[7]) ? {8'hff, opA} : {8'h00, opA};
                    core_out = temp_core >> opB[3:0];
                end
                4'b1010: 
                begin
                    temp_core = {8'h00, opA};
                    case(opB[3:0])
                        4'd1:   core_out = {temp_core[14:0], temp_core[15]};
                        4'd2:   core_out = {temp_core[13:0], temp_core[15:14]};
                        4'd3:   core_out = {temp_core[12:0], temp_core[15:13]};
                        4'd4:   core_out = {temp_core[11:0], temp_core[15:12]};
                        4'd5:   core_out = {temp_core[10:0], temp_core[15:11]};
                        4'd6:   core_out = {temp_core[9:0], temp_core[15:10]};
                        4'd7:   core_out = {temp_core[8:0], temp_core[15:9]};
                        4'd8:   core_out = {temp_core[7:0], temp_core[15:8]};
                        4'd9:   core_out = {temp_core[6:0], temp_core[15:7]};
                        4'd10:  core_out = {temp_core[5:0], temp_core[15:6]};
                        4'd11:  core_out = {temp_core[4:0], temp_core[15:5]};
                        4'd12:  core_out = {temp_core[3:0], temp_core[15:4]};
                        4'd13:  core_out = {temp_core[2:0], temp_core[15:3]};
                        4'd14:  core_out = {temp_core[1:0], temp_core[15:2]};
                        4'd15:  core_out = {temp_core[0], temp_core[15:1]};
                        default:    core_out = temp_core;
                    endcase
                end
                4'b1011: 
                begin
                    temp_core = {8'h00, opA};
                    case(opB[3:0])
                        4'd15:  core_out = {temp_core[14:0], temp_core[15]};
                        4'd14:  core_out = {temp_core[13:0], temp_core[15:14]};
                        4'd13:  core_out = {temp_core[12:0], temp_core[15:13]};
                        4'd12:  core_out = {temp_core[11:0], temp_core[15:12]};
                        4'd11:  core_out = {temp_core[10:0], temp_core[15:11]};
                        4'd10:  core_out = {temp_core[9:0], temp_core[15:10]};
                        4'd9:   core_out = {temp_core[8:0], temp_core[15:9]};
                        4'd8:   core_out = {temp_core[7:0], temp_core[15:8]};
                        4'd7:   core_out = {temp_core[6:0], temp_core[15:7]};
                        4'd6:   core_out = {temp_core[5:0], temp_core[15:6]};
                        4'd5:   core_out = {temp_core[4:0], temp_core[15:5]};
                        4'd4:   core_out = {temp_core[3:0], temp_core[15:4]};
                        4'd3:   core_out = {temp_core[2:0], temp_core[15:3]};
                        4'd2:   core_out = {temp_core[1:0], temp_core[15:2]};
                        4'd1:   core_out = {temp_core[0], temp_core[15:1]};
                        default:    core_out = temp_core;
                    endcase
                end
                default: core_out = 16'hxxxx;
            endcase
        end
    end

endmodule