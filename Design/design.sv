`include "axi_top.sv"
`include "axi_master.sv"
`include "axi_slave.sv"
`include "ram.sv"


module top(
input wire clk,
input wire rst,
//INPUTS
input logic wr_en_i,
  input logic [31:0] wr_addr_i,
input logic [31:0] wr_data_i,

input logic rd_en_i,
input logic [31:0] rd_addr_i,
output reg[31:0] rd_data_o
  
 /* output logic wr_en_o,
  output logic [31:0] wr_addr_o,
  output logic [31:0] wr_data_o,
  
   output logic rd_en_o,
  output logic [31:0] rd_addr_o,
  input reg[31:0] rd_data_i*/  
  
);


logic wr_en_w;
  logic [31:0] wr_addr_w;
logic[31:0] wr_data_w;

logic rd_en_w;
  logic[31:0] rd_addr_w;
logic [31:0] rd_data_w;


//axi_top instantiation

axi_top axi_top_inst(
.clk(clk),
.rst(rst),

.wr_en_i(wr_en_i), 
.wr_addr_i(wr_addr_i),
.wr_data_i(wr_data_i),
.rd_en_i(rd_en_i),
.rd_addr_i(rd_addr_i),
.rd_data_o(rd_data_o),

.wr_en_o(wr_en_w),
.wr_addr_o(wr_addr_w),
.wr_data_o(wr_data_w),
.rd_en_o(rd_en_w),
.rd_addr_o(rd_addr_w),
.rd_data_i(rd_data_w)
);


//RAM instantiation

ram ram_inst(
.clk(clk),
.write_EN(wr_en_w),
.write_address(wr_addr_w),
.write_data(wr_data_w),

.read_EN(rd_en_w), 
.read_address(rd_addr_w),
.read_data(rd_data_w)
);

endmodule

/*initial begin
     $dumpvars();
     $dumpfile("AXI.shm");

  end */











