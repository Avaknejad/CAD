module top_module (
    clk,
    rst,
    X,
    n,
    start,
    Y,
    valid,
    ready,
    overflow,
    error
);

input clk, rst, start;
input [7:0] X;
input [2:0] n;

output valid, ready, overflow, error;
output [7:0] Y;

wire flush,load,controller_inuse;
datapath dp( .clk(clk),
             .rst(rst),
             .flush(flush),
             .load(load),
             .x(X),
             .n(n), 
             .controller_inuse(controller_inuse), 
             .result(Y), 
             .valid(valid), 
             .ready(ready), 
             .ov_flag(overflow)
            );


controller ctrl( .clk(clk), 
                 .rst(rst), 
                 .start(start), 
                 .ready(ready), 
                 .error(error), 
                 .ov_flag(overflow), 
                 .flush(flush), 
                 .load(load), 
                 .controller_inuse(controller_inuse)
                );
    
endmodule