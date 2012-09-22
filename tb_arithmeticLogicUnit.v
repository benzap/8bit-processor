//test bench

`include "instructionSet.vh"
`include "arithmeticLogicUnit.v"


module tb_arithmeticLogicUnit();
   
   reg [7:0] inA,inB;
   reg [3:0] opCode;
   wire [7:0] out;
   wire       zOutput, nOutput;

   arithmeticLogicUnit ALU(.inA(inA),
			   .inB(inB),
			   .opCode(opCode),
			   .out(out),
			   .zOutput(zOutput),
			   .nOutput(nOutput)
			   );

   initial begin
      $display("inA           inB           out         opCode zOutput nOutput");
      $monitor("%b(%d) %b(%d) %b(%d) %d       %d      %d",
	       inA,inA,inB,inB,out,out,opCode,zOutput,nOutput);
      inA = 0;
      inB = 0;
      opCode = 0;
      #100 opCode = `ADD;
      inA = 1;
      #1 inB = 2;
      #1 inA = 4;
      #1 inB = 4;
      #1 inA = 128;
      #1 inB = 128;
      #100 opCode = `SUB;
      #1 inA = 64;
      #1 inB = 64;
      #1 inA = 128;
      #1 inB = 32;
      #1 inA = 0;
      #1 inB = 1;
      #100 opCode = `NAND;
      #1 inA = 4'b1100;
      #1 inB = 4'b1100;
      #1 inB = 4'b1111;
      #1 inA = 4'b1111;
      #100 opCode = `SHL;
      #1 inA = 8'b1111_1111;
      #1 inA = 8'b0111_1111;
      #1 inB = 0;
      #100 opCode = `SHR;
      #1 inA = 8'b1111_1111;
      #1 inA = 8'b1111_1110;
   end

endmodule