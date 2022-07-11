module led_drv ( CLK, RST, CE, TIME, BCD, DIGIT );
   input          CLK;
   input          RST;
   input          CE;
   input  [31:0] TIME;
   output [3:0] BCD;
   output [7:0] DIGIT;

   reg    [3:0] BCD;
   reg    [7:0] DIGIT;
   reg    [2:0] cnt;

   always @( posedge CLK or posedge RST )
     if( RST == 1'b1 ) cnt <= 3'b000; else
     if( CE == 1'b1 ) cnt <= (cnt == 3'b111)?3'b000:cnt + 3'b001;
    
   always @( cnt )
     case( cnt )
       3'b000 : DIGIT <= 8'b00000001;
       3'b001 : DIGIT <= 8'b00000010;
       3'b010 : DIGIT <= 8'b00000100;
       3'b011 : DIGIT <= 8'b00001000;
       3'b100 : DIGIT <= 8'b00010000;
       3'b101 : DIGIT <= 8'b00100000;
       3'b110 : DIGIT <= 8'b01000000;
       3'b111 : DIGIT <= 8'b10000000;
       default: DIGIT <= 8'bXXXXXXXX;
     endcase

   always @( TIME or cnt )
     case( cnt )
       3'b000  : BCD <= TIME[3:0];
       3'b001  : BCD <= TIME[7:4];
       3'b010  : BCD <= TIME[11:8];
       3'b011  : BCD <= TIME[15:12];
       3'b100  : BCD <= TIME[19:16];
       3'b101  : BCD <= TIME[23:20];
       3'b110  : BCD <= TIME[27:23];
       3'b111  : BCD <= TIME[31:28];
       default : BCD <= 4'bXXXX;
     endcase

endmodule