module axi_top_tb;

 logic clk;
 logic rst;

 logic wr_en_i;
logic [31:0] wr_addr_i;
logic [31:0] wr_data_i;

logic rd_en_i;
logic [31:0] rd_addr_i;
logic [31:0] rd_data_o;

logic wr_en_o;
logic  [31:0] wr_addr_o;
logic[31:0] wr_data_o;

logic  rd_en_o;
logic  [31:0] rd_addr_o;
logic [31:0] rd_data_i;


top top_inst(

.clk(clk),
.rst(rst),
.wr_en_i(wr_en_i),
.wr_addr_i(wr_addr_i),
.wr_data_i(wr_data_i),
.rd_en_i(rd_en_i),
.rd_addr_i(rd_addr_i),
//.rd_data_i(rd_data_i),

/*.wr_en_o(wr_en_o),
.wr_addr_o(wr_addr_o),
.wr_data_o(wr_data_o),
.rd_en_o(rd_en_o),
  .rd_addr_o(rd_addr_o),*/
.rd_data_o(rd_data_o)

);

/*initial begin
$shm_open("wave.shm");
$shm_probe("ACTMF");
end */
  initial begin
     $dumpvars();
     $dumpfile("AXI.shm");

  end

always #5 clk=~clk;

initial begin
rst=0;
clk=0;
wr_en_i=1'b0;
wr_addr_i=32'd0;
wr_data_i=32'd0;

rd_en_i=1'b0;
rd_addr_i=32'd0;
rd_data_i=32'd0;

end
initial begin


#10;rst=0;
#10;rst=1;

///////WRITE :1
#50;
wr_en_i=1'b1; wr_addr_i=32'h00000018; wr_data_i=32'hAABBCCDD;

#10;wr_en_i=1'b0;

///////WRITE :2
#50;
wr_en_i=1'b1; wr_addr_i=32'h00000101; wr_data_i=32'h12345678;

#10;wr_en_i=1'b0;


///////READ :1
#50;
rd_en_i=1'b1;rd_addr_i = 32'd18 ; rd_data_i=32'hAABBCCDD;
 // read_data=32'hAABBCCDD;
 

#10;rd_en_i=1'b0;

///////READ :2
#50;
rd_en_i=1'b1; rd_addr_i = 32'd20;  rd_data_i=32'h12345678;

#10;rd_en_i=1'b0;




end

initial begin
#300 $finish; 
end
endmodule





