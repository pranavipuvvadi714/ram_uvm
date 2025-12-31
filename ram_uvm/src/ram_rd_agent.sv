`ifndef RD_AGENT 
`define RD_AGENT_AGENT
class rd_agent extends uvm_agent;
    `uvm_component_utils(rd_agent)
    ram_rd_driver drv;
    ram_rd_monitor mon;
    ram_rd_sequencer sqr;

    function new(string name = "rd_agent", uvm_component parent = null);
        super.new(name,parent);
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        if(get_is_active == UVM_ACTIVE) begin
            drv = ram_rd_driver::type_id::create("drv",this);
            sqr = ram_rd_sequencer::type_id::create("sqr",this);
        end
        mon = ram_rd_monitor::type_id::create("mon",this);
    endfunction

    function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        if(get_is_active == UVM_ACTIVE) begin
            drv.seq_item_port.connect(sqr.seq_item_export);
        end
    endfunction

endclass
