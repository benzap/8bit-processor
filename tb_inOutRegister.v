//Test Bench

`include "inOutRegister.v"

module tb_inOutRegister();
   
   reg WEinOut;
   reg [7:0] IN,dataIn;
   wire [7:0] OUT, dataOut;

inOutRegister inoutreg(.WEinOut(WEinOut),
		       .dataIn(dataIn),
		       .dataOut(dataOut),
		       .IN(IN),
		       .OUT(OUT));
   
   initial begin
      $monitor("IN - %d  OUT - %d dataIn - %d dataOut - %d we - %d",
	       IN,OUT,dataIn,dataOut,WEinOut);
      IN = 0;
      dataIn = 0;
      WEinOut = 0;
      #100 WEinOut = 1;
      dataIn = 100;
      IN = 100;
      #100 WEinOut = 0;
      IN = 127;
      dataIn = 127;
      #100 $finish;
   end
endmodule