//////////////////////////////////////////////////////////////////////////////////
// Test bench for Exercise #8 - Times Table using AXI interface
// Student Name: Emily Widjaja
// Date: 18 June 2020
//
// Description: A testbench module to test Ex8 - Times Table using AXI4-Lite
// You need to write the whole file
//////////////////////////////////////////////////////////////////////////////////

`timescale 1ns / 100ps

module top_tb(
	);

//Parameters
	parameter CLK_PERIOD=10;

//Registers and wires
	reg [2:0] a;
	reg [2:0] b;
	reg clk;
	wire [5:0] result;
	reg rst;
	reg err;
	reg read;

//Generate clocks
	//general clk & read clock
	initial begin
	  clk = 1'b1;
	  #1
	  forever begin
	   #(CLK_PERIOD/2) clk = ~clk;
	  end
	end
	
	initial begin
	  read = 1'b1;
	  forever
	  #(CLK_PERIOD/2) read = ~read;
	end
	//a input. For first test, will test for 7 times tables, so a will be constant and initialised in 'initialise'
	 
	  
	//b input. Counts up then resets to 0.
	initial begin
	  b = 3'b000;
	  #1
	  forever begin
	    #(CLK_PERIOD)
	    if (b<=3'b111)
	     b=b+3'b001;
	    else
	      b=3'b000;
	  end
	end
	
	//reset clock
	initial begin
	  rst = 1;
	  #(CLK_PERIOD) rst = 0;
	  #(10*CLK_PERIOD) rst = 1;
	  #CLK_PERIOD rst = 0;
	end

//user logic
	//initialise
	initial begin
	  err=0;
	  a = 3'b111; //tests 7 times tables
	  #1

	//forever, display a & b and result and check by eye if correct. If any undefined states, then failed. 
	  forever begin
	    #CLK_PERIOD
	    $display("***a=%d,b=%d,result=%d***",a,b,result);
	  
	    if ( (result==1'bX)||(result==1'bZ) ) begin
	      $display("***TEST FAILED! Result is undefined. a=%d,b=%d,result=%d***",a,b,result);
	      err=1;
	    end
	  end //forever
	end //initial

//Finish test, check for success
    initial begin
	#200
	if (err==0)
	 $display("***TEST PASSED!***");
	$finish;
    end

//instantiate module
multiplication top (
  .clk (clk),
  .a (a),
  .b (b),
  .read (read),
  .result (result)
  );


endmodule
