module timing ( CLK, RST, CE10, CE1 );
   input  CLK;  // Clock
   input  RST;  // Reset
   output CE10; // Clock enable 10ms (100Hz)
   output CE1;  // Clock enable  1ms (1kHz)

   reg [16:0] cnt1;
   reg [3:0] cnt2;

   always @( posedge CLK or posedge RST )
     begin
    if( RST==1'b1 ) cnt1 <= 17'd0; else
    if( cnt1==17'd99999 ) cnt1 <= 17'd0; else
                  cnt1 <= cnt1+17'd1;
     end
     
   always @( posedge CLK or posedge RST )
     begin
    if( RST==1'b1 ) cnt2 <= 4'd0; else
      if( cnt1==17'd99999 ) 
        begin
               if( cnt2==4'd9 ) cnt2 <= 4'd0; else
                            cnt2 <= cnt2+4'd1;
            end
     end
     
   assign CE1  = (cnt1==17'd99999)?1'b1:1'b0; // Clock enable  1ms = 1,000Hz
   assign CE10 = (cnt1==17'd99999 && cnt2==4'd9)?1'b1:1'b0; // Clock enable 10ms =   100Hz

endmodule