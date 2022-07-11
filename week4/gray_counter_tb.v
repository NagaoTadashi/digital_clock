`timescale 1ps / 1ps
module gray_counter_tb;
reg CLK, RESETL;
wire [3:0] Q;
parameter STEP = 1000;
// グレイコードカウンタを呼び出す
gray_counter gray_counter( .CLK(CLK), .RESETL(RESTL), .Q(Q) );
// クロック生成
always begin
    CLK = ~CLK; #(STEP/2); // 半ステップ毎に CLK を反転してクロック生成
end
// テスト入力
initial begin
    $dumpfile("gray_counter_tb.vcd");
    $dumpvars(0, gray_counter_tb);
    $monitor( $stime, " CLK=%b RESETL=%b Q=%b", CLK, RESETL, Q);
    CLK = 0; RESETL = 1;
    #STEP RESETL = 0;
    #STEP RESETL = 1;
    // 20 回カウントアップして終了(20 クロック分進める)
    #(STEP*20)$finish;
end
endmodule