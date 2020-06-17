//////////////////////////////////////////////////////////////////////////////////
// Exercise #6 
// Student Name: Emily Widjaja
// Date: 16 June 2020
//
//
//  Description: In this exercise, you need to design a multiplexer between a dice and traffic 
//  lights, where the output acts according to the following truth table:
//
//  sel | out
// -----------------
//   0  | dice
//   1  | traffic lights
//
//  inputs:
//           rst, clk, button,sel
//
//  outputs:
//           result[2:0]
//
//////////////////////////////////////////////////////////////////////////////////

`timescale 1ns / 100ps

module DiceOrTraffic(
	input rst,
	input clk,
	input button,
	input sel,
	output [2:0] result 
  );

  //add intermediate wires
	wire [2:0] throw;
	wire red;
	wire amber;
	wire green;
	wire [2:0] traffic_lights;

  //add user logic
	//call Dice
  dice dice_out(
    .clk (clk),
    .rst (rst),
    .button (button),
    .throw (throw[2:0])
    );

	//call traffic
  traffic traffic_out (
     .clk (clk),
     .red (red),
     .amber (amber),
     .green (green)
     );

  assign traffic_lights[0] = red;
  assign traffic_lights[1] = amber;
  assign traffic_lights[2] = green;

	//call multiplexer
  mux multiplexer (
    .a (throw[2:0]),
    .b (traffic_lights[2:0]),
    .sel (sel),
    .out (result[2:0])
    );

endmodule


