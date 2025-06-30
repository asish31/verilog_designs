// Code your testbench here
// or browse Examples
module test;

  reg  clk, resetn; 
  reg [3:0] req;  // all available requesters
  
  reg [3:0] grant,priv_grant;
  reg [3:0] priv; // one_hot
  wire valid,priv_vld;
  
  // Instantiate device under test
  /*round_robin_arbiter u_arbiter(.clk(clk),
                    .resetn(resetn),
                    .req(req),
                    .grant(grant),
                    .vld(vld)
                   );
  */
  
  priority_arbiter u_priv_arb(
    				.clk(clk),
                    .resetn(resetn),
                    .req(req),
    				.priv(priv),
   				    .grant(priv_grant),
    				.vld(priv_vld)
 				 );
  
  
  initial begin
    // Dump waves
    $dumpfile("dump.vcd");
    $dumpvars(0, test);
	priv = 4'b0100;
    clk = 0;
    req = 0;
    $display("Initial req : %0h, grant: %0h",
      req, grant);
    resetn = 0;

    toggle_clk;
    toggle_clk;
    $display("req : %0h, grant: %0h",
      req, grant);
    resetn = 1;
    
    toggle_clk;
    req = 2;
    //
    $display("req : %0h, grant : %0h",
      req, grant);
	
    toggle_clk;
    req = 1;
    $display("req : %0h, grant: %0h",
      req, grant);
	
    toggle_clk;
    req = 4'hE;
    $display("req : %0h, grant: %0h",
      req, grant );
    
    toggle_clk;
    
    $display("req : %0h, grant : %0h",
      req, grant);
    toggle_clk;
    $display("req : %0h, grant : %0h",
      req, grant);
  end
  
  task toggle_clk;
    begin
      #10 clk = ~clk;
      #10 clk = ~clk;
    end
  endtask
  
endmodule
