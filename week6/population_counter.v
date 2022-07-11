module population_counter ( a, Q );
    input  [31:0] a;
    output  [5:0] Q;
    reg [5:0] cnt;
    integer i;

    always @( a ) begin
        cnt = 6'b0;
        for ( i=0 ; i<32 ; i=i+1 ) begin
            if (a[i] == 1'b1) begin
                cnt = cnt + 6'b1;
            end
        end
    end
    assign Q = cnt;
endmodule