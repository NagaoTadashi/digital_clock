module decoder_case( d, q );
input [1:0] d;
output [3:0] q;

function [3:0] dec;
input [1:0] temp;
    case ( temp )
        2'b00: dec = 4'b0001;
        2'b01: dec = 4'b0010; // 入力が 1 のときのデコード結果を代入
        2'b10: dec = 4'b0100; // 入力が 2 のときのデコード結果を代入
        2'b11: dec = 4'b1000; // 入力が 3 のときのデコード結果を代入
    //defaul; dec = x; // 上記入力に合致しない場合不定値出力
    endcase
endfunction
// デコード結果をデコーダの出力に代入する
assign q = dec(d);
endmodule