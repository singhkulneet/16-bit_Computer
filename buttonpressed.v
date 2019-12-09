///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Filename:    buttonpressed.v
// Author(s):	 Tom Martin, Jason Thweatt
// Date:        24 October 2013
// Version:     3 (28 March 2017)
// Description: This FSM generates a one clock-cycle output pulse each time a pushbutton is pressed and released.
//              The pushbuttons on your board output 0 when PRESSED and 1 when NOT PRESSED.
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

module buttonpressed(clock, reset, button_in, pulse_out);
	input        clock;			// The system clock. (Connect to an FPGA clock signal in the top-level module.)
	input	       reset;			// Active-low reset. (Connect to the RESET pushbutton in the top-level module.)
	input        button_in;		// Input pushbutton signal. (Connect to some other pushbutton in the top-level module.)
	output       pulse_out;		// The output is high for one clock cycle each time the button is pressed and released.

	reg    [1:0] state;			// The module's present state.
	reg    [1:0] next_state;	// The module's next state.

	parameter [1:0] BUTTON_FREE = 2'b00, BUTTON_PRESSED = 2'b01, BUTTON_RELEASED = 2'b10;
	
	always@(posedge clock or negedge reset) begin
		if(reset == 1'b0)
			state <= BUTTON_FREE;
		else begin
			case(state)
				BUTTON_FREE: begin
					if(button_in == 1'b0)
						state <= BUTTON_PRESSED;
				end
				BUTTON_PRESSED: begin
					if(button_in == 1'b1)
						state <= BUTTON_RELEASED;
				end
				BUTTON_RELEASED:
					state <= BUTTON_FREE;
				default:
					state <= 2'bxx;
			endcase
		end
	end
	
	assign pulse_out = (state == BUTTON_RELEASED);
	
endmodule