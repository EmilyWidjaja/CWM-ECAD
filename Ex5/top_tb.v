//////////////////////////////////////////////////////////////////////////////////
// Test bench for Exercise #5 - Traffic Lights
// Student Name: Emily Widjaja
// Date: 16 June 2020
//
// Description: A testbench module to test Ex5 - Traffic Lights
// You need to write the whole file
//////////////////////////////////////////////////////////////////////////////////


`timescale 1ns / 100ps

module top_tb(
	);

//Parameters
	parameter CLK_PERIOD = 10;

//Registers and wires
	reg clk;
	wire red;
	wire amber;
	wire green;
	reg [2:0] current_signal;
	reg [2:0] prev_signal;
	reg err;

//Generate clock
	initial
	 begin
	  clk = 1'b1;
	  forever
	   #(CLK_PERIOD/2) clk = ~clk;
	 end

//user logic

	initial begin
	  err=0;
	  //initialise current signal as red
	  //current_signal[0] = 1;	//red
	  //current_signal[1] = 0;  //amber
	  //current_signal[2] = 0;  //green
	  prev_signal = current_signal;
	  #1
	  forever begin
	    #CLK_PERIOD

	  //check that is a legal state
	    if (((current_signal==3'b001) || (current_signal==3'b011) || (current_signal==3'b100) || (current_signal==3'b010))==0) begin
	      $display("***TEST FAILED! This is an illegal state! red=%d, amber=%d, green=%d, current signal=%b***",red,amber,green,current_signal);
	      err=1;
	    end

	  //check that it has the correct sequence
	    else begin
	      if ( ((prev_signal==3'b001) && (current_signal!=3'b011)) || ((prev_signal==3'b011) && (current_signal!=3'b100)) || ((prev_signal==3'b100) && (current_signal!=3'b010)) || ((prev_signal==3'b010) &&(current_signal!=3'b001)) )
	      begin
		$display("*** Test FAILED! Incorrect sequence! current signal=%b, previous signal=%b***",current_signal,prev_signal);
		err=1;
	      end
	    end //else

	  prev_signal = current_signal;
	  current_signal[0] = red;
	  current_signal[1] = amber;
	  current_signal[2] = green;
	  end //forever

	end //initial

//Finish test, check for success
    initial begin
	#200
	if (err==0)
	 $display("***TEST PASSED!***");
	$finish;
    end

//Instantiate counter module
traffic top (
  .clk (clk),
  .red (red),
  .amber (amber),
  .green (green)
  );
endmodule
	  
