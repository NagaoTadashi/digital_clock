`timescale 1ps / 1ps
module counter_tb;
reg CLK, RESETL;
wire [3:0] Q;
parameter STEP = 1000;
// 4 ビットカウンタを呼び出す
counter counter( .CLK(CLK), .RESETL(RESETL), .Q(Q) );
// クロック生成
always begin
    CLK = ~CLK; #(STEP/2); // 半ステップ毎に CLK を反転してクロック生成
end
// テスト入力
initial begin
    $dumpfile("counter_tb.vcd");
    $dumpvars(0, counter_tb);
    $monitor( $stime, " CLK=%b RESETL=%b Q=%b", CLK, RESETL, Q);
    CLK = 0; RESETL = 1;
    #STEP RESETL=0;
    #STEP RESETL=1;
    // 20 回カウントアップして終了(20 クロック分進める)
    #(STEP*20);
    $finish;
end
endmodule