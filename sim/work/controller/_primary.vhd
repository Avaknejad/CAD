library verilog;
use verilog.vl_types.all;
entity controller is
    port(
        clk             : in     vl_logic;
        rst             : in     vl_logic;
        start           : in     vl_logic;
        ready           : in     vl_logic;
        error           : in     vl_logic;
        ov_flag         : in     vl_logic;
        flush           : out    vl_logic;
        load            : out    vl_logic;
        controller_inuse: out    vl_logic
    );
end controller;
