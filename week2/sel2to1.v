module sel2to1(a,b,sel,out); // 2to1 selector
// 入力ポートの宣言
input a,b,sel;
// 出力ポートの宣言
output out;
// 以下より assign 文による 2to1 セレクタの出力の記述
assign out=(sel==0)?a&b:a~|b;
endmodule
