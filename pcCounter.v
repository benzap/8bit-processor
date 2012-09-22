/*
 Written By: Benjamin Zaporzan
 
 8bit register which changes input to output on
 the posedge of the clock
 
 in - [7:0] input to registry
 out - output 
 clk - clock used to determine change in registry
 reset - resets the registry to zero
 
 */
`ifndef PCCOUNTER_V
`define PCCOUNTER_V


module pcCounter(in,out,clk,reset);

   input [7:0] in;
   input       clk,reset;
   output reg [7:0] out;

   always @(posedge clk or posedge reset) begin
      if (reset)
	out = 0;
      else
	out = in;
   end
endmodule // pcCounter


`endif //PCCOUNTER_V