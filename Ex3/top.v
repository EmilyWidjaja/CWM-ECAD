//////////////////////////////////////////////////////////////////////////////////
// Exercise #3 
// Student Name: Emily Widjaja
// Date: 15 Jun 20
//
//  Description: In this exercise, you need to design an up / down counter, where 
//  if the rst=1, the counter should be set to zero. If enable=0, the value
//  should stay constant. If direction=1, the counter should count up every
//  clock cycle, otherwise it should count down.
//  Wrap-around values are allowed.
//
//  inputs:
//           clk, rst, enable, direction
//
//  outputs:
//           counter_out[7:0]
//////////////////////////////////////////////////////////////////////////////////

`timescale 1ns / 100ps

module counter(
    //Todo: add ports 
	input clk,
	input rst,
	input enable,
	input dir,
	output reg [7:0] counter_out
    );
                    
    //Todo: add registers and wires, if needed
	//reg [7:0] counter_out;

    //Todo: add user logic (complete)
	always @ (posedge clk) 
	begin
	//reset is on, counter set to 0
	 if (rst) begin
	    counter_out<=0;
	 end
	 else begin
	    if (enable==0) begin//reset = 0, and enable is on, so hold
	     counter_out<=counter_out;
	    end
	    else begin //enable &rst is off, so count up or down
	      if (dir) begin
		   counter_out<=counter_out+1;
	      end
	      else begin
		   counter_out<=counter_out-1;
	      end
	    end
	  end

	end
endmodule
