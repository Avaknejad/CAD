module fixed_point_adder_signed (
    input  signed [7:0] a, // 8-bit signed input (2 integer, 6 fractional)
    input  signed [7:0] b, // 8-bit signed input (2 integer, 6 fractional)
    output signed [7:0] result, // 8-bit signed output (2 integer, 6 fractional)
    output overflow // Overflow flag
);

    wire signed [8:0] sum; // Intermediate 9-bit sum to check for overflow

    // Add inputs
    assign sum = a + b;

    // Assign the result to the 8 least significant bits of the sum
    assign result = sum[7:0];

    // Set the overflow flag if the sum exceeds the range of 8-bit signed values
    assign overflow = (sum[8] != sum[7]);

endmodule

module one_adder(a,result);
    input [2:0] a;
    output [2:0] result;
    wire    [3:0] sum;

    assign sum = a + 1;
    
    assign result = sum[2:0];

endmodule
