library verilog;
use verilog.vl_types.all;
entity fixed_point_adder_signed is
    port(
        a               : in     vl_logic_vector(31 downto 0);
        b               : in     vl_logic_vector(31 downto 0);
        result          : out    vl_logic_vector(31 downto 0);
        overflow        : out    vl_logic
    );
end fixed_point_adder_signed;
