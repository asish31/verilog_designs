// Code your testbench here
// or browse Examples

module test;

reg [6:0] in_data;
wire [8:0] out_data;
reg in_valid;
wire out_valid;

reg clk, rst_n;

packing u_packing(
  .clk(clk),
  .rst_n(rst_n),
  .in_data(in_data),
  .in_valid(in_valid),
  .out_data(out_data),
  .out_valid(out_valid)
);


initial begin
   // Dump waves
    $dumpfile("dump.vcd");
  $dumpvars(0, test);

    clk = 0;
  	rst_n = 0;
  	in_valid = 0;
  //$disploy("initial out : %0b, out_valid : %0b", out_data, out_valid);
  
  	toggle_clk;
  	toggle_clk;
  	rst_n = 1;
  	
  toggle_clk;
  in_data = 7'b1000111;
  in_valid = 1;
  
  toggle_clk;
  in_valid = 0;
  toggle_clk;
  
  in_data = 7'b1010011;
  in_valid = 1;
  
  toggle_clk;
  in_data = 7'b1111000;
  in_valid = 1;
  
  toggle_clk;
  in_valid = 0;
  toggle_clk;
  toggle_clk;
  
  
end

task toggle_clk;
  begin
      #10 clk = ~clk;
      #10 clk = ~clk;
    end
endtask

  
endmodule
