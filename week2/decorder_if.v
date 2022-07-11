module decoder_if( d, q );
    input [1:0] d;
    output [3:0] q;

    function [3:0] dec;
    input[1:0] temp;
        if ( temp==2'd0 )
            dec = 4'b0001;
        // 入力が 1 のときのデコード結果を代入
        else if ( temp==2'd1 )
            dec = 4'b0010;
        // 入力が 2 のときのデコード結果を代入
        else if ( temp==2'd2 )
            dec = 4'b0100;
        // 入力が 3 のときのデコード結果を代入
        else
            dec = 4'b1000;
    endfunction
    
    // デコード結果をデコーダの出力に代入する
        assign q=dec(d);
endmodule
