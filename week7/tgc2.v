module tgc2 (a,b,c,Q);
    input [7:0] a,b,c;
    output Q;
    reg cnt;
    
    always @(a,b,c) begin
        cnt=1'b0;
        if (({1'b0,a}+{1'b0,b})>c && ({1'b0,a}+{1'b0,c})>b && ({1'b0,b}+{1'b0,c})>a) begin
            cnt=1'b1;
        end
    end   

    assign Q=cnt; 
endmodule