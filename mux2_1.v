/*
 Written By: Benjamin Zaporzan
 
 simple 2-1 muxer
 */


module mux2_1(in0,in1,out,select);

   input in0,in1,select;
   output out;

   assign out = (select) ? in1 : in0;
   
endmodule // mux2_1

