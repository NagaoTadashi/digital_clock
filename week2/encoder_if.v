module encoder_if( d, q );
input  [3:0] d;
output [1:0] q;

function [1:0] enc;
input [3:0] temp;
    if ( temp[3] )
        enc = 2'b11;
    else if ( temp[2] )
        enc = 2'b10;// 2’b10のエンコード結果を代入
    else if ( temp[1] )
        enc = 2'b01;// 2’b01のエンコード結果を代入
    else 
        enc = 2'b00;// 2’b00のエンコード結果を代入
endfunction
// エンコード結果をエンコーダの出力に代入する

assign q = enc(d);
endmodule