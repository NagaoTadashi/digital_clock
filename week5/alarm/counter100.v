module counter100 ( CLK, RST, CE, CNT, UP );
   input        CLK, RST, CE; // Clock, Reset, Clock Enable
   output [7:0] CNT;          // Output Time
   output       UP;           // Carry

   reg [3:0] 	d1, d0;       // Counters
  
   always @( posedge CLK or posedge RST )
     begin
	if( RST == 1'b1 )
	  begin
	     d1 <= 4'b0000;
	     d0 <= 4'b0000;
	  end
	else if( CE == 1'b1 )
	  begin
	     if( d0 == 4'b1001 )
	       begin
		  d0 <= 4'b0000;
		  if( d1 == 4'b1001  ) d1 <= 4'b0000;
		  else          d1 <= d1 + 4'b0001;
	       end
	     else
	       d0 <= d0 + 4'b0001;
	  end
     end

   assign CNT = { d1, d0 };  // Output time
   assign UP  = ( d1 == 4'b1001 && d0 == 4'b1001 && CE == 1'b1  ) ? 1'd1 : 1'd0;

endmodule
