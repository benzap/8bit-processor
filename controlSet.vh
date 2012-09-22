/*
 Written By: Benjamin Zaporzam
 controlSet
 
 used to setup the control lines (cLines) with respect
 to the instruction being called

*/
`ifndef CONTROL_VH
`define CONTROL_VH


//All the same
`define ADD_C 6'b001_100
`define SUB_C 6'b001_100
`define NAND_C 6'b001_100
`define SHL_C 6'b001_100
`define SHR_C 6'b001_100
`define MOV_C 6'b001_100
`define NOOP_C 6'b001_100

`define OUT_C 6'b000_1x0
`define IN_C 6'b001_110

`define BR_C 6'b000_101
`define BR_Z_C 6'b100_101
`define BR_N_C 6'b000_101
`define BR_SUB_C 6'b000_101
`define RETURN_C 6'b000_000

`define LOAD_C 6'b011_100
`define STORE_C 6'b000_100
`define LOADIMM_C 6'b000_100


`endif //CONTROL_VH