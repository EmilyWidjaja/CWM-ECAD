//////////////////////////////////////////////////////////////////////////////////
// Exercise #5 
// Student Name: Emily Widjaja
// Date: 16 June 2020
//
//  Description: In this exercise, you need to implement a UK traffic lights 
//  sequencing system. 
//
//  inputs:
//           clk
//
//  outputs:
//           red, amber, green
//////////////////////////////////////////////////////////////////////////////////

`timescale 1ns / 100ps

module traffic(
	input clk,
	output reg red,
	output reg amber,
	output reg green
  );

  //add registers and wires
//maybe something to combine the output into input? since old 
	wire [2:0] current_signal;

  //add user logic
	assign current_signal[0] = red;
	assign current_signal[1] = amber;
	assign current_signal[2] = green; //current_signal might need to be reg idk.

	always @ (posedge clk)
	  begin

	  //legal state 1: red -> red,amber
	  if (current_signal==3'b001)
//(current_signal[0]==1) && (current_signal[2:1]==0) ) 
	  begin
	    red<=1;	//technically this is unnecessary since already red
	    amber<=1;
	    green<=0;
	  end

	  //legal state 2: red,amber -> green
	  if (current_signal==3'b011)
//(current_signal[1:0]==1) && (current_signal[2]==0) ) 
	  begin
	    red<=0;
	    amber<=0;
	    green<=1;
	  end

	  //legal state 3: green -> amber
	  if (current_signal==3'b100)
//(current_signal[1:0]==0) && (current_signal[2]==1) )
	  begin
	    green<=0;
	    amber<=1;	//could add in red<=0;
	  end

	  //legal state 4: amber -> red
	  if (current_signal==3'b010)
//(current_signal[1]==1) && (current_signal[2]==0) && (current_signal[0]==0) )
	  begin
	    amber<=0;
	    red<=1; //could add in green<=0;
	  end

	  //illegal states. Assign default (red)
	  else begin
	    red<=1;
	    amber<=0;
	    green<=0;
	  end

	end //always

endmodule
