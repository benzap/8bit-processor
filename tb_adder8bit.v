//test bench
`include "adder8bit.v"

module tb_adder8bit();

   reg [7:0] in0,in1;
   wire [7:0] out;

adder8bit adder(.in0(in0),
		.in1(in1),
		.out(out));

   initial begin
      $monitor("in0=%d in1=%d out=%d",in0,in1,out);
      in0=0;
      in1=0;
      #100 in0 = 10;
      #100 in1 = 25;
      #100 in0 = 75;
      #100 in0 = 128;
      in1 = 128;
      #100 $finish;
   end
endmodule