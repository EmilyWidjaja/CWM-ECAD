//////////////////////////////////////////////////////////////////////////////////
// Exercise #4 
// Student Name: Emily Widjaja
// Date: 16 Jun 2020
//
//  Description: In this exercise, you need to design an electronic dice, following
//  the diagram provided in the exercises documentation. The dice rolls as long as
//  a button is pressed, and stops when it is released. 
//
//  inputs:
//           clk, rst, button
//
//  outputs:
//           throw [2:0]
//
//  You need to write the whole file.
//////////////////////////////////////////////////////////////////////////////////

`timescale 1ns / 100ps

module dice(
	input clk,
	input rst,
	input button,
	output reg [2:0] throw
  );

  //add registers and wires (unnecessary)

  //add user logic
	always @ (posedge clk)
	begin
	  //if reset is on, set throw to [000]
	  if (rst)
	    throw<=3'b000;

	//reset is off. after in loop, make counter and depending on counter remainder, return appropriate throw.
	  else begin
	    if (button) begin
	      case (throw)
	        3'b000: throw<=3'b001;
	        3'b001: throw<=3'b010;
	        3'b010: throw<=3'b011;
	        3'b011: throw<=3'b100;
	        3'b100: throw<=3'b101;
	        3'b101: throw<=3'b110;
	        3'b110: throw<=3'b001;
	        3'b111: throw<=3'b001;
	      endcase
	    end
	    else begin
	      if ( (button==0)&&((throw==3'b000) || (throw==3'b111)) )
	        throw<=3'b001;
	      else
		throw<=throw;
	    end
	  end //closes else
	end //closes begin

	    

endmodule
