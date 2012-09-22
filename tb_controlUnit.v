//test bench

`include "controlUnit.v"

module tb_controlUnit();
   
   reg [4:0] opIn;
   wire [3:0] opOut;
   wire [5:0] cLines;

   wire       regWrite,memWrite,memRead,WEtemp,WEinOut,pcLine;

   controlUnit CU(.opIn(opIn),
		  .opOut(opOut),
		  .cLines(cLines),
		  .regWrite(regWrite),
		  .memWrite(memWrite),
		  .memRead(memRead),
		  .WEtemp(WEtemp),
		  .WEinOut(WEinOut),
		  .pcLine(pcLine));

   initial begin
      $display("opIn   opOut   cLines   regWrite memWrite memRead WEtemp WEinOut pcLines");
      $monitor("%b  %b    %b       %b        %b       %b      %b      %b      %b",
	       opIn,opOut,cLines,regWrite,memWrite,memRead,WEtemp,WEinOut,pcLine);
      opIn = 0;
      $display("No Operation");
      
      #100 opIn[4:1] = `ADD;
      $display("Add");
      
      #100 opIn[4:1] = `LOAD;
      $display("Load");
      
      #100 opIn[4:1] = `STORE;
      $display("Store");
      
      #100 opIn[4:1] = `BR;
      $display("Branch");
      
      #100 opIn[4:1] = `IN;
      $display("In");
      
      #100 opIn[4:1] = `OUT;
      $display("Out");
      
      #100 opIn[4:1] = `LOADIMM;
      $display("Load Immediate");

      #100 opIn[4:1] = `BR_Z;
      $display("Branch on Zero");

      #100 opIn[4:1] = `BR_N;
      opIn[0] = 1;
      $display("Branch on less than zero");
      #100 $finish;
      
   end
   
   
   
endmodule