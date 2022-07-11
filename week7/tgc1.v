module tgc1 (a,b,c,Q);
    input [7:0] a,b,c;
    output Q;
    reg cnt;

    always @(a,b,c) begin
        cnt=1'b0;
        if (a>=b) begin
            if ((a-b)<c && c<({1'b0,a}+{1'b0,b})) begin
                cnt=1'b1;
            end
        end
        if ((b-a)<c && c<({1'b0,a}+{1'b0,b})) begin
            cnt=1'b1;    
        end
    end
    
    assign Q=cnt;
endmodule