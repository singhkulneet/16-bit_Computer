// Filename:    proc7segdecoder_iceqman.v
// Author:      Kulneet Singdual_converter_YOURPIDh
// Date:        10/01/2019
// Version:     1   
// Description: Verilog source code for problem 6 with a procedural assignment implementation

module proc7segdecoder_iceqman(hex_digit, hex_display);
    input   [3:0] hex_digit;
    output  [6:0] hex_display;
    reg     [6:0] hex_display;

    // Procedural block to assign values to hex_display, when hex_digit changes
    // Created using the case structure
    always@(hex_digit) begin
        case(hex_digit)
            4'b0000:    hex_display = 7'b1000000; // 0
            4'b0001:    hex_display = 7'b1111001; // 1
            4'b0010:    hex_display = 7'b0100100; // 2
            4'b0011:    hex_display = 7'b0110000; // 3
            4'b0100:    hex_display = 7'b0011001; // 4
            4'b0101:    hex_display = 7'b0010010; // 5
            4'b0110:    hex_display = 7'b0000010; // 6
            4'b0111:    hex_display = 7'b1111000; // 7
            4'b1000:    hex_display = 7'b0000000; // 8
            4'b1001:    hex_display = 7'b0010000; // 9
            4'b1010:    hex_display = 7'b0001000; // 10
            4'b1011:    hex_display = 7'b0000011; // 11
            4'b1100:    hex_display = 7'b1000110; // 12
            4'b1101:    hex_display = 7'b0100001; // 13
            4'b1110:    hex_display = 7'b0000110; // 14
            4'b1111:    hex_display = 7'b0001110; // 15
        endcase
    end

endmodule
