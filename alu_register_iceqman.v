////////////////////////////////////////////////////////////////////////////////
//
// Filename: alu_register_iceqman.v
// Author:   Kulneet Singh
// Date:     7 December 2019
// Revision: 1
// 
// Description: 
// This is the register module to hold.
//
////////////////////////////////////////////////////////////////////////////////

module alu_register_iceqman(clock, reset, enable, enable2, button, ins, ins2, outs);
    input        clock, reset, enable, enable2, button;
    input  [15:0] ins, ins2;
    output [15:0] outs;

    reg [15:00] outs;


    always@(posedge clock or negedge reset) begin
        if(!reset) begin
            outs <= 16'd0;
        end
        else if(enable) begin
            outs <= ins;
        end
		else if(button) begin
            if(enable2) begin
                outs <= ins2;
            end
		end
    end 

endmodule