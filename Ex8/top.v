//////////////////////////////////////////////////////////////////////////////////
// Exercise #8
// Student Name: Emily Widjaja
// Date: 18 June 2020
//
//  Description: In this exercise, you need to implement a times table of 0..7x0..7
//  using a memory and AXI-4-lite interface.
//
//  inputs:
//           clk, rst, a[2:0], b[2:0], read
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
	input rst,
	output [5:0] result
  );

//add intermediate wires
	wire [31:0] address;
	wire s_axi_aw_ready;
	wire s_axi_wready;
	wire s_axi_bvalid;
	wire s_axi_bresp;
	wire s_axi_arready;
	wire rsta_busy;
	wire rstb_busy;
	wire [31:0] s_axi_ardata;

//add user logic
	//convert addresses
	assign address = {24'b0,a,b,2'b00};
	//assign result = s_axi_ardata[5:0];

//instantiate memory block
mymem mymemory (
  .rsta_busy(rsta_busy),          // output wire rsta_busy
  .rstb_busy(rstb_busy),          // output wire rstb_busy
  .s_aclk(clk),                // input wire s_aclk
  .s_aresetn(rst),          // input wire s_aresetn
  .s_axi_awaddr(0),    // input wire [31 : 0] s_axi_awaddr	/not sure
  .s_axi_awvalid(0),  // input wire s_axi_awvalid
  .s_axi_awready(s_axi_awready),  // output wire s_axi_awready/
  .s_axi_wdata(0),      // input wire [31 : 0] s_axi_wdata
  .s_axi_wstrb(0),      // input wire [3 : 0] s_axi_wstrb
  .s_axi_wvalid(0),    // input wire s_axi_wvalid	/cannot write?
  .s_axi_wready(s_axi_wready),    // output wire s_axi_wready/
  .s_axi_bresp(s_axi_bresp),      // output wire [1 : 0] s_axi_bresp/
  .s_axi_bvalid(s_axi_bvalid),    // output wire s_axi_bvalid/
  .s_axi_bready(0),    // input wire s_axi_bready
  .s_axi_araddr(address),    // input wire [31 : 0] s_axi_araddr
  .s_axi_arvalid(read),  // input wire s_axi_arvalid
  .s_axi_arready(s_axi_arready),  // output wire s_axi_arready
  .s_axi_rdata(result),      // output wire [31 : 0] s_axi_rdata/
  .s_axi_rresp(s_axi_rresp),      // output wire [1 : 0] s_axi_rresp
  .s_axi_rvalid(s_axi_rvalid),    // output wire s_axi_rvalid
  .s_axi_rready(read)    // input wire s_axi_rready
);

endmodule
