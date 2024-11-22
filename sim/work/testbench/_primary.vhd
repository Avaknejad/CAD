library verilog;
use verilog.vl_types.all;
entity testbench is
    generic(
        OUTPUT_WIDTH    : integer := 32
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of OUTPUT_WIDTH : constant is 1;
end testbench;
