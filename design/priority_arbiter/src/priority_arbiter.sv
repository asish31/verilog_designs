
// Code your design here


module priority_arbiter
  #(
    parameter NUM_INPUTS = 4
  )
  (clk, resetn, req, priv, grant, vld);
 	
  	input clk;
  	input resetn;
  	input [NUM_INPUTS-1:0] req;
  	input [NUM_INPUTS-1:0] priv;
  	output reg [NUM_INPUTS-1:0] grant;
  	output reg vld;

  
  localparam LOG_INPUT = $clog2(NUM_INPUTS);
  
  wire [2*NUM_INPUTS-1:0] double_req, double_grant;
  
  
  reg [NUM_INPUTS-1:0] last_grant, last_grant_shift, priv_req_v;
  reg priv_req;
  
  assign priv_req = |(priv & req);
  
  
  assign double_req = {req, req};
  
  always @ * begin
    last_grant_shift = 0;
    if(priv_req)
      last_grant_shift = priv;
    else begin
   	 for(int i=1;i<NUM_INPUTS;i++) begin
   	   last_grant_shift[i] = last_grant[i-1]; 
   	 end
   	 last_grant_shift[0] = last_grant[NUM_INPUTS-1];
    end
  end
  
  assign double_grant = double_req & ~(double_req - last_grant_shift);
  
  assign grant = double_grant[2*NUM_INPUTS-1:NUM_INPUTS] | double_grant[NUM_INPUTS-1:0] ;
  assign vld = |req;
  
  always @ (posedge clk or negedge resetn) begin
    if(!resetn) begin
      last_grant[NUM_INPUTS-1] <= 1;
      last_grant[NUM_INPUTS-2:0] <= 0;
    end
    else begin
      if(vld)
        last_grant <= grant;
      
      
    end
      
    
  end
  
endmodule
