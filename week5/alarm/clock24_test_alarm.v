`timescale 1ns/1ns  // Unit time 1ns, presision time 1ns
module clock24_test;
   reg        CLK, RSTN, SETH, SETM, SCLR, SETALM;
   wire [7:0] SEGN, AN;
   wire       LED, ALARM;

   initial
   begin
//      $monitorh ( $time, " ", dut.CE1, " ", dut.CE10, " ", dut.TIME," ", dut.ALMTIME, " ALARM:", ALARM, " dut.C0.cn1:", dut.C0.cn1, " dut.C1.cn2:", dut.C0.cn2 ); // for example
        $monitorh ( $time, " ", dut.CE1, " ", dut.CE10, " ", dut.TIME," ", dut.ALMTIME, " ALARM:", ALARM); // for example
   end

   clock24 dut ( .CLK(CLK), .RSTN(RSTN), .SETH(SETH), .SETM(SETM), .SCLR(SCLR), .SETALM(SETALM), .SEGN(SEGN), .AN(AN), .LED(LED), .ALARM(ALARM) );
   
   initial begin
      CLK = 0;
      while( 1 )
	CLK = # 5 ~CLK;
   end

   initial begin
      SETH = 0;
      SETM = 0;
      SCLR = 0;
      SETALM = 0;
      RSTN = 1;
      RSTN = #15 0;
      RSTN = #20 1;
      SETALM = 1;
      SETM = 1;
      SETM = #(100000+100) 0;
      SETALM = 0;
      #(59*100000+1000) $finish;
   end
      
endmodule

