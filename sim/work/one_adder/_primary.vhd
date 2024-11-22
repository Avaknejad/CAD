library verilog;
use verilog.vl_types.all;
entity one_adder is
    port(
        a               : in     vl_logic_vector(2 downto 0);
        result          : out    vl_logic_vector(2 downto 0)
    );
end one_adder;
