`ifndef WR_AGENT 
`define WR_AGENT
class wr_agent extends uvm_agent;
    `uvm_component_utils(wr_agent)
    ram_wr_driver drv;
    ram_wr_monitor mon;
    ram_wr_sequencer sqr;

    function new(string name = "wr_agent", uvm_component parent = null);
        super.new(name,parent);
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        if(get_is_active == UVM_ACTIVE) begin
            drv = ram_wr_driver::type_id::create("drv",this);
            sqr = ram_wr_sequencer::type_id::create("sqr",this);
        end
        mon = ram_wr_monitor::type_id::create("mon",this);
    endfunction

    function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        if(get_is_active == UVM_ACTIVE) begin
            drv.seq_item_port.connect(sqr.seq_item_export);
        end
    endfunction

endclass
