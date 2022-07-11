`timescale 1ps / 1ps
module counter_trans_tb;
reg CLK, RESETL;
wire OUT;
parameter STEP = 1000;
// counter_trans を呼び出す
counter_trans counter_trans ( .CLK(CLK), .RESETL(RESETL), .OUT(OUT) );
// クロック生成
always begin
    CLK = ~CLK; #(STEP/2); // 半ステップ毎に CLK を反転してクロック生成
end
// テスト入力
initial begin
    $dumpfile("counter_trans_tb.vcd");
    $dumpvars(0, counter_trans_tb);
    $monitor( $stime, " CLK=%b RESETL=%b Q=%b OUT=%b", CLK, 
    RESETL, counter_trans.counter.Q, OUT);
    CLK = 0; RESETL = 1;
    #STEP RESETL = 0;
    #STEP RESETL = 1;
    // 20 回カウントアップして終了(20 クロック分進める)
    #(STEP*20) $finish;
end
endmodule