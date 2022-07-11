module counter ( CLK, RESETL, Q ); // 4bit counter
input   CLK, RESETL;
output  [3:0] Q;
reg [3:0] Q;
// 以下より always 文によるリセット及びカウントアップ記述
always @( posedge CLK or  negedge RESETL ) begin
    if ( RESETL == 1'b0 )
        Q=4'b0000;
    else
        Q=Q+4'b0001;
end
endmodule