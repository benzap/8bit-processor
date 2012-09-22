//testBench

`include "instructionMemory.v"

module tb_instructionMemory();

   reg [7:0]      IA;
   wire [15:0] 	  IO;
   
   
   instructionMemory IM(.instructionAddress(IA),
			.instructionOutput(IO));

   
   initial begin
      $monitor("IA=%d, output=%b",IA,IO);
      IA = 0;
      #100 IA = 1;
      #100 IA = 2;
      #100 IA = 3;
      #100 IA = 4;
      #100 IA = 200;
   end
   

endmodule