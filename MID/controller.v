`define IDEL 2'b00
`define LOAD 2'b01
`define CALC 2'b10 
module controller(clk, rst, start, ready, error, ov_flag, flush, load, controller_inuse);
    input   clk, rst, start, ready, error, ov_flag;
    output reg  flush, load, controller_inuse;

    reg[1:0] ns, ps;

always @(posedge clk, negedge rst) begin
    if (~rst) begin
        ps <= `IDEL;
    end
    else
        ps<= ns;
end

always @(*) begin
    if ((ps == `LOAD) && (error)) begin
        ns = `IDEL;
    end
    else begin
    case(ps)
        `IDEL: ns = start ? `LOAD : `IDEL;
        `LOAD: ns = ready ? `CALC : `LOAD;
        `CALC: ns = `LOAD;
        default : ns = `IDEL;
    endcase
    end
end

always @(*) begin
    {flush, load, controller_inuse} = 0;
    case(ps)
        `IDEL: ;
        `LOAD: controller_inuse = 1;
        `CALC: begin controller_inuse = 1; load=1; end
        default: ;
    endcase
end


endmodule