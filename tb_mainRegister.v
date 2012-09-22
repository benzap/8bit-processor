//Test Bench

`include "mainRegister.v"

module tb_mainRegister();

   reg [1:0] inputA;
   reg [1:0] inputB;
   reg [7:0] dataIn;
   wire [7:0] outputA, outputB;
   reg 	      clk,reset,regWrite;
   
   mainRegister MRegister(
			  .raAddress(inputA),
			  .rbAddress(inputB),
			  .regA(outputA),
			  .regB(outputB),
			  .regWrite(regWrite),
			  .dataIn(dataIn),
			  .reset(reset),
			  .clk(clk)
			  );
   
   always #100 clk=~clk;

   initial begin
      $display("Input A  Input B  Output A Output B  Data In     WE RST CLK");
      $monitor("%d       %d       %d       %d        %d      %d %d  %d",
	       inputA,   inputB,  outputA, outputB, dataIn, regWrite, reset, clk);
      clk=0;
      regWrite=1;
      inputA = 0;
      inputB = 1;
      reset=1;
      dataIn = 25;
      #100
      #100 reset=0;
      #100 dataIn = 100;
      inputA = 1;
      inputB = 0;
      #100
      #100 dataIn = 45;
      inputA = 2;
      inputB = 1;
      #200 regWrite = 0;
      dataIn = 99;
      #300 regWrite = 1;
      #100 inputA = 3;
      inputB = 0;
      #200 reset = 1;
      
      #100 $finish;
      
   end
   
   
endmodule // tb_mainRegister
