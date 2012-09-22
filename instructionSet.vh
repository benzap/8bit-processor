/*
 The entire instruction set to be included in the
 Processor
 */
`ifndef INSTRUCT_SET_VH
`define INSTRUCT_SET_VH

//**Logical instructions
`define NOOP 4'b0000
`define ADD 4'b0001
`define SUB 4'b0010
`define NAND 4'b0011
`define SHL 4'b0100
`define SHR 4'b0101
`define OUT 4'b0110
`define IN 4'b0111
`define MOV 4'b1000
//NOOP will be used for instructions which do not correspond
//to a logic instruction


//**Branch instructions
`define BR 4'b1001
`define BR_Z 4'b1010 //BR = 0
`define BR_N 4'b1010 //BR = 1
`define BR_SUB 4'b1011
`define RETURN 4'b1100

//**Load/Store instructions
`define LOAD 4'b1101
`define STORE 4'b1110
`define LOADIMM 4'b1111



`endif //INSTRUCT_SET_VH