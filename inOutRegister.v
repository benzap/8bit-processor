/*
 Written By: Benjamin Zaporzan
 
 The In / Out register used in providing the input and output
 to and from the actual processing unit
 
 WEinOut - write enable used in writing to OUT of the processing unit
 
 !!!these are not to be confused!!!
 dataIn - [7:0] used to write data to the OUT register
 dataOut - [7:0] used to read data from the IN register 
 !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
 
 IN - [7:0] used to store data within the processor
 OUT - [7:0] used to receive data from within the processor
 
 
 clk - the clock
 */


`ifndef INOUTREG_V
`define INOUTREG_V

module inOutRegister(WEinOut,
		     dataIn,
		     dataOut,
		     IN,OUT,
		     clk);

   input [7:0] IN, dataIn;
   input       WEinOut,clk;
   
   output reg [7:0] OUT;
   output [7:0] dataOut;

   
   assign dataOut = IN;
   always @(negedge clk) begin
      if (WEinOut)
	OUT = dataIn;
   end
endmodule // inOutRegister

`endif //INOUTREG_V