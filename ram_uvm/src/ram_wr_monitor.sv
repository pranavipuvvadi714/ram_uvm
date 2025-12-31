`ifndef WR_MON 
`define WR_MON

class ram_wr_monitor extends uvm_monitor #(ram_trans);
    virtual ram_if vif;
    `uvm_component_utils(ram_wr_monitor)
    uvm_analysis_port #(ram_trans) wr_port;
    ram_trans seq_item;

    function new(string name = "ram_wr_monitor", uvm_component parent = null);
        super.new(name,parent);
        wr_port = new("wr_port",this);
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        if(!uvm_config_db #(virtual ram_if)::get(this,"","vif",vif)) begin
            `uvm_fatal(get_type_name(),"error in write monitor")
        end
    endfunction

    task run_phase(uvm_phase phase);
  
        forever begin
            @posedge (vif.clk);

            if(vif.mon_cb.wen && vif.mon_cb.cs) begin
                seq_item = ram_trans::type_id::create("seq_item");
                seq_item.wen = vif.mon_cb.wen;
                seq_item.waddr = vif.mon_cb.waddr;
                seq_item.wdata = vif.mon_cb.wdata;
                `uvm_info(get_type_name(),"write transaction captured",UVM_MEDIUM)
                seq_item.print();
                wr_port.write(seq_item);
            end
        end
    endtask
endclass
`endif
