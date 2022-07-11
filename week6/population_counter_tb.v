`timescale 1 ps / 1 ps
module population_counter_tb;
reg [31:0] a;
wire [5:0] Q;
parameter STEP = 1000;
population_counter population_counter_test(.a(a), .Q(Q));
initial begin
    $dumpfile("population_counter_tb.vcd");
    $dumpvars(0, population_counter_tb);
    $monitor( $stime, " a=%b Q=%b", a, Q);
    #STEP a = 32'b11111111111111111111111111111111;
    #STEP a = 32'b11010001100010101011011000100110;
    #STEP a = 32'b10110001100011111000011010101010;
    #STEP a = 32'b11001010000111001010001001110001;
    #STEP a = 32'b10100110001111000101010101111100;   
    #STEP a = 32'b10101011101010001001010101010111;
    #STEP a = 32'b11010101111010101001011011101110;
    #STEP a = 32'b10111101001100111110111110101000;
    #STEP a = 32'b11111011110110001010001001110101;
    #STEP a = 32'b10110011101011101011101001110101; 
    #STEP $finish;
end
endmodule