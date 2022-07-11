`timescale 1 ps / 1 ps
module decoder_tb;
reg [1:0] d; // 入力を reg 宣言
wire [3:0] q; // 出力を wire 宣言
parameter STEP = 100000;
//デコーダの 3 パターンのうちどれかを呼び出す↓
//decoder_cond decoder(.d(d), .q(q));
decoder_if decoder(.d(d), .q(q));
//decoder_case decoder(.d(d), .q(q));
initial begin
    $dumpfile("decoder_tb.vcd");
    $dumpvars(0, decoder_tb);
    $monitor( $stime, " d=%b q=%b", d, q);
    #STEP d = 2'b00;
    #STEP d = 2'b01;
    #STEP d = 2'b10;
    #STEP d = 2'b11;
    #STEP $finish;
end
endmodule
