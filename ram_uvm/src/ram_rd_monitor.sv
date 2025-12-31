`ifndef RD_MON
`define RD_MON

class ram_rd_monitor extends uvm_monitor #(ram_trans);
    `uvm_component_utils(ram_rd_monitor)
    ram_trans seq_item;
    uvm_analysis_port #(ram_trans) rd_port;
    virtual ram_if vif;

    function new(string name = "ram_rd_monitor", uvm_component parent = null);
        super.new(name,parent);
        rd_port = new("rd_port",this);
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        if(!uvm_config_db #(virtual ram_if)::get(this,"","vif",vif)) begin
            `uvm_fatal(get_type_name(),"error in read monitor")
        end
    endfunction

    task run_phase(uvm_phase phase);
       forever begin
        @posedge (vif.clk);
        if(vif.mon_cb.ren && vif.mon_cb.cs) begin
            seq_item = ram_trans::type_id::create("seq_item");
            seq_item.ren <= vif.mon_cb.ren;
            seq_item.raddr <= vif.mon_cb.raddr;
            seq_item.cs <= vif.mon_cb.cs;

            @posedge (vif.clk)
            seq_item.rdata <= vif.mon_cb.rdata;
            `uvm_info(get_type_name(),"monitor data captured",UVM_LOW)
            seq_item.print();
            rd_port.write(seq_item);
        end
        end
    endtask
endclass
`endif

