//////////////////////////////////////////////////////////////////////////////////
// Test bench for Exercise #4 - Electronic Dice
// Student Name: Emily Widjaja
// Date: 16 June 2020
//
// Description: A testbench module to test Ex4 - Electronic Dice
// You need to write the whole file
//////////////////////////////////////////////////////////////////////////////////

`timescale 1ns / 100ps

module top_tb(
	);

//Parameters
	parameter CLK_PERIOD = 10;

//Registers and wires
	reg clk;
	reg rst;
	reg button;
	wire [2:0] throw;
	reg [2:0] throw_prev;
	reg err;

//Generate clocks
	//general clock
	initial
	 begin
	  clk = 1'b1;
	  forever
	   #(CLK_PERIOD/2) clk = ~clk;
	 end

	//clock for reset
	initial begin
	  rst = 1;
	  #(CLK_PERIOD) rst = 0;
	  #(10*CLK_PERIOD) rst = 1;
	  #(2*CLK_PERIOD) rst = 0;
	end

	//lock for button
	initial begin
	  button = 0;
	  #CLK_PERIOD button = 1;
	  #(9*CLK_PERIOD) button = 0; //shd release when throw = 011
	  #(2*CLK_PERIOD) button = 1;
	end

//user logic
	initial begin
	  err=0;
	  throw_prev=throw;
	  #1

	  forever begin
	    #CLK_PERIOD

	    //condition 1: reset fails
	    if ( (rst==1)&&(throw!=3'b000) ) begin
	      $display("***TEST FAILED! Did not reset correctly. reset=%d, throw=%d***",rst,throw);
	      err=1;
	    end

	    //condition 2: button = 0, throw changes & throw is not special conditions
	    if ( (throw!=3'b000)||(throw!=3'b111)&&(rst==0)) begin
	      if ((button==0)&&(throw_prev!=throw)) begin
		$display("***TEST FAILED! Throw changed when button is 0. button=%d, throw=%d, previous throw=%d***",button,throw,throw_prev);
		err=1;
	      end
	    end

	    //condition 3: button = 1, throw doesn't change
	    if ((button==1)&&(throw_prev==throw)&&(rst==0)) begin
	      $display("***TEST FAILED! Throw doesn't change when button is 1. button=%d, throw=%d, previous throw=%d***",button,throw,throw_prev);
	    end
	    throw_prev = throw;

	  end//forever
	end //initial

//Finish test, check for success
    initial begin
	#200
	if (err==0)
	 $display("***TEST PASSED!***");
	$finish;
    end

//Instantiate counter module
dice top (
  .clk (clk),
  .rst (rst),
  .button (button),
  .throw (throw)
  );

endmodule



