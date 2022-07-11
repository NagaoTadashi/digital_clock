module decoder_cond( d, q );
input [1:0] d;
output [3:0] q;
assign q[0] = (d==2'b00);
assign q[1] = (d==2'b01); // 入力 d が 2’b01 のとき 1 を出力
assign q[2] = (d==2'b10); // 入力 d が 2’b10 のとき 1 を出力
assign q[3] = (d==2'b11); // 入力 d が 2’b11 のとき 1 を出力
endmodule