`timescale 1ns/1ns  // Unit time 1ns, presision time 1ns
module clock24_test;
   reg        CLK, RSTN, SETH, SETM, SCLR;
   wire [7:0] SEGN, AN;
   wire       LED;

   initial
   begin
	  $monitorh( $time, " ", dut.CE1, " ", dut.CE10, " ", dut.TIME);
   end
   
   clock24 dut ( .CLK(CLK), .RSTN(RSTN), .SETH(SETH), .SETM(SETM), .SCLR(SCLR), 
		 .SEGN(SEGN), .AN(AN), .LED(LED) );
   
   initial begin
      CLK = 0;
      while( 1 )
	CLK = # 5 ~CLK;
   end

   initial begin
      SETH = 0;
      SETM = 0;
      SCLR = 0;
      RSTN = 1;
      RSTN = #15 0;
      RSTN = #20 1;
   end
      
endmodule

