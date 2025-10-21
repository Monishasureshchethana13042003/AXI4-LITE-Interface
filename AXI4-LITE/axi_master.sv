module master(
input clk,
input rst,
/////WRITE///////

input wr_en,
input [31:0]wr_data, 
  input [31:0]wr_addr,
input [3:0]wr_strobe,

//WRITE ADDRESS CHANNEL [AW]
output reg AWvalid,
input AWready,
  output reg[31:0]AWaddr,

//WRITE DATA CHANNEL [W]
output  reg Wvalid,
input Wready,
output reg [31:0]Wdata,
output reg [3:0]Wstrb,

//RESPONSE CHANNEL [B]
output reg Bready, 
input Bvalid,
input [1:0]Bresp,


//////READ/////

input rd_en,
  input [31:0]rd_addr,
output reg [31:0]rd_data,

//READ ADDRESS CHANNEL [AR]
output reg ARvalid,
input ARready,
  output reg [31:0]ARaddr,

//READ DATA CHANNEL [R]
output reg Rready,
input Rvalid,
input [31:0]Rdata,
input [1:0]Rresp
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

/////MASTER WRITE///////

//NEXT_STATE (COMBINATIONAL)
always@(*)
begin

case(Present_S_W)
IDLE_W:      //IDLE STATE
begin
if (wr_en==1)
Next_S_W=WRITE_ADDRESS;

else
Next_S_W=IDLE_W;

end

WRITE_ADDRESS:
begin    //WRITE_ADDRESS STATE

if(AWready==1)
Next_S_W=WRITE_DATA;

else
Next_S_W=WRITE_ADDRESS;

end

WRITE_DATA:
 begin      ///WRITE_DATA STATE

if (Wready==1)
Next_S_W=WRITE_RESPONSE;

else
Next_S_W=WRITE_DATA;

end

WRITE_RESPONSE:
begin      //WRITE_RESPONSE STATE

if(Bvalid==1)
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
 AWvalid=1'b0;
AWaddr=32'd0;
Wvalid=1'b0;
Wdata=32'd0;
Wstrb=4'd0;
Bready=1'b0; 

case(Present_S_W)
IDLE_W:
  begin
 AWvalid=1'b0;
AWaddr=32'd0;
Wvalid=1'b0;
Wdata=32'd0;
Wstrb=4'd0;
Bready=1'b0;      
  end
  
WRITE_ADDRESS:
  begin
AWvalid=1'b1;
AWaddr=wr_addr;
  end
  
WRITE_DATA:
  begin
Wvalid=1'b1;
Wdata=wr_data;
  end
    
WRITE_RESPONSE:
  begin
Bready=1'b1;
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
if(rd_en==1)
Next_S_R=READ_ADDRESS;

else
Next_S_R=IDLE_R;

end

READ_ADDRESS:
begin    //WRITE_ADDRESS STATE

if(ARready==1)
Next_S_R=READ_DATA;

else
Next_S_R=READ_ADDRESS;

end

READ_DATA:
begin    //WRITE_ADDRESS STATE

if(Rvalid==1)
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
ARvalid=1'b0;
ARaddr=32'd0;
rd_data=32'd0;
Rready=1'b0;

case(Present_S_R)

IDLE_R:
begin
ARvalid=1'b0;
ARaddr=32'd0;
rd_data=32'd0;
Rready=1'b0;
end

READ_ADDRESS:
begin
ARvalid=1'b1;
ARaddr=rd_addr;
end

READ_DATA:
begin
Rready=1'b1;
rd_data=Rdata;
end

endcase
end

endmodule





