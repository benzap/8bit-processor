/*
 Written By: Benjamin Zaporzan
 
 Muxer for 2 to 1 bytes with select
 in0 - [7:0] first input
 in1 - [7:0] second input
 select - selects between in0 (0) or in1 (1)
 out - [7:0] output
 */
`ifndef MUX__V
`define MUX__V


module mux2_1byte(in0,in1,out,select);
   //inputs
   input [0:7] in0;
   input [0:7] in1;
   input       select;

   //outputs
   output [0:7] out;


   //begin
   assign out = (select) ? in1 : in0;
   
endmodule // mux2_1byte


`endif //MUX__V