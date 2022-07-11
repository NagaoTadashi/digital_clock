module gray_counter ( CLK, RESETL, Q );
input CLK, RESETL;
output [3:0] Q;
reg [3:0] Q;
// グレイコード生成部
function [3:0] gray;
input [3:0] gray_in;
    case ( gray_in )
        // 現在のカウンタ値によって次のカウンタ値を代入
        4'b0000: gray = 4'b0001;
        4'b0001: gray = 4'b0011;
        // 以下より表 1 の残りのカウンタ値の場合について記述
        4'b0011: gray = 4'b0010;
        4'b0010: gray = 4'b0110;
        4'b0110: gray = 4'b0111;
        4'b0111: gray = 4'b0101;
        4'b0101: gray = 4'b0100;
        4'b0100: gray = 4'b1100;
        4'b1100: gray = 4'b1101;
        4'b1101: gray = 4'b1111;
        4'b1111: gray = 4'b1110;
        4'b1110: gray = 4'b1010;
        4'b1010: gray = 4'b1011;
        4'b1011: gray = 4'b1001;
        4'b1001: gray = 4'b1000;
        4'b1000: gray = 4'b0000;
        default: gray = 4'bxxxx;
    endcase
endfunction
always @( posedge CLK or negedge RESETL ) begin
    if ( RESETL == 1'b0 )
        Q <= 4'h0;
    else
        // gray の出力を代入
        Q <=gray(Q);
end
endmodule