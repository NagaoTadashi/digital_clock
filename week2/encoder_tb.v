`timescale 1 ps / 1 ps
module encoder_tb;
reg ck, res;
reg [3:0] d; // 入力を reg 宣言
wire [1:0] q; // 出力を wire 宣言
parameter STEP = 100000;
//エンコーダの 2 パターンのうちどちらかを呼び出す
encoder_if encoder( .d(d), .q(q) );
//encoder_casex encoder( .(d)d, .q(q) );

always begin
    ck = 0; #(STEP / 2);
    ck = 1; #(STEP / 2);
end

initial begin
    $dumpfile("encoder_tb.vcd");
    $dumpvars(0, encoder_tb);
    $monitor( $stime, " ck=%b res=%b d=%b q=%b", ck, res, d, q);
    d = 4'b0001;
    #STEP d = 4'b0011;
    #STEP d = 4'b0100;
    #STEP d = 4'b0101;
    #STEP d = 4'b0110;
    #STEP d = 4'b0111;
    #STEP d = 4'b1000;
    #STEP d = 4'b1001;
    #STEP d = 4'b1010;
    #STEP d = 4'b1011;
    #STEP d = 4'b1100;
    #STEP d = 4'b1101;
    #STEP d = 4'b1110;
    #STEP d = 4'b1111;
    #STEP $finish;
end

endmodule
