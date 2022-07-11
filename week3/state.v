module state ( CLK, RESETL, SW1, SW2, SW3, 
sec_resetl, min_inc, hour_inc, sec_onoff, min_onoff, 
hour_onoff );
input CLK, RESETL, SW1, SW2, SW3;
output sec_resetl, min_inc, hour_inc; 
// 秒リセット(負論理), +1 分, +1 時のカウント部への制御信号
output sec_onoff, min_onoff, hour_onoff; 
// 秒・分・時点滅の表示部への制御信号
reg [1:0] cur; // ステートレジスタ
reg [1:0] nxt; // ステート生成回路(組み合わせ回路)
// ステート名の定義
parameter NORMAL = 2'b00, SEC = 2'b01, MIN = 2'b10, HOUR = 2'b11;
// ステートレジスタ
always @( posedge CLK or negedge RESETL ) begin
    if ( !RESETL )
    cur <= NORMAL;
    else
    cur <= nxt;
end
// ステート生成回路 (組み合わせ回路)
always @( cur or SW1 or SW2 or SW3 ) begin
    case ( cur )
        NORMAL: if ( SW2 )
        nxt <= SEC; // 通常時に SW2 が押されたとき
        else
        nxt <= NORMAL; // それ以外の場合
        SEC: if ( SW2 )
        nxt <= NORMAL; // 秒修正時に SW2 が押されたとき
        else if ( SW3 )
        nxt <= HOUR; // 秒修正時に SW3 が押されたとき
        else
        nxt <= SEC; // それ以外の場合
        // 以下 NORMAL, SEC 時と同様に状態遷移図を参照して記述
        HOUR: if ( SW2 ) 
        nxt <=NORMAL;
        else if ( SW3 )
        nxt <=MIN;
        else
        nxt <=HOUR;
        MIN: if ( SW2 )
        nxt <=NORMAL;
        else if ( SW3 )
        nxt <=SEC;
        else
        nxt <=MIN;
        default:nxt <= 2'bxx; // cur が不定値になってしまったとき
    endcase
end
// 制御信号の生成
// 秒修正時に SW1 が押されたとき
assign sec_resetl = ~((cur==SEC) & SW1);
// 分修正時に SW1 が押されたとき
assign min_inc = ((cur==MIN) & SW1);
// 時修正時に SW1 が押されたとき
assign hour_inc =((cur==HOUR) & SW1);
// 秒修正時は秒点滅状態
assign sec_onoff = (cur==SEC);
// 分修正時は分点滅状態
assign min_onoff = (cur==MIN);
// 時修正時は時点滅状態
assign hour_onoff =(cur==HOUR);
endmodule