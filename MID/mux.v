module mux_2to1 #(parameter size = 32 ) (
    input  [size-1:0] in0, 
    input  [size-1:0] in1, 
    input        sel, 
    output [size-1:0] out  
);

    // Multiplexer logic
    assign out = (sel) ? in1 : in0;

endmodule
