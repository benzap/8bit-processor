/*
 Written By: Benjamin Zaporzan
 
 instruction memory consisting of 256 bytes of storage, with
 each area in memory being a byte.
 
 instructionAddress - the address of the first segment of
                      the instruction in memory
 instructionOutput - consists of instructionAddress for bits
                     [15:8] and instructionAddress+1 for bits
                     [7:0]
 
 */
`ifndef INSTRUCTMEM_V
`define INSTRUCTMEM_V


module instructionMemory(instructionAddress,
			 instructionOutput);
   //Inputs and Outputs
   input [7:0] instructionAddress;
   output [15:0] instructionOutput;
   //Memory
   reg [7:0] 	instructionMemory [0:255];

   assign instructionOutput[15:8] = instructionMemory[instructionAddress];
   assign instructionOutput[7:0] = instructionMemory[instructionAddress+1];

   initial begin
      $readmemb("instructionMemory.list", instructionMemory);
   end
   
endmodule // instructionMemory


`endif //INSTRUCTMEM_V