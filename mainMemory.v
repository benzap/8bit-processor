/*
 Written By: Benjamin Zaporzan
 
 Main memory used to store information for later use within
 a program
 
 
 address - [7:0] used to specify which data bank to read or
                 write to.
 dataOut - [7:0] used to send information from the data bank
                 which is specified by address
 memRead - set high to allow dataOut to obtain the value of
           the data bank specified by address
 
 dataIn - [7:0] used to transfer data to the data bank specified by
                address
 memWrite - set high to allow dataIn to set new value within the 
            data bank specified by the address
 
 clk - the clock
 
 reset - resets all of the memory banks to zero
 */
`ifndef MAINMEM_V
`define MAINMEM_V


module mainMemory(address,
		  dataOut,
		  memRead,
		  dataIn,
		  memWrite,
		  clk,
		  reset);


   //inputs
   input [7:0] address, dataIn;
   input       memRead, memWrite,clk,reset;

   //outputs
   output [7:0] dataOut;

   //the memory
   reg [7:0] 	dataMemory [255:0];

   //for reset
   integer 	i=0;
   

   assign dataOut = dataMemory[address];

   always @(negedge clk) begin
      if (memWrite)
	dataMemory[address] = dataIn;
   end

   always @(reset) begin
      if (reset)
	for (i=0;i<256;i=i+1)
	  dataMemory[i] = 0;
   end
   
endmodule // mainMemory


`endif //MAINMEM_V