/*
 Written By: Benjamin Zaporzan
 
 Performs all of the common arithmetic procedures between
 the two inputs presented (regA and regB)
 
 inA - [7:0] first input for the logic operation
 inB - [7:0] second input for the logic operation
 out - [7:0] resulting output on the ALU
 opCode - the opcode which determines which logical operation
          to perform on the inputs to provide an output
 zOutput - is set high primarily when the output is zero (with some exceptions)
 nOutput - is set high when the result is less than zero
 */
`ifndef ALU__V
`define ALU__V


`include "instructionSet.vh"

module arithmeticLogicUnit(inA,
			   inB,
			   out,
			   opCode,
			   zOutput,
			   nOutput);

   input [7:0] inA, inB;
   input [3:0] opCode;
   
   output reg [7:0] out;
   output reg	zOutput,nOutput;
   
   always @(opCode) begin
      case(opCode)
	`NOOP, `OUT, `IN, `MOV: begin
	   assign out = inB;
	   //assign zOutput = 0;
	   //assign nOutput = 0;
	end
	
	`ADD: begin
	   out <= inA + inB;
	   assign zOutput = (out == 0) ? 1 : 0;
	   assign nOutput = (out[7]) ? 1 : 0;
	end
	
	`SUB: begin
	   assign out = inA - inB;
	   assign zOutput = (out == 0) ? 1 : 0;
	   assign nOutput = (out[7]) ? 1 : 0;
	end
	
	`NAND: begin 
	   assign out = inA ~& inB;
	   assign zOutput = (out == 0) ? 1 : 0;
	   assign nOutput = (out[7]) ? 1 : 0;
	end
	
	`SHL: begin
	   assign out = inA << 1;
	   assign zOutput = inA[7];
	   assign nOutput = 0;
	end
	
	`SHR: begin
	   assign out = inA >> 1;
	   assign zOutput = inA[0];
	   assign nOutput = 0;
	end
      endcase // case (opCode)
   end
endmodule // arithmeticLogicUnit



`endif //ALU__V