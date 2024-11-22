library verilog;
use verilog.vl_types.all;
entity mux_2to1 is
    generic(
        size            : integer := 32
    );
    port(
        in0             : in     vl_logic_vector;
        in1             : in     vl_logic_vector;
        sel             : in     vl_logic;
        \out\           : out    vl_logic_vector
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of size : constant is 1;
end mux_2to1;
