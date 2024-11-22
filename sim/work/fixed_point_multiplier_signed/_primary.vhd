library verilog;
use verilog.vl_types.all;
entity fixed_point_multiplier_signed is
    port(
        a               : in     vl_logic_vector(7 downto 0);
        b               : in     vl_logic_vector(15 downto 0);
        result          : out    vl_logic_vector(23 downto 0);
        ov              : out    vl_logic
    );
end fixed_point_multiplier_signed;
