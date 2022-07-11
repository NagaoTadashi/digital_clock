module setalarm ( CLK, RST, CE10, SETH, SETM, SCLR, TIME );
   input         CLK;  // Clock
   input         RST;  // Reset
   input         CE10; // Clock enable 10ms
   input         SETH; // Set Hour
   input         SETM; // Set Minuite
   input         SCLR; // Clear second & millisecond counter
   output [31:0] TIME; // Time value

   wire       CEs; // 1s timing
   wire       CEm; // 1m timing
   wire       CEh; // 1h timing       
   wire [7:0] hh, mm, ss, uu; // Return time value from each counter

  counter100 c100 (.CLK(CLK),.RST(RST || SCRL),.CE(CE10),.UP(CEs), .CNT(uu));
  counter60  c60s (.CLK(CLK),.RST(RST || SCRL),.CE(CEs),.UP(CEm), .CNT(ss));
  // クロックイネーブルには下位桁からの桁上がりによるカウントアップはせず, SETH, SETMにより1秒ごとのカウントアップのみ時刻調節として入力
  counter60  c60M (.CLK(CLK),.RST(RST),.CE(SETM && CEs),.UP(CEh), .CNT(mm));
  counter24  c24  (.CLK(CLK),.RST(RST),.CE(SETH && CEs), .CNT(hh));
  // 10ミリ秒および秒の桁はアラーム設定時刻として設定しない
  assign TIME = { hh, mm, 16'h0000 };

endmodule
