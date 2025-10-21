module slave(
input clk,
input rst,
/////WRITE///////

output reg wr_en,
output reg [31:0]wr_data, 
  output reg[31:0]wr_addr,
output reg[3:0]wr_strobe,

//WRITE ADDRESS CHANNEL [AW]
input  AWvalid,
  input [31:0]AWaddr,
output reg AWready,

//WRITE DATA CHANNEL [W]
input  Wvalid,
input [31:0]Wdata,
input [3:0]Wstrb,
output reg Wready,


//RESPONSE CHANNEL [B]
input Bready, 
output reg  Bvalid,
output reg [1:0]Bresp,


//////READ/////

output reg rd_en,
  output reg [31:0]rd_addr,
input [31:0]rd_data,

//READ ADDRESS CHANNEL [AR]
input ARvalid,
  input [31:0]ARaddr,
output reg ARready,


//READ DATA CHANNEL [R]
input Rready,
output reg Rvalid,
output reg [31:0]Rdata,
output reg [1:0]Rresp
);

//WRITE STATES
localparam IDLE_W=2'b00;
localparam WRITE_ADDRESS=2'b01; 
localparam WRITE_DATA=2'b10; 
localparam WRITE_RESPONSE=2'b11;

reg [1:0] Present_S_W;
reg[1:0] Next_S_W;

//READ STATES
localparam IDLE_R=2'b00;
localparam READ_ADDRESS=2'b01; 
localparam READ_DATA=2'b10; 

reg [1:0] Present_S_R;
reg[1:0] Next_S_R;
//NEXT_STATE (COMBINATIONAL)
always@(*)
begin

case(Present_S_W)
IDLE_W:      //IDLE STATE
begin
if (AWvalid==1)
Next_S_W=WRITE_ADDRESS;

else
Next_S_W=IDLE_W;

end

WRITE_ADDRESS:
begin    //WRITE_ADDRESS STATE

if(AWvalid && AWready)
Next_S_W=WRITE_DATA;

else
Next_S_W=WRITE_ADDRESS;

end

WRITE_DATA:
 begin      ///WRITE_DATA STATE

if (Wvalid && Wready)
Next_S_W=WRITE_RESPONSE;

else
Next_S_W=WRITE_DATA;

end

WRITE_RESPONSE:
begin      //WRITE_RESPONSE STATE

if(Bready && Bvalid)
Next_S_W=IDLE_W;

else
Next_S_W=WRITE_RESPONSE;

end

endcase

end

//PRSENT_STATE (SEQUENTIAL)
always@(posedge clk or negedge rst)
begin

if(!rst)
Present_S_W<=IDLE_W;
else
Present_S_W<=Next_S_W;

end

//output 
   
   
   always@(*)
     begin
AWready=1'b0;
wr_addr=32'd0;

Wready=1'b0;
wr_data=32'd0;
wr_en=1'b0;
Bvalid=1'b0;
Bresp=1'b0;

case(Present_S_W)
IDLE_W:
  begin
AWready=1'b0;
wr_addr=32'd0;

Wready=1'b0;
wr_data=32'd0;
wr_en=1'b0;

Bresp=1'b0;
  
  end
  
WRITE_ADDRESS:
  begin
AWready=1'b1;
wr_addr=AWaddr;
  end

WRITE_DATA:
  begin
Wready=1'b1;
wr_data=Wdata;
wr_en=1'b1;
end

WRITE_RESPONSE:
  begin

Bvalid=1'b1;
Bresp=1'b1;
  end 
endcase  
     end

/////READ////

//NEXT STATE
always@(*)
begin

case(Present_S_R)
IDLE_R:      //IDLE STATE
begin
if(ARvalid==1'b1)
Next_S_R=READ_ADDRESS;
else
Next_S_R=IDLE_R;
end

READ_ADDRESS:
begin    //WRITE_ADDRESS STATE
if(ARvalid && ARready)
Next_S_R=READ_DATA;
else
Next_S_R=READ_ADDRESS;
end

READ_DATA:
begin    //WRITE_ADDRESS STATE
if(Rvalid && Rready)
Next_S_R=IDLE_R;
else
Next_S_R=READ_DATA;
end

endcase
end

//PRESENT_STATE

always@(posedge clk or negedge rst)
begin

if(!rst)
Present_S_R<=IDLE_R;
else
Present_S_R<=Next_S_R;

end

//OUTPUT Rready (COMBINATIONAL)


always@(*)
begin
begin
ARready=1'b0;
rd_addr=32'd0;
rd_en=1'b0;

Rvalid=1'b0;
Rdata=32'd0;
Rresp=2'b10;
end
case(Present_S_R)

IDLE_R:
begin
ARready=1'b0;
rd_addr=32'd0;
rd_en=1'b0;

Rvalid=1'b0;
Rdata=32'd0;
Rresp=2'b10;
end

READ_ADDRESS:
begin
ARready=1'b1;
rd_addr=ARaddr;
rd_en=1'b1;
end

READ_DATA:
begin
Rdata=rd_data;
Rvalid=1'b1;
Rresp=2'b00;
end

endcase
end
endmodule









