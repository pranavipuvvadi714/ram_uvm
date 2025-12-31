`ifndef RAM_ENV 
`define RAM_ENV

class ram_env extends uvm_env;
    `uvm_component_utils(ram_env)
    ram_wr_agent w_agent;
    ram_rd_agent r_agent;
    ram_scoreboard sco;

    function new(string name = "ram_env", uvm_component parent = null);
        super.new(name,parent);
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        w_agent = ram_wr_agent::type_id::create("w_agent",this);
        r_agent = ram_rd_agent::type_id::create("r_agent",this);
        sco = ram_scoreboard::type_id::create("sco",this);
    endfunction

    function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        w_agent.mon.wr_port.connect(sco.wr_collect);
        r_agent.mon.rd_port.connect(sco.rd_collect);
    endfunction

endclass

`endif
