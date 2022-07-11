`timescale 1ps / 1ps
module state_tb;
reg CLK, RESETL, SW1, SW2, SW3;
wire sec_resetl, min_inc, hour_inc;
wire sec_onoff, min_onoff, hour_onoff;
integer mcd;
parameter STEP = 1000;
// ステートマシンを呼び出す
state state( CLK, RESETL, SW1, SW2, SW3, sec_resetl, min_inc, 
hour_inc, sec_onoff, min_onoff, hour_onoff );
// クロックは遷移とそれに伴う制御信号の変化に必要
always begin
    CLK = ~CLK; #(STEP/2);
end
// テスト入力
initial begin
    $dumpfile("state_tb.vcd");
    $dumpvars(0, state_tb);
    $monitor( $stime, " CLK=%b : cur=%b RESETL=%b SW1=%b SW2=%b  SW3=%b sec_resetl=%b, min_inc=%b, hour_inc=%b, sec_onoff=%b, min_onoff=%b, hour_onoff=%b", CLK, state.cur, RESETL, SW1, SW2, SW3, sec_resetl, min_inc, hour_inc, sec_onoff,min_onoff, hour_onoff);
    CLK = 0; RESETL = 1; SW1 = 0; SW2 = 0; SW3 = 0;
    #STEP RESETL = 0;
    #STEP RESETL = 1;
    // 通常時の遷移と制御信号のテスト
    // 2 つ以上の SW が同時に 1 になることを想定しない
    #STEP SW1 = 1;
    #STEP SW1 = 0; SW2 = 1;
    #(STEP*2) SW2 = 0; SW3 = 1;
    #STEP SW3 = 0; SW2 = 1;
    // 秒修正時の遷移と制御信号のテスト
    #STEP SW2 = 0; SW1 = 1;
    #STEP SW1 = 0; SW2 = 1;
    #(STEP*2) SW2 = 0; SW3 = 1;
    // 時修正時の遷移と制御信号のテスト
    #STEP SW3 = 0; SW1 = 1;
    #STEP SW1 = 0; SW2 = 1;
    #(STEP*2) SW2 = 0; SW3 = 1;
    // 分修正時の遷移と制御信号のテスト
    #(STEP*2) SW3 = 0; SW1 = 1;
    #STEP SW1 = 0; SW2 = 1;
    #(STEP*2) SW2 = 0; SW3 = 1;
    #(STEP*3) SW3 = 0; SW2 = 1;
    #STEP $finish;
end
endmodule