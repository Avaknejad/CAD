library verilog;
use verilog.vl_types.all;
entity datapath is
    port(
        clk             : in     vl_logic;
        rst             : in     vl_logic;
        flush           : in     vl_logic;
        load            : in     vl_logic;
        x               : in     vl_logic_vector(7 downto 0);
        n               : in     vl_logic_vector(2 downto 0);
        controller_inuse: in     vl_logic;
        result          : out    vl_logic_vector(7 downto 0);
        valid           : out    vl_logic;
        ready           : out    vl_logic;
        ov_flag         : out    vl_logic
    );
end datapath;
