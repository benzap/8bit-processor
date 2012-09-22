//Test Bench
`include "tempRegister.v"

module tb_tempRegister();
   
   reg [7:0] dataIn;
   wire [7:0] dataOut;
   reg       WEtemp, reset;

   tempRegister TR(.dataIn(dataIn),
		   .dataOut(dataOut),
		   .reset(reset),
		   .WEtemp(WEtemp));

   initial begin
      $monitor("dataIn=%d dataOut=%d reset=%d WEtemp=%d",dataIn,dataOut,reset,WEtemp);
      dataIn = 0;
      reset=1;
      #100 reset = 0;
      #100 dataIn = 100;
      #100 WEtemp = 1;
      #100 $finish;
      
   end
   
  
endmodule // tb_tempRegister

  