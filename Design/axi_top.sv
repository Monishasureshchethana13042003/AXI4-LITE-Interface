/////AXI TOP MODULE/////

module axi_top(

input wire clk,
input wire rst,

input logic wr_en_i,
input logic [31:0] wr_addr_i,
input logic [31:0] wr_data_i,

input logic rd_en_i,
input logic [31:0] rd_addr_i,
output reg[31:0] rd_data_o,

output reg wr_en_o,
output reg [31:0] wr_addr_o,
output reg[31:0] wr_data_o,

output  reg rd_en_o,
output  reg[31:0] rd_addr_o,
input logic [31:0] rd_data_i
);

wire AWvalid_w;
wire AWready_w;
wire [31:0] AWaddr_w;

wire Wvalid_w;
wire Wready_w;
wire [31:0] Wdata_w;
wire [3:0]Wstrb_w;

wire Bready_w;
wire [1:0] Bresp_w;
wire Bvalid_w;

wire ARvalid_w;
wire ARready_w;
wire [31:0] ARaddr_w;

wire Rvalid_w;
wire Rready_w;
wire [31:0] Rdata_w;
wire [1:0]Rresp_w;




 
  master master_inst(      ///// MASTER INSTANTIATION 
    .clk(clk),
    .rst(rst),

    .wr_en(wr_en_i),
    .wr_addr(wr_addr_i),
    .wr_data(wr_data_i),

    .rd_en(rd_en_i),
    .rd_addr(rd_addr_i),
    .rd_data(rd_data_o),  //// MASTER INSTANTIATION WRT AXI_TOP


////WRRITE ADDRESS
    .AWvalid(AWvalid_w),///master -> slave
    .AWready(AWready_w),
    .AWaddr(AWaddr_w),  ///master -> slave

////WRITE DATA
    .Wvalid(Wvalid_w), ///master-> slave
    .Wready(Wready_w),
    .Wdata(Wdata_w),
 //   .Wstrb(strb_w),

   
///// WRITE RESPONSE
    .Bready(Bready_w), //master->slave
    .Bvalid(Bvalid_w), //master<-slave
    .Bresp(Bresp_w),   //master<-slave

////READ ADDRESS
    .ARvalid(ARvalid_w),  //master->slave
    .ARready(ARready_w), //master<-slave
    .ARaddr(ARaddr_w),   //master->slave

////READ DATA
    .Rready(Rready_w),
    .Rvalid(Rvalid_w),
    .Rdata(Rdata_w),
    .Rresp(Rresp_w)
);

slave slave_inst(    //////SLAVE INSTANTIATION

    .clk(clk),
    .rst(rst),

  .wr_en(wr_en_o),       //slave->wire->memory
  .wr_addr(wr_addr_o),   //slave->wire->memory
  .wr_data(wr_data_o), //slave->wire->memory

    .rd_en(rd_en_o),
    .rd_addr(rd_addr_o),
    .rd_data(rd_data_i),



////WRITE ADDRESS
  .AWvalid(AWvalid_w),  ////from master to slave
    .AWready(AWready_w),
    .AWaddr(AWaddr_w),

////WRITE DATA
  .Wvalid(Wvalid_w), ////master-> slave
    .Wready(Wready_w),
  .Wdata(Wdata_w), ///master->slave
    .Wstrb(Wstrb_w),

////WRITE RESPONSE
    .Bready(Bready_w),
    .Bvalid(Bvalid_w),
    .Bresp(Bresp_w),

////READ ADDRESS
    .ARvalid(ARvalid_w),
    .ARready(ARready_w),
    .ARaddr(ARaddr_w),

////READ DATA
    .Rready(Rready_w),
    .Rvalid(Rvalid_w),
    .Rdata(Rdata_w),
    .Rresp(Rresp_w)
);


endmodule

