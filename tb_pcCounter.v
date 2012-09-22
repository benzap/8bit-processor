//test bench
`include "pcCounter.v"


module tb_pcCounter();

   reg [7:0] in;
   reg 	     clk,rst;
   wire [7:0] out;
   
   
   pcCounter counter(.in(in),
		     .out(out),
		     .clk(clk),
		     .reset(rst));
   

   always #100 clk=~clk;

   initial begin
      $monitor("in=%d out=%d clk=%d rst=%d",in,out,clk,rst);
      clk = 0;
      rst = 1;
      in = 0;
      #200 in = 10;
      rst = 0;
      repeat(10)
	#100 in = in+2;
      #100 rst=1;
      #100 $finish;
   end
endmodule // tb_pcCounter

    