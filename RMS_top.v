
`include "header.v"
`include "sqrt.v"
`include "div.v"

module RMS_top(
    clk, rst, start, a, RMS_code, done
    );
    
    input clk, rst, start;
    input [7:0] a;
    output reg [11:0] RMS_code;
    output reg done;
    
    reg [11:0] RMS_code_n;
    reg [`STATE_WIDTH-1:0] state, state_n;
    reg [7:0] x, x_n;
    wire [`WIDTH_DIV-`FBITS_DIV-1:0] x_square;
    reg [`WIDTH_DIV-`FBITS_DIV-1:0] sum, sum_n;
    reg [`WIDTH_DIV-`FBITS_DIV-1:0] N, N_n;
    reg [`WIDTH_DIV-1:0] mean_square, mean_square_n;
    
    // for square root
    reg start_sqrt, start_sqrt_n;
    wire busy_sqrt, valid_sqrt;
    wire [`WIDTH-1:0] root;  // root
    wire [`WIDTH-1:0] rem;   // remainder
    
    // for division
    reg start_div, start_div_n;
    wire busy_div, valid_div;
    wire [`WIDTH_DIV-1:0] q;    // quotient
    wire [`WIDTH_DIV-1:0] r;    // remainder
    
    sqrt sqrt1(.clk(clk), .start(start_sqrt), .busy(busy_sqrt), .valid(valid_sqrt), .rad(mean_square), .root(root), .rem(rem));
    div div1(.clk(clk), .start(start_div), .busy(busy_div), .valid(valid_div), .dbz(dbz), .ovf(ovf), .x({sum,`FBITS_DIV'b0}), .y({N,`FBITS_DIV'b0}), .q(q), .r(r));
    
    assign x_square = x_n*x_n;
    
    //
    // Sequential block
    //
    always@(posedge clk or posedge rst)
    begin
        if(rst)
        begin
            sum <= 0;
            state <= `S0;
            N <= 0;
            RMS_code <= 0;
            x <= 0;
            start_sqrt <= 0;
            start_div <= 0;
        end
        else
        begin
            sum <= sum_n;
            state <= state_n;
            N <= N_n;
            RMS_code <= RMS_code_n;
            x <= x_n;
            mean_square <= mean_square_n;
            start_sqrt <= start_sqrt_n;
            start_div <= start_div_n;
        end
    end
    
    //
    // Combinational block
    //
    always@(*)
    begin
        if(rst) begin
            state_n <= `S0;
            x_n <= 0;
            sum_n <= 0;
            N_n <= 0;
            done <= 0;
            start_sqrt_n <= 0;
            start_div_n <= 0;
        end
        else begin
            // default value
            state_n <= state;
            x_n <= x;
            sum_n <= sum;
            N_n <= N;
            done <= 0;
            start_sqrt_n <= 0;
            start_div_n <= 0;
            
            case(state)
            `S0:
            begin
                if(start) begin
                    x_n <= a;
                    N_n <= N + 1;
                    state_n <= `S1;
                end
            end
            `S1:
            begin
                sum_n <= sum + x_square;
                start_div_n <= 1;
                state_n <= `S2;
            end
            `S2:
            begin
                if(valid_div)
                begin
                    mean_square_n <= q;
                    start_sqrt_n <= 1;
                    state_n <= `S3;
                end
            end
            `S3:
            begin
                if(valid_sqrt)
                begin
                    RMS_code_n <= root[`FBITS+7:`FBITS-4];
                    done <= 1'b1;
                    state_n <= `S0;
                end                
            end
            endcase
        end
    end
    
endmodule