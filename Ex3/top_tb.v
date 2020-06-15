//////////////////////////////////////////////////////////////////////////////////
// Test bench for Exercise #3 - Up/Down counter
// Student Name: Emily Widjaja
// Date: 15 Jun 2020
//
// Description: A testbench module to test Ex3 - counter
// Guidance: start with simple tests of the module (how should it react to each 
// control signal?). Don't try to test everything at once - validate one part of 
// the functionality at a time.
//////////////////////////////////////////////////////////////////////////////////
`timescale 1ns / 100ps

module top_tb(
    );
    
//Todo: Parameters
	parameter CLK_PERIOD = 10;

//Todo: Registers and wires
	reg clk;
	wire [7:0] count_now;
	reg [7:0] count_prev;
	reg rst;
	reg enable;
	reg dir;
	reg err;

//Todo: Clock generation
   //general clock
	initial
	 begin
	  clk = 1'b0;
	  forever
	   #(CLK_PERIOD/2) clk = ~clk;
	 end
  //clock for reset
	initial begin
	  rst = 1;
	  #(CLK_PERIOD) rst = 0;
	  //#(2*CLK_PERIOD) rst = 0;
	end
  //clock for enable
	//initial begin
	  //enable = 1;
	  //#(3*CLK_PERIOD) enable = 0;
          //#(CLK_PERIOD) enable = 1;
	  //#(10*CLK_PERIOD) enable = 0;
	//end
  //clock for direction
	initial begin
	  dir = 1;
	  #(3*CLK_PERIOD) dir = 0;
	  #(CLK_PERIOD) dir = 1;
	  #(5*CLK_PERIOD) dir = 0;
	  #(CLK_PERIOD) dir = 1;
	end
//Todo: User logic
    initial begin
	//define initial state. Starting counter for 0 and holding for length of enable. Dir should not matter
     count_prev = count_now;
     enable = 1;	

	//begin checking for correct behaviour
     forever begin
	#(CLK_PERIOD-6)

//Condition 1: rst = 1, counter = 0
	if (rst==1&&count_now!=0)
	begin
	 $display("***TEST FAILED! did not reset! previous counter=%d, current counter=%d, reset=%d ***",count_prev,count_now,rst);
           err=1;
	end

//Condition 2: en = 0, rst = 0, counter = count_prev
	if (rst!=1&&enable==0&&(count_now!=count_prev))
	begin
	 $display("***TEST FAILED! counter changes when en=0!previous counter=%d, current counter=%d, reset=%d, en=%d***",count_prev,count_now,rst,enable);
	 err=1;
	 end

//Condition 3&4: counts up when dir = 1 & counts down when dir = 0
	if (rst!=1&&enable!=0&&dir==1&&(count_prev!=count_now-1))
	 $display("***TEST FAILED! counter does not count up when dir=1! previous counter=%d, current counter=%d, reset=%d, en=%d, dir=%d***",count_prev,count_now,rst,enable,dir);
	 err=1;
	 end

	if (rst!=1&&enable!=0&&dir==0&&(count_prev!=count_now+1))
	 $display("***TEST FAILED! counter does not count down when dir=0! previous counter=%d, current counter=%d, reset=%d, en=%d, dir=%d***",count_prev,count_now,rst,enable,dir);
	 err=1;
	 end
	
//Todo: Finish test, check for success
    initial begin
	#200
	if (err==0)
	 $display("***TEST PASSED!***");
	$finish;
    end

//Todo: Instantiate counter module
 counter top (
  .clk (clk),
  .rst (rst),
  .enable (enable),
  .dir (dir),
  .counter_out (count_now)
  );

endmodule 
