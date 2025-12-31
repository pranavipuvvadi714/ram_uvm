`ifndef TEST  
`define TEST
class ram_test extends uvm_test;
    ram_env env;
    ram_rd_seq r_seq;
    ram_wr_seq w_seq;

    `uvm_component_utils(ram_test)

    function new(string name = "ram_test", uvm_component parent = null);
        super.new(name,parent);
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        env = ram_env::type_id::create("env",this);
    endfunction

    task run_phase(uvm_phase phase);
        phase.raise_objection(this);
        r_seq = ram_rd_seq::type_id::create("r_seq");
        w_seq = ram_wr_seq::type_id::create("w_seq");

        fork
            r_seq.start(env.r_agent.sqr);
            w_seq.start(env.w_agent.sqr);
        join
        phase.drop_objection(this);
    endtask
endclass

`endif
