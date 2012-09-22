/*
 Written By: Benjamin Zaporzan
 
 Temporary Register used for storing the return address
 for a subroutine. Write enable allows the current address to be
 written into the registry
 
 dataIn - [7:0] address input which comes from pc+2
 dataOut - [7:0] address output which is the address current being held in the registry
 WEtemp - Write Enable for the temporary register
 reset - resets the register to zero
 */
`ifndef TEMPREG__V
`define TEMPREG__V

module tempRegister(dataIn,dataOut,WEtemp,reset);

   input [7:0] dataIn;
   output reg [7:0] dataOut;
   input 	WEtemp,reset;
  
   always @(WEtemp or reset) begin
      if (WEtemp)
	dataOut = dataIn;
      else if (reset)
	dataOut = 0;
   end
endmodule // tempRegister

`endif //TEMPREG__V