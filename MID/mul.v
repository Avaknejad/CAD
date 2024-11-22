module fixed_point_multiplier_signed (
    input  signed [7:0] a, 
    input  signed [7:0] b, 
    output signed [7:0] result, 
    output reg ov
);


    wire signed [15:0] full_product;
    assign full_product = a * b;

    assign result = full_product[13:6];
    always @(*) begin
        if((full_product>1)||(full_product<(-1)))
            ov=1;
        else
            ov=0;
    end
endmodule
