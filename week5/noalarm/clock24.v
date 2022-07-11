module clock24 ( CLK, RSTN, SETH, SETM, SCLR, SEGN, AN, LED );
   input        CLK;  // Clock (100MHz)
   input        RSTN; // Reset (Low active)
   input        SETH; // Set hour (High active)
   input        SETM; // Set minute (High active)
   input        SCLR; // Clear sec and msec (high active)
   output [7:0] SEGN; // segment for 7 segment LED (Low active)
   output [7:0] AN;   // Digit enable for 7 segment LED (Low active)
   output       LED;  // LED (High active)

   // internal wire
   wire         RST;  // Reset (High active)
   wire [31:0]  TIME;  // hh:mm:ss:ms
   wire [3:0]   BCD;  // BCD value of TIME
   wire         CE1;  // Clock enable  1ms = 1,000Hz
   wire         CE10;  // Clock enable 10ms =   100Hz
   wire [7:0]   SEG;  // Segment data
   wire [7:0]   DIGIT;  // Digit position
  
   assign RST = ~RSTN;  // Internal signals should be unified to positive signal
                      // in order to avoid errors
  
   timing    C0 ( .CLK(CLK), .RST(RST), .CE10(CE10), .CE1(CE1) );
   counter   C1 ( .CLK(CLK), .RST(RST), .CE10(CE10), .SETH(SETH), .SETM(SETM), .SCLR(SCLR), .TIME(TIME) );
   led_drv   C2 ( .CLK(CLK), .RST(RST), .CE(CE1), .TIME(TIME), .BCD(BCD),  .DIGIT(DIGIT) );
   seven_seg C3 ( .BCD(BCD), .SEG(SEG) );
  
   assign SEGN = ~SEG[7:0];      // negative signal
   assign AN   = ~DIGIT[7:0];      // negative signal
   assign LED  = TIME[8]; // You had better output one second pulse for observation
endmodule