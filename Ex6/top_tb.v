//////////////////////////////////////////////////////////////////////////////////
// Test bench for Exercise #6 - Dice or Traffic Lights?
// Student Name: Emily Widjaja
// Date: 16 June 2020
//
// Description: A testbench module to test Ex6 - Dice or Traffic Lights?
// You need to write the whole file
//////////////////////////////////////////////////////////////////////////////////

`timescale 1ns / 100ps

module top_tb(
	);

//Parameters
	parameter CLK_PERIOD = 10;

//Registers and wires
	reg rst;
	reg clk;
	reg button;
	reg sel;
	reg prev_sel;
	wire [2:0] result;
	reg [2:0] prev_result;
	reg err;

//Generate clocks
	//clk
	initial begin
	  clk = 1'b1;
	  forever
	   #(CLK_PERIOD/2) clk = ~clk;
	end

	//rst
	initial begin
	  rst = 1;
	  #(CLK_PERIOD) rst = 0;
	  #(10*CLK_PERIOD) rst = 1;
	  #(2*CLK_PERIOD) rst = 0;
	end

	//button
	initial begin
	  button = 0;
	  #CLK_PERIOD button = 1;
	  #(9*CLK_PERIOD) button = 0;
	  #(2*CLK_PERIOD) button = 1;
	end

	//sel
	initial begin;
	  sel = 1'b1;	//starts with traffic lights
	  forever
	  #(4*CLK_PERIOD) sel = ~sel;
	end

//user logic
	//initialise
	initial begin
	  err=0;
	  #1
	//start check
	  forever begin
	    #CLK_PERIOD
	//case 1: Dice or traffic lights not instantiated
	      if (result==1'bX) begin
		$display("***TEST FAILED! Dice or traffic lights has not been instantiated. result=%b***",result);
		err=1;
	      end

	//case 2: multiplexer not instantiated

	//when sel = 0, dice should be the output (could test, by adding in sel_prev, so when sel = 0 for 2 or more clock cycles, it will check that it is following the correct sequence. Maybe using a case? This is quite a lot of code though, so I have chosen not to implement it just yet. I have checked the sequences are properly coming through on simgui for both the dice and the traffic lights. 


	//when sel = 1, traffic should be the output. If this fails, it could also be an error in the traffic code, as the code might not be able to correct from illegal states.
	      if ( (sel==1)&&(prev_sel==1) ) begin

		//checks for illegal states
		if ( ((result==3'b001) || (result==3'b011) || (result==3'b100) || (result==3'b010))==0 ) begin
		  $display("***TEST FAILED! Traffic light in illegal state! result=%b,sel=%d***",result,sel);
		  err=1;
		end
	      end
	    prev_sel=sel;
	    prev_result=result;
	  end //forever
	end //initial

//Finish test, check for success
    initial begin
	#200
	if (err==0)
	 $display("***TEST PASSED!***");
	$finish;
    end

//Instantiate combined multiplexer module
DiceOrTraffic top (
    .clk (clk),
    .rst (rst),
    .button (button),
    .sel (sel),
    .result (result)
    );

endmodule
