`ifndef WR_DR
`define WR_DR

class ram_wr_driver extends uvm_driver #(ram_trans);
    `uvm_object_utils(ram_wr_driver)
    virtual ram_if vif;
    ram_trans seq_item;

    function new(string name = "ram_wr_driver", uvm_component parent = null);
        super.new(name,parent);
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        if(!uvm_config_db #(virtual ram_if)::get(this,"","vif",vif)) begin
            `uvm_fatal(get_type_name(),"error");
        end
    endfunction

    task run_phase(uvm_phase phase);
        super.run_phase(phase);
        forever begin
            seq_item_port.get_next_item(seq_item);
            @posedge (vif.clk);
            vif.drv_cb.wen <= seq_item.wen;            
            vif.drv_cb.waddr <= seq_item.waddr;
            vif.drv_cb.cs <= seq_item.cs;
            vif.drv_cb.wdata <= seq_item.wdata;
            `uvm_info(get_type_name,"data sent to DUT",UVM_MEDIUM)
            seq_item_port.item_done();
        end
    endtask
endclass
`endif






