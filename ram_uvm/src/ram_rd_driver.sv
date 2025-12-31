`ifndef RD_DRIVER 
`define RD_DRIVER

class ram_rd_driver extends uvm_driver #(ram_trans);
    `uvm_component_utils(ram_rd_driver)
    ram_trans seq_item;
    virtual ram_if vif;

    function new(string name = "ram_rd_driver", uvm_component parent = null);
        super.new(name,parent);
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        if(!uvm_config_db #(virtual ram_if)::get(this,"","vif",vif)) begin
            `uvm_fatal(get_type_name(),"error in ram rd driver")
        end
    endfunction

    task run_phase(uvm_phase phase);
        super.run_phase(phase);
        forever begin
            seq_item_port.get_next_item(seq_item);
            @posedge (vif.clk);
            vif.drv_cb.ren <= seq_item.ren;
            vif.drv_cb.cs <= seq_item.cs;
            vif.drv_cb.raddr <= seq_item.raddr;
            seq_item_port.item_done();
        end
    endtask

endclass

`endif
