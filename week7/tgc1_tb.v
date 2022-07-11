`timescale 1 ps / 1 ps
module tgc1_tb;
reg [7:0] a,b,c;
wire  Q;
parameter STEP = 1000;
tgc1 tgc1_test(.a(a),.b(b),.c(c),.Q(Q));
initial begin
    $dumpfile("tgc1_tb.vcd");
    $dumpvars(0, tgc1_tb);
    $monitor( $stime, " a=%b b=%b c=%b Q=%b", a,b,c,Q);
    #STEP a = 8'b00000011; b = 8'b00000100; c = 8'b00001010; 
    #STEP a = 8'b00000011; b = 8'b00000100; c = 8'b00000101; 
    #STEP a = 8'b10010101; b = 8'b00101010; c = 8'b10010101; 
    #STEP a = 8'b01101011; b = 8'b10111011; c = 8'b01111010; 
    #STEP a = 8'b00011011; b = 8'b11010100; c = 8'b11010101; 
    #STEP a = 8'b11101101; b = 8'b11011101; c = 8'b11110011; 
    #STEP a = 8'b11111010; b = 8'b11111101; c = 8'b11010110; 
    #STEP a = 8'b11000011; b = 8'b00000111; c = 8'b11110101; 
    #STEP a = 8'b00110010; b = 8'b11111001; c = 8'b11101110; 
    #STEP a = 8'b11111000; b = 8'b11011001; c = 8'b10001110; 
    #STEP $finish;
end
endmodule