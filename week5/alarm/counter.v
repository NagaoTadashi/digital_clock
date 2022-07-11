module counter ( CLK, RST, CE10, SETH, SETM, SCLR, TIME );
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

  counter100 c100 (.CLK(CLK),.RST(RST || SCLR),.CE(CE10),.UP(CEs), .CNT(uu));
  counter60  c60s (.CLK(CLK),.RST(RST || SCLR),.CE(CEs),.UP(CEm), .CNT(ss));
  counter60  c60M (.CLK(CLK),.RST(RST),.CE(CEm || (SETM && CEs)), .UP(CEh), .CNT(mm));
  counter24  c24  (.CLK(CLK),.RST(RST),.CE( CEh || (SETH && CEs)),.CNT(hh));

  assign TIME = { hh, mm, ss, uu };

endmodule
