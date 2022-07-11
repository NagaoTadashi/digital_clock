module clock24 ( CLK, RSTN, SETH, SETM, SCLR, SETALM, SEGN, AN, LED, ALARM );
   input        CLK;  // Clock (100MHz)
   input        RSTN; // Reset (Low active)
   input        SETH; // Set hour (High active)
   input        SETM; // Set minute (High active)
   input        SCLR; // Clear sec and msec (high active)
   input        SETALM; // Enable alarm setting 	
 	output [7:0] SEGN; // segment for 7 segment LED (Low active)
   output [7:0] AN;   // Digit enable for 7 segment LED (Low active)
   output 	    LED;  // LED (High active)
   output 	    ALARM; // Alarm

   // internal wire
   wire        RST;  // Reset (High active)
   wire [31:0] TIME;  // hh:mm:ss:ms
   wire [3:0]  BCD;  // BCD value of TIME
   wire        CE1;  // Clock enable  1ms = 1,000Hz
   wire        CE10;  // Clock enable 10ms =   100Hz
   wire [7:0]  SEG;  // Segment data
   wire [7:0]  DIGIT;  // Digit position
   // additional wire
   wire [31:0] MOMTIME; // Current time
   wire [31:0] ALMTIME; // Alarm time
   wire        ALMSETH; // Set alarm hour
   wire        ALMSETM; // Set alarm minute
   wire        MOMSETH; // Set clock hour
   wire        MOMSETM; // Set clock minute          
   // additional assign
   assign TIME = (SETALM == 1'b0) ? MOMTIME : ALMTIME; // Display time
   assign MOMSETH = (SETALM == 1'b0) ? SETH : 1'b0; // Set clock hour signal
   assign MOMSETM = (SETALM == 1'b0) ? SETM : 1'b0; // Set clock minute signal
   assign ALMSETH = (SETALM == 1'b1) ? SETH : 1'b0; // Set alarm hour signal
   assign ALMSETM = (SETALM == 1'b1) ? SETM : 1'b0; // Set alarm minute signal
   
   assign RST = ~RSTN;  // Internal signals should be unified to positive signal
                      // in order to avoid errors
  
   timing    C0 ( .CLK(CLK), .RST(RST), .CE10(CE10), .CE1(CE1) );
   counter   C1 ( .CLK(CLK), .RST(RST), .CE10(CE10), .SETH(MOMSETH), .SETM(MOMSETM), .SCLR(SCLR), .TIME(MOMTIME) );
   // additional module
   setalarm  C2 ( .CLK(CLK), .RST(RST), .CE10(CE10), .SETH(ALMSETH), .SETM(ALMSETM), .SCLR(SCLR), .TIME(ALMTIME) );
   led_drv   C3 ( .CLK(CLK), .RST(RST), .CE(CE1), .TIME(TIME), .BCD(BCD),  .DIGIT(DIGIT) );
   seven_seg  C4 ( .BCD(BCD), .SEG(SEG) );
   
   // additional function
   function alarm;
      input    RST;
      input [31:0] MOMTIME;
      input [31:0] ALMTIME;
      if ( RST == 1'b1 )
		alarm = 1'b0; // Reset alarm out
      else if ( MOMTIME == ALMTIME ) // alarming!
		alarm = 1'b1;
      // else if ( MOMTIME == ALMTIME+16'h8000 ) // stop alarming after 30 sec
      else if ( MOMTIME == ALMTIME+16'd1 ) // stop alarming after 10 msec
		alarm = 1'b0;
   endfunction
   
   assign SEGN = ~SEG[7:0];      // negative signal
   assign AN   = ~DIGIT[7:0];    // negative signal
   assign ALARM = alarm(RST,MOMTIME,ALMTIME); // alarming signal
   assign LED  = TIME[8]; // You had better output one second pulse for observation

endmodule
