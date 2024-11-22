module datapath ( clk, rst, flush, load, x, n, controller_inuse, result, valid, ready, ov_flag);
input       clk,rst,flush,load;
input   [7:0]x;
input   [2:0]n;
input        controller_inuse;
output  [7:0]result;
output       valid;
output       ready;
output       ov_flag;

wire loop_stage1, inuse_stage1, loop_back_stage1;
wire [2:0] level_stage1, per_stage1;
wire [7:0] x_stage1, x_power_stage1, sum_stage1;

wire loop_stage2, inuse_stage2, loop_back_stage2;
wire [2:0] level_stage2, per_stage2;
wire [7:0] x_stage2, x_power_stage2, sum_stage2;

wire loop_stage3, inuse_stage3, loop_back_stage3;
wire [2:0] level_stage3, per_stage3;
wire [7:0] x_stage3, x_power_stage3, sum_stage3;

wire loop_stage4, inuse_stage4, loop_back_stage4;
wire [2:0] level_stage4, per_stage4;
wire [7:0] x_stage4, x_power_stage4, sum_stage4;

wire loop_stage4_out, inuse_stage4_out, loop_back_stage4_out;
wire [2:0] level_stage4_out, per_stage4_out;
wire [7:0] x_stage4_out, x_power_stage4_out, sum_stage4_out;


wire [7:0] x_input;
wire [2:0] n_input;

wire [11:0] overflow;
wire flush;
input_reg #(12)ir (
      .clk(clk),
      .rst(rst),
      .load(load),
      .data_in({x,n,controller_inuse}),
      .data_out({x_input,n_input,controller_inuse_input})     
);





