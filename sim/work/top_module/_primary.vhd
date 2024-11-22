library verilog;
use verilog.vl_types.all;
entity top_module is
    port(
        clk             : in     vl_logic;
        rst             : in     vl_logic;
        X               : in     vl_logic_vector(7 downto 0);
        n               : in     vl_logic_vector(2 downto 0);
        start           : in     vl_logic;
        Y               : out    vl_logic_vector(7 downto 0);
        valid           : out    vl_logic;
        ready           : out    vl_logic;
        overflow        : out    vl_logic;
        error           : out    vl_logic
    );
end top_module;
