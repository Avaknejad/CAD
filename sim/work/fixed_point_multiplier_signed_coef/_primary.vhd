library verilog;
use verilog.vl_types.all;
entity fixed_point_multiplier_signed_coef is
    port(
        a               : in     vl_logic_vector(23 downto 0);
        b               : in     vl_logic_vector(7 downto 0);
        result          : out    vl_logic_vector(31 downto 0);
        ov              : out    vl_logic
    );
end fixed_point_multiplier_signed_coef;
