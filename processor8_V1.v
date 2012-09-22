/*
 Written By: Benjamin Zaporzan
 8-bit processor which incorporates the other 10 modules
 IN - [7:0] input to the processor which is used with an IN
 instruction call
 
 OUT - [7:0] output from the processor which is used with the
 OUT instruction call
 
 clk - the clock
 
 reset - resets the processor
 */

/***************************************
 ***************INCLUDES****************
 ***************************************/
`include "adder8bit.v"
`include "arithmeticLogicUnit.v"
`include "controlUnit.v"
`include "inOutRegister.v"
`include "mainMemory.v"
`include "mainRegister.v"
`include "mux2_1byte.v"
`include "pcCounter.v"
`include "tempRegister.v"
`include "instructionMemory.v"
`include "mux2_1.v"

`include "instructionSet.vh"
`include "controlSet.vh"
/**************************************/



module processor(IN,OUT,clk,reset);
   
   //instruction memory
   //NOTE: instructionMemory.list includes
   //      the instructions
   input [7:0] IN;
   input       clk,reset;
   output [7:0] OUT;
   
   
   wire [7:0] 	instructionInputWire;
   wire [15:0] 	instructionOutputWire;
   
   instructionMemory IM(.instructionAddress(instructionInputWire),
			.instructionOutput(instructionOutputWire));
   
   //Program Counter
   wire [7:0] 	pcCounterInput;
   pcCounter PC(.in(pcCounterInput),
		.out(instructionInputWire),
		.clk(clk),
		.reset(reset));
   
   //adder for next instructon
   wire [7:0] 	nextProgramCounter;
   adder8bit adderPlus2(.in0(8'b0000_0010),
			.in1(instructionInputWire),
			.out(nextProgramCounter));
   
   //Register Memory
   wire [7:0] 	registerAoutput;
   wire [7:0] 	registerBoutput;
   
   wire 	regWriteLine;
   wire [7:0] 	registerDataIn;
   mainRegister MR(.raAddress(instructionOutputWire[11:10]),
		   .rbAddress(instructionOutputWire[9:8]),
		   .regA(registerAoutput),
		   .regB(registerBoutput),
		   .regWrite(regWriteLine),
		   .dataIn(registerDataIn),
		   .reset(reset),
		   .clk(clk));

   //Arithmetic Logic Unit
   wire [7:0] 	aluOutput;
   wire [3:0] 	aluOperationLine;
   wire 	aluZLine;
   wire 	aluNLine;




   arithmeticLogicUnit ALU(.inA(registerAoutput),
			   .inB(registerBoutput),
			   .out(aluOutput),
			   .opCode(aluOperationLine),
			   .zOutput(aluZLine),
			   .nOutput(aluNLine)
			   );



   //Data Memory
   wire [7:0] 	mainMemDataOut;
   wire 	memWriteLine;
   wire 	memReadLine;

   mainMemory MM(.address(instructionOutputWire[7:0]),
		 .dataOut(mainMemDataOut),
		 .memRead(memReadLine),
		 .dataIn(registerAoutput),
		 .memWrite(memWriteLine),
		 .clk(clk),
		 .reset(reset));

   //Input and Output Registers
   wire [7:0] 	inOutDataOutLine;
   wire 	WEinOutLine;

   inOutRegister IO_R(.WEinOut(WEinOutLine),
		      .dataIn(registerAoutput),
		      .dataOut(inOutDataOutLine),
		      .IN(IN),
		      .OUT(OUT),
		      .clk(clk));


//Temp Registers
   wire [7:0] 	tempDataOutLine;
   wire 	WEtempLine;

tempRegister TR(.dataIn(nextProgramCounter),
		.dataOut(tempDataOutLine),
		.WEtemp(WEtempLine),
		.reset(reset));

//Control Unit
wire [0:5] 	controlLine;
wire 	pcounterLine;


controlUnit CU(.opIn(instructionOutputWire[15:11]),
	       .opOut(aluOperationLine),
	       .cLines(controlLine),
	       .regWrite(regWriteLine),
	       .memWrite(memWriteLine),
	       .memRead(memReadLine),
	       .WEtemp(WEtempLine),
	       .WEinOut(WEinOutLine),
	       .pcLine(pcounterLine));

//Mux lines for control unit
//control line 1
wire 	c1Output;
mux2_1 c1(.in0(aluNLine),
	  .in1(aluZLine),
	  .out(c1Output),
	  .select(controlLine[0]));

//or connecting c1 to c6 with pc select
wire c6Input;
or theOneOrToRuleThemAll(c6Input,pcounterLine,c1Output);

//control line 6
wire        c6Output;
nand theOneNandToRuleThemAll(c6Output,c6Input,controlLine[5]);

//control line for branch muxer
wire [7:0]  c4Input;
mux2_1byte branchMux(.in1(nextProgramCounter),
		     .in0(instructionOutputWire[7:0]),
		     .select(c6Output),
		     .out(c4Input));

//control line 4
mux2_1byte c4(.in0(tempDataOutLine),
	      .in1(c4Input),
	      .out(pcCounterInput),
	      .select(controlLine[3]));

//control line 3
wire [7:0]  c3Input;
mux2_1byte c3(.in0(instructionOutputWire[7:0]),
	      .in1(c3Input),
	      .out(registerDataIn),
	      .select(controlLine[2]));

//control line 5
wire [7:0]  c5Input;
mux2_1byte c5(.in1(inOutDataOutLine),
	      .in0(c5Input),
	      .out(c3Input),
	      .select(controlLine[4]));

//cnotrol line 2
mux2_1byte c2(.in1(mainMemDataOut),
	      .in0(aluOutput),
	      .out(c5Input),
	      .select(controlLine[1]));   

endmodule // processor

