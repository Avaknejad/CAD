module input_reg #(parameter size = 32)(clk,rst,load,data_in,data_out);
input clk,rst,load;
input [size-1:0]data_in;
output reg [size-1:0]data_out;

always @(posedge clk, negedge rst) begin
    if(~rst)
        data_out<=0;
    else begin
        if (load) begin
            data_out<=data_in;
        end
        else begin
            data_out<=0;
        end
    end
end
endmodule