//Test Bench

`include "mainMemory.v"

module tb_mainMemory();

   reg [7:0] address;
   reg [7:0] dataIn;
   reg 	     clk,reset,memRead,memWrite;
   wire [7:0] dataOut;


   mainMemory mainMem(.address(address),
		      .dataOut(dataOut),
		      .memRead(memRead),
		      .dataIn(dataIn),
		      .memWrite(memWrite),
		      .clk(clk),
		      .reset(reset)
		      );


   always #100 clk = ~clk;

   initial begin
      $display("Address    dataOut    memRead   dataIn   memWrite   clk   reset");
      $monitor("%d          %d           %d      %d         %d       %d    %d",
	       address,dataOut,memRead,dataIn,memWrite,clk,reset);
      memWrite = 0;
      memRead = 1;
      clk = 0;
      dataIn = 0;
      reset = 1;
      address = 0;
      #100 reset = 0;
      @(posedge clk) dataIn = 196;
      memWrite = 1;
      @(posedge clk)
      address = 1; 
      dataIn = 127;
      @(posedge clk) memWrite= 0;
      @(posedge clk) address = 0;
      @(posedge clk) address = 1;
      #100 reset = 1;
      #500 $finish;
   end
   
   
   
endmodule