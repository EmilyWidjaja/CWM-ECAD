//////////////////////////////////////////////////////////////////////////////////
// Exercise #7
// Student Name: Emily Widjaja
// Date: 17 June 2020
//
//  Description: In this exercise, you need to implement a times table of 0..7x0..7
//  using a memory.
//
//  inputs:
//           clk, a[2:0], b[2:0], read
//
//  outputs:
//           result[5:0]
//////////////////////////////////////////////////////////////////////////////////

`timescale 1ns / 100ps

module multiplication(
	input clk,
	input [2:0] a,
	input [2:0] b,
	input read,
	output [5:0] result
  );

//add intermediate wires
	wire wea;
	wire [5:0] dina;

//add user logic
	assign dina = 6'b0;
	assign wea = 0;


//instantiating memory block
blk_mem_gen_0 mymem (
  .clka(clk),    // input wire clka
  .ena(read),      // input wire ena
  .wea(wea),      // input wire [0 : 0] wea
  .addra({a,b}),  // input wire [5 : 0] addra
  .dina(dina),    // input wire [5 : 0] dina
  .douta(result)  // output wire [5 : 0] douta
);

endmodule	
