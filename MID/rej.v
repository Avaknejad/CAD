module register #(parameter size = 32)(clk,rst,flush,data_in,data_out);

input clk,rst,flush;
input [size-1:0]data_in;
output reg [size-1:0]data_out;

always @(posedge clk, negedge rst) begin
    if(~rst)
        data_out<=0;
    else begin
        if (flush) begin
            data_out<=0;
        end
        else begin
            data_out<=data_in;
        end
    end
end


endmodule
