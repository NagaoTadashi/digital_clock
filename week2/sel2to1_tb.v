`timescale 1 ps / 1 ps
module sel2to1_tb;
// 2to1 セレクタへの入力
reg a,b,sel;
// 2to1 セレクタからの出力
wire out;
parameter STEP = 1000;
// 2to1 セレクタを呼び出す
sel2to1 sel2to1_test(.a(a), .b(b), .sel(sel), .out(out));
initial begin
$dumpfile("sel2to1_tb.vcd");
$dumpvars(0, sel2to1_tb);
$monitor( $stime, " a=%b b=%b sel=%b out=%b", a, b, sel, out);
// STEP 毎に入力パターンを変化させて全入力パターンを網羅
#STEP a = 0; b = 0; sel = 0;
#STEP a = 0; b = 0; sel = 1;
// 以下より残りの入力パターンを与える
#STEP a = 0; b = 1; sel = 0;
#STEP a = 0; b = 1; sel = 1;
#STEP a = 1; b = 0; sel = 0;
#STEP a = 1; b = 0; sel = 1;
#STEP a = 1; b = 1; sel = 0;
#STEP a = 1; b = 1; sel = 1;
#STEP $finish; // テストベンチの終了
end
endmodule