//// inputs \\\\
mux_2to1 mux_sum_in(
     .in0(8'b0), 
     .in1(sum_stage4_out), 
     .sel(loop_stage4_out), 
     .out(sum_stage1)
);

mux_2to1 mux_x_in(
     .in0(x_input), 
     .in1(x_stage4_out), 
     .sel(loop_stage4_out), 
     .out(x_stage1)
);

mux_2to1 mux_xpower_in(
     .in0(8'b00000001), 
     .in1(x_power_stage4_out), 
     .sel(loop_stage4_out), 
     .out(x_power_stage1)
);

////// controller combinational \\\\\\\

assign loop_back_stage1 = (loop_stage4_out) ? loop_stage4_out :1'b0;
assign loop_stage1 = (loop_stage4_out) ? 1'b0 :
                     (n_input>4)?1'b1:1'b0;
assign level_stage1 = (loop_stage4_out) ? level_stage4_out : 3'b0;
assign per_stage1 = (loop_stage4_out) ? per_stage4_out : n_input;
assign inuse_stage1 = (loop_stage4_out) ? inuse_stage4_out : controller_inuse_input;

////////// stage1 \\\\\\\\\\ 
wire [7:0] mul1_out, mul2_out, mux1_out, adder1_out;
wire [2:0] level_stage1_plus;
wire cmp_stage1,cmp_stage1_out ,valid_stage1;


fixed_point_adder_signed adder1 (
      .a(sum_stage1), 
      .b(mul2_out),
      .result(adder1_out), 
      .overflow(overflow[0]) 
);

fixed_point_multiplier_signed mul1 (
      .a(x_stage1), 
      .b(x_power_stage1), 
      .result(mul1_out), 
      .ov(overflow[1])
);

fixed_point_multiplier_signed mul2 (
      .a(mul1_out), 
      .b(mux1_out), 
      .result(mul2_out), 
      .ov(overflow[2])
);

mux_2to1 mux1(
     .in0(8'b01000000), 
     .in1(8'b00001101), 
     .sel(loop_back_stage1), 
     .out(mux1_out)
);

register #(34) reg1(
    .clk(clk),
    .rst(rst),
    .flush(flush),
    .data_in({loop_stage1, inuse_stage1, loop_back_stage1,level_stage1_plus, per_stage1,cmp_stage1,
                x_stage1, mul1_out, adder1_out}),
    .data_out({loop_stage2, inuse_stage2, loop_back_stage2,level_stage2, per_stage2,cmp_stage1_out,
                 x_stage2, x_power_stage2, sum_stage2})
);

one_adder o1(
    .a(level_stage1),
    .result(level_stage1_plus)
);

comparator comp1(
    .a(level_stage1),
    .b(per_stage1),
    .result(cmp_stage1)
);
assign valid_stage1 = cmp_stage1_out & inuse_stage2;
////////// stage2 \\\\\\\\\\ 
wire [7:0] mul3_out, mul4_out, mux2_out, adder2_out;
wire [2:0] level_stage2_plus;
wire cmp_stage2, cmp_stage2_out, valid_stage2;

fixed_point_adder_signed adder2 (
      .a(sum_stage2), 
      .b(mul4_out),
      .result(adder2_out), 
      .overflow(overflow[3]) 
);

fixed_point_multiplier_signed mul3 (
      .a(x_stage2), 
      .b(x_power_stage2), 
      .result(mul3_out), 
      .ov(overflow[4])
);

fixed_point_multiplier_signed mul4 (
      .a(mul3_out), 
      .b(mux2_out), 
      .result(mul4_out), 
      .ov(overflow[5])
);

mux_2to1 mux2(
     .in0(8'b11100000), 
     .in1(8'b11110101), 
     .sel(loop_back_stage2), 
     .out(mux2_out)
);

register #(34) reg2(
    .clk(clk),
    .rst(rst),
    .flush(flush),
    .data_in({loop_stage2, inuse_stage2, loop_back_stage2,level_stage2_plus, per_stage2,cmp_stage2,
                x_stage2, mul3_out, adder2_out}),
    .data_out({loop_stage3, inuse_stage3, loop_back_stage3,level_stage3, per_stage3,cmp_stage2_out,
                 x_stage3, x_power_stage3, sum_stage3})
);
one_adder o2(
    .a(level_stage2),
    .result(level_stage2_plus)
);

comparator comp2(
    .a(level_stage2),
    .b(per_stage2),
    .result(cmp_stage2)
);
assign valid_stage2 = cmp_stage2_out & inuse_stage3;

////////// stage3 \\\\\\\\\\ 
wire [7:0] mul5_out, mul6_out, mux3_out, adder3_out;
wire [2:0] level_stage3_plus;
wire cmp_stage3, cmp_stage3_out, valid_stage3;

fixed_point_adder_signed adder3 (
      .a(sum_stage3), 
      .b(mul6_out),
      .result(adder3_out), 
      .overflow(overflow[6]) 
);

fixed_point_multiplier_signed mul5 (
      .a(x_stage3), 
      .b(x_power_stage3), 
      .result(mul5_out), 
      .ov(overflow[7])
);

fixed_point_multiplier_signed mul6 (
      .a(mul5_out), 
      .b(mux3_out), 
      .result(mul6_out), 
      .ov(overflow[8])
);

mux_2to1 mux3(
     .in0(8'b00010101), 
     .in1(8'b00001001), 
     .sel(loop_back_stage3), 
     .out(mux3_out)
);

register #(34) reg3(
    .clk(clk),
    .rst(rst),
    .flush(flush),
    .data_in({loop_stage3, inuse_stage3, loop_back_stage3,level_stage3_plus, per_stage3, cmp_stage3,
                x_stage3, mul5_out, adder3_out}),
    .data_out({loop_stage4, inuse_stage4, loop_back_stage4,level_stage4, per_stage4,cmp_stage3_out,
                 x_stage4, x_power_stage4, sum_stage4})
);

one_adder o3(
    .a(level_stage3),
    .result(level_stage3_plus)
);

comparator comp3(
    .a(level_stage3),
    .b(per_stage3),
    .result(cmp_stage3)
);
assign valid_stage3 = cmp_stage3_out & inuse_stage4;
////////// stage4 \\\\\\\\\\ 
wire [7:0] mul7_out, mul8_out, mux4_out, adder4_out;
wire [2:0] level_stage4_plus;
wire cmp_stage4,cmp_stage4_out, valid_stage4;

fixed_point_adder_signed adder4 (
      .a(sum_stage4), 
      .b(mul8_out),
      .result(adder4_out), 
      .overflow(overflow[9]) 
);

fixed_point_multiplier_signed mul7 (
      .a(x_stage4), 
      .b(x_power_stage4), 
      .result(mul7_out), 
      .ov(overflow[10])
);

fixed_point_multiplier_signed mul8 (
      .a(x_stage4), 
      .b(x_power_stage4), 
      .result(mul8_out), 
      .ov(overflow[11])
);

mux_2to1 mux4(
     .in0(8'b11110000), 
     .in1(8'b11111000), 
     .sel(loop_back_stage4), 
     .out(mux4_out)
);

register #(34) reg4(
    .clk(clk),
    .rst(rst),
    .flush(flush),
    .data_in({loop_stage4, inuse_stage4, loop_back_stage4,level_stage4_plus, per_stage4,cmp_stage4,
                x_stage4, mul7_out, adder4_out}),
    .data_out({loop_stage4_out, inuse_stage4_out, loop_back_stage4_out,level_stage4_out, per_stage4_out,cmp_stage4_out,
                 x_stage4_out, x_power_stage4_out, sum_stage4_out})
);
one_adder o4(
    .a(level_stage4),
    .result(level_stage4_plus)
);

comparator comp4(
    .a(level_stage4),
    .b(per_stage4),
    .result(cmp_stage4)
);
assign valid_stage4 = cmp_stage4_out & inuse_stage4_out;


/// outputs \\\
assign ov_flag = | overflow;
assign ready = ~loop_stage4;
assign valid = (valid_stage1)||(valid_stage2)||(valid_stage3)||(valid_stage4);
assign result = (valid_stage1)? sum_stage2 :
                (valid_stage2)? sum_stage3 :
                (valid_stage3)? sum_stage4 :
                (valid_stage4)? sum_stage4_out : 0;
endmodule