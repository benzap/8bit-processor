/*
 Written By: Benjamin Zaporzan
 
 Main register holding the 4 8bit values for use in 
 processing instructions
 
 raAddress - [7:0] address for first register
 rbAddress - [7:0] address for second register
 
 regA - [7:0] output for RaAddress
 regB - [7:0] output got RbAddress
 
 regWrite - used to enable writing to Register specified
            by RaAddress with the data provided by DataIn
 dataIn - [7:0] data which is written to Register defined
          by RaAddress
 
 reset - resets each of the registers to 0
 
 clk - the clock
 */

`ifndef MAINREGISTER__V
`define MAINREGISTER__V

module mainRegister(raAddress, rbAddress,
		    regA, regB, regWrite,
		    dataIn, reset, clk);

   //inputs
   input [1:0] raAddress, rbAddress;
   input [7:0] dataIn;
   input       regWrite, reset, clk;

   //outputs
   output [7:0] regA, regB;

   //register memory
   reg [7:0] 	registerMemory [3:0];

   assign regA = registerMemory[raAddress];
   assign regB = registerMemory[rbAddress];
   
   always @(negedge clk) begin
      if (regWrite)
	registerMemory[raAddress] = dataIn;
   end

   always @(reset) begin
      if (reset) begin
	 registerMemory[0] = 0;
	 registerMemory[1] = 0;
	 registerMemory[2] = 0;
	 registerMemory[3] = 0;
      end
   end

endmodule // mainRegister

`endif //MAINREGISTER__V