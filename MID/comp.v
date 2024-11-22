module comparator(a,b,result);

input[2:0] a,b;
output result;

assign result = (a==b)?1'b1:1'b0;

endmodule