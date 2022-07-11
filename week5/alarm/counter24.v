module counter24 ( CLK, RST, CE, CNT );
   input        CLK, RST, CE; // Clock, Reset, Clock Enable
   output [7:0] CNT;          // Output Time
  
   reg [3:0] 	d1, d0;       // Counters
  
   always @( posedge CLK or posedge RST  )
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
		  d1 <= d1 + 4'b0001; 
	       end
	     else if( d1 == 4'b0010 && d0 == 4'b0011 )
	       begin
		  d1 <= 4'b0000;
		  d0 <= 4'b0000;
	       end
	     else
	       d0 <= d0 + 4'b0001;
	  end
     end
     
   assign CNT = { d1, d0 };  // Output time

endmodule
