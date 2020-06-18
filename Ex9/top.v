//////////////////////////////////////////////////////////////////////////////////
// Exercise #9 
// Student Name:
// Date: 
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
	always (@ posedge clk) begin

	  if (button) begin
	    led_0<=1;
	    led_1<=1;
	    led_2<=1;
	  end

	  if (rst_n) begin
	    led_0<=0;
	    led_1<=0;
	    led_2<=0;
	  end

	  else
	//blinking for led_0
	  #(frequency0/2) led_0<=1;
	  #(frequency0/2) led_0<=0;

	//blinking for led_1
	  #(frequency1/2) led_1<=1;
	  #(frequency1/2) led_1<=0;

	//blinking for led_2
	  #(frequency2/2) led_2<=1;
	  #(frequency2/2) led_2<=0;

	end

endmodule

endmodule
