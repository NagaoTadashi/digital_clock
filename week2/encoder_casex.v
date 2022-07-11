module encoder_casex( d, q );
input [3:0] d;
output [1:0] q;
function [1:0] enc;
input [3:0] temp;
casex( temp )
    4'b1xxx: enc = 2'b11;
    4'b01xx: enc = 2'b10; // 2’b0100 のエンコード結果を代入
    4'b001x: enc = 2'b01; // 2’b0010 のエンコード結果を代入
    4'b000x: enc = 2'b00; // 2’b0001 のエンコード結果を代入
endcase
endfunction
// エンコード結果をエンコーダの出力に代入する
assign q = enc(d);
endmodule