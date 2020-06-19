//////////////////////////////////////////////////////////////////////////////////
// Exercise #9 
// Student Name: Emily Widjaja
// Date: 19 June 2020
//
//  Description: In this exercise, you need to design a module that lights leds
//  at different frequencies
//
//  inputs:
//           rst_n, clk_n, clk_p, button
//
//  outputs:
//           led_0, led_1, led_2
//////////////////////////////////////////////////////////////////////////////////


module top(
    input clk_p,
    input clk_n,
     //Todo: add all other ports besides clk_n and clk_p 
    input rst_n,
    input button,
    output reg led_0,
    output reg led_1,
    output reg led_2
   );
    
	parameter PERIOD0=20000000;	//50Hz
	parameter PERIOD1=30000000;  //<50Hz
	parameter PERIOD2=40000000;  //<50Hz
	reg timer;

   /* clock infrastructure, do not modify */ //generates clock for use
        wire clk_ibufds;

    IBUFDS IBUFDS_sysclk (
	.I(clk_p),
	.IB(clk_n),
	.O(clk_ibufds)
);

     wire clk; //use this signal as a clock for your design
        
     BUFG bufg_clk (
	.I  (clk_ibufds),
	.O  (clk)
      );


//Add logic here
//led_0
	initial begin
	  timer<=0;
	end

	always @ (posedge clk) begin
	  if (button) begin
	    led_0<=1;
	    led_1<=1;
	    led_2<=1;
	    timer<=0;
	  end

	  if (rst_n) begin
	    led_0<=0;
	    led_1<=0;
	    led_2<=0;
	    timer<=0;
	  end

	  else begin
	    //led_0
	    if (timer == PERIOD0)
	      led_0<=1;
	    else
	      led_0<=0;

	    //led_1
	    if (timer == PERIOD1)
	      led_1<=1;
	    else
	      led_1<=0;

	    //led_2
	    if (timer == PERIOD0)
	      led_2<=1;
	    else
	      led_2<=0;
	    timer<=timer+10;
	  end //else

	end //always

endmodule
