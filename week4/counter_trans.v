module counter_trans ( CLK, RESETL, OUT ); // 4bit counter
input CLK, RESETL;
output OUT;
wire [3:0] tmp; // counter の出力に接続
// counter モジュールを呼び出す
counter counter (.CLK(CLK), .RESETL(RESETL), .Q(tmp));
// 奇数個のビットが 1 の時には 1, 偶数個のビットが 1 のときには 0 を出力
assign OUT = ((tmp[3]+tmp[2]+tmp[1]+tmp[0])%2);
endmodule
