module ram (clk,write_EN,read_EN,write_address,write_data,read_address,read_data); 
    input  clk, write_EN, read_EN;
  input  [31:0] write_address,read_address;
  input [31:0] write_data ;
  output [31:0] read_data;
  reg [31:0] read_data;

    reg [31:0] mem [31:0];
     integer i;
  
   /*initial begin
        for (i = 0; i < 32; i = i + 1) begin
            mem[i] = 32'd0 + (2 * i);
        end
    end */
  
  
  
  initial begin
        for (i = 0; i < 32; i = i + 1) begin
            mem[i] = 32'd0 + (2 * i);
        end
    end
  
  

    always @(posedge clk) begin
        if (write_EN) begin
            mem[write_address] <= write_data;
        end
   
        if (read_EN) begin
            read_data <= mem[read_address];
        end
    end
  

  

endmodule
