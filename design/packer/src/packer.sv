// Code your design here
// No data loss/ No padding

// Create a packer module which packs input data to a different size out_data;

module packing #(
parameter IN_WIDTH = 7,
parameter OUT_WIDTH = 9
)
  (
clk,
rst_n,
in_data,
in_valid,
out_data,
out_valid
);
  
input clk;
input rst_n;
input [6:0] in_data;
input in_valid;
output reg [8:0] out_data;
output reg out_valid;

localparam P_WIDTH = $clog2(IN_WIDTH+OUT_WIDTH);
localparam F_WIDTH = IN_WIDTH+OUT_WIDTH;
 
reg [IN_WIDTH+OUT_WIDTH-1:0] mem;
reg [P_WIDTH -1:0] ptr;
  
  
  wire [F_WIDTH-1:0] shifted_in_data;
  wire [F_WIDTH-1:0] ored_mem;
  
  assign shifted_in_data = in_data << ptr;
  assign ored_mem = shifted_in_data | mem;

 always @ ( posedge clk or negedge rst_n) begin
   if(!rst_n) begin
     mem <= 0;
     out_data <= 0;
     out_valid <= 0;
     ptr <= 0;
   end
   else begin
     if(in_valid) begin
       if(ptr + IN_WIDTH < OUT_WIDTH) begin
         mem <= ored_mem ;
         out_valid <= 0;
         ptr <= ptr +IN_WIDTH;
       
         
       end
       else begin
         out_data <= ored_mem & {OUT_WIDTH{1'b1}};
         out_valid <= 1;
         mem <= ored_mem >> OUT_WIDTH;
         ptr <= ptr+IN_WIDTH-OUT_WIDTH;
         
       end
       
     end
     
     else begin
        out_valid <= 0;
     end
       
     
   end
              
 end
              
  
endmodule
