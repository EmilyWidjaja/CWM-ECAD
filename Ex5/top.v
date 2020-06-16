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
	reg [2:0] current_signal;

  //add user logic

	always @ (posedge clk)
	  begin
	  //current signal as a reg
	  current_signal[0]<=red;
	  current_signal[1]<=amber;
	  current_signal[2]<=green;

	  //legal state 1: red -> red,amber
	  if (current_signal==3'b001) 
	  begin
	    red<=1;	//technically this is unnecessary since already red
	    amber<=1;
	    green<=0;
	  end
	else begin
	  //legal state 2: red,amber -> green
	  if (current_signal==3'b011)
//(current_signal[1:0]==1) && (current_signal[2]==0) ) 
	  begin
	    red<=0;
	    amber<=0;
	    green<=1;
	  end

	    else begin
	    //legal state 3: green -> amber
	      if (current_signal==3'b100)
	       begin
	       green<=0;
	       amber<=1;	//could add in red<=0;
	       end

	      else begin
	  //legal state 4: amber -> red
	 	if (current_signal==3'b010)
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
	      end //state 3
	    end //state 2
	 end //else state 1

	end //always

endmodule
