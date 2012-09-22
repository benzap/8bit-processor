/*
 Written By: Benjamin Zaporzan
 
 8bit adder with two inputs
 
 in0 - [7:0] first input
 in1 - [7:0] second input
 out - output 
 */

`ifndef ADDER8_V
`define ADDER8_V


module adder8bit(in0,in1,out);
   
   input [7:0] in0,in1;
   output [7:0] out;
   assign out = in0 + in1;
   
endmodule // adder8bit


`endif //ADDER8_V