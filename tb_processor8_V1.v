//test bench

`include "processor8_V1.v"

module tb_processor();

   reg [7:0] IN;
   reg 	     clk,reset;
   wire [7:0] OUT;

   processor pc(.IN(IN),
		.OUT(OUT),
		.clk(clk),
		.reset(reset));

   always #100 clk = ~clk;
   
   initial begin
      $display("inst_Add   instruction      dataIn regA   regB  memAddress   controlLines clk reset PC  nextInstruct memDout Z  N    IN  OUT");
      $monitor(" %d       %b  %d   %d  %d        %b           %b       %b   %b    %b   %d        %d      %d  %d   %d   %d",
	       pc.instructionInputWire,pc.instructionOutputWire,pc.registerDataIn,pc.registerAoutput,pc.registerBoutput,0,pc.controlLine,clk,reset,pc.pcounterLine,
	       pc.nextProgramCounter, pc.mainMemDataOut, pc.ALU.zOutput, pc.ALU.nOutput, IN, OUT);
      clk = 0;
      reset = 1;
      #200 IN = 0;
      reset = 0;
      #14000 
	$display("Register 0 : %b",pc.MR.registerMemory[0]);
      $display("Register 1 : %b",pc.MR.registerMemory[1]);
      $display("Register 2 : %b",pc.MR.registerMemory[2]);
      $display("Register 3 : %b",pc.MR.registerMemory[3]);
	$finish;
      
   end
   
   

   
endmodule