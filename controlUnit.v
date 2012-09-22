/* 
 Written By:  Benjamin Zaporzan
 
 The control unit is used to ensure the correct reads and writes and logic
 is preformed per an instruction call
 
 the controller controls the 2 to 1 muxers which determine which data is sent between
 data memory, the ALU and the register memory
 
 opIn - [4:0] obtains the last 5 bits of the instruction [15:11] 
              which contains the opCode and the BRX 
              used in the branch instructions
 
 opOut - [3:0] used to send to the ALU to specify it's functionality with respect
               to the instruction made
 
 cLines - [5:0] control lines
 regWrite - used to control regWrite
 memWrite - used to control memRead
 memRead - used to control memRead
 
 WEtemp - used to control temp reg write
 WEinOut - used to control IN/OUT write

 pcLine - used specifically for branch instructions
 */

`ifndef CONTROLUNIT_V
`define CONTROLUNIT_V

`include "controlSet.vh"
`include "instructionSet.vh"

module controlUnit(
		   opIn,
		   opOut,
		   cLines,
		   regWrite,
		   memWrite,
		   memRead,
		   WEtemp,
		   WEinOut,
		   pcLine);
   
   input [4:0] opIn;

   output reg [3:0] opOut;
   output reg [5:0] cLines;

   output reg	regWrite;
   output reg	memWrite;
   output reg	memRead;
   output reg	WEtemp;
   output reg	WEinOut;
   output reg	pcLine;
	

   always @(opIn) begin
      case (opIn[4:1])
	`ADD: begin
	   assign opOut = `ADD;
	   assign cLines = `ADD_C;
	   assign regWrite = 1;
	   assign memWrite = 0;
	   assign memRead = 0;
	   assign WEinOut = 0;
	   assign WEtemp = 0;
	   assign pcLine = 1;
	end
	
	`SUB: begin
	   assign opOut = `SUB;
	   assign cLines = `SUB_C;
	   assign regWrite = 1;
	   assign memWrite = 0;
	   assign memRead = 0;
	   assign WEinOut = 0;
	   assign WEtemp = 0;
	   assign pcLine = 1;
	end

	`NOOP: begin
	   assign opOut = `NOOP;
	   assign cLines = `NOOP_C;
	   assign regWrite = 0;
	   assign memWrite = 0;
	   assign memRead = 0;
	   assign WEinOut = 0;
	   assign WEtemp = 0;
	   assign pcLine = 1;
	end

	`NAND: begin
	   assign opOut = `NAND;
	   assign cLines = `NAND_C;
	   assign regWrite = 1;
	   assign memWrite = 0;
	   assign memRead = 0;
	   assign WEinOut = 0;
	   assign WEtemp = 0;
	   assign pcLine = 1;
	end

	`SHL: begin
	   assign opOut = `SHL;
	   assign cLines = `SHL_C;
	   assign regWrite = 1;
	   assign memWrite = 0;
	   assign memRead = 0;
	   assign WEinOut = 0;
	   assign WEtemp = 0;
	   assign pcLine = 1;
	end

	`SHR: begin
	   assign opOut = `SHR;
	   assign cLines = `SHR_C;
	   assign regWrite = 1;
	   assign memWrite = 0;
	   assign memRead = 0;
	   assign WEinOut = 0;
	   assign WEtemp = 0;
	   assign pcLine = 1;
	end

	`MOV: begin
	   assign opOut = `MOV;
	   assign cLines = `MOV_C;
	   assign regWrite = 1;
	   assign memWrite = 0;
	   assign memRead = 0;
	   assign WEinOut = 0;
	   assign WEtemp = 0;
	   assign pcLine = 1;
	end

	`OUT: begin
	   assign opOut = `NOOP;
	   assign cLines = `OUT_C;
	   assign regWrite = 0;
	   assign memWrite = 0;
	   assign memRead = 0;
	   assign WEinOut = 1;
	   assign WEtemp = 0;
	   assign pcLine = 1;
	end

	`IN: begin
	   assign opOut = `NOOP;
	   assign cLines = `IN_C;
	   assign regWrite = 1;
	   assign memWrite = 0;
	   assign memRead = 0;
	   assign WEinOut = 0;
	   assign WEtemp = 0;
	   assign pcLine = 1;
	end

	`BR: begin
	   assign opOut = `NOOP;
	   assign cLines = `BR_C;
	   assign regWrite = 0;
	   assign memWrite = 0;
	   assign memRead = 0;
	   assign WEinOut = 0;
	   assign WEtemp = 0;
	   assign pcLine = 1;
	end

	`BR_Z, `BR_N: begin
	   assign opOut = `NOOP;
	   
	   if (opIn[0]) //BR = 1
	     assign cLines = `BR_N_C;
	   else //BR = 0
	     assign cLines = `BR_Z_C;
	   
	   assign regWrite = 0;
	   assign memWrite = 0;
	   assign memRead = 0;
	   assign WEinOut = 0;
	   assign WEtemp = 0;
	   assign pcLine = 0;
	end // case: `BR_Z, `BR_N

	`BR_SUB: begin
	   assign opOut = `NOOP;
	   assign cLines = `BR_SUB_C;
	   assign regWrite = 0;
	   assign memWrite = 0;
	   assign memRead = 0;
	   assign WEinOut = 0;
	   assign WEtemp = 1;
	   assign pcLine = 1;
	end

	`RETURN: begin
	   assign opOut = `NOOP;
	   assign cLines = `RETURN_C;
	   assign regWrite = 0;
	   assign memWrite = 0;
	   assign memRead = 0;
	   assign WEinOut = 0;
	   assign WEtemp = 0;
	   assign pcLine = 1;
	end

	`LOAD: begin
	   assign opOut = `NOOP;
	   assign cLines = `LOAD_C;
	   assign regWrite = 1;
	   assign memWrite = 0;
	   assign memRead = 1;
	   assign WEinOut = 0;
	   assign WEtemp = 0;
	   assign pcLine = 1;
	end

	`STORE: begin
	   assign opOut = `NOOP;
	   assign cLines = `STORE_C;
	   assign regWrite = 0;
	   assign memWrite = 1;
	   assign memRead = 0;
	   assign WEinOut = 0;
	   assign WEtemp = 0;
	   assign pcLine = 1;
	end

	`LOADIMM: begin
	   assign opOut = `NOOP;
	   assign cLines = `LOADIMM_C;
	   assign regWrite = 1;
	   assign memWrite = 0;
	   assign memRead = 0;
	   assign WEinOut = 0;
	   assign WEtemp = 0;
	   assign pcLine = 1;
	end
	
      endcase
   end
   
endmodule // controlUnit


`endif //CONTROLUNIT_V

