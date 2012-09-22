//test bench

`include "mux2_1byte.v"

module tb_mux2_1byte();
   
   reg [0:7] in0;
   reg [0:7] in1;
   wire [0:7] out;
   reg  select;
   
   mux2_1byte mux(
		  .in0(in0),
		  .in1(in1),
		  .out(out),
		  .select(select));

   initial begin
      $monitor("in0=%b in1=%b out=%b select=%b",in0,in1,out,select);
      in0 = 8'b0000_0000;
      in1 = 8'b1111_1111;
      select = 0;
      #100 select=1;
      #100 select=0;
      $finish;
   end

   

   
endmodule // tb_mux2_1byte
