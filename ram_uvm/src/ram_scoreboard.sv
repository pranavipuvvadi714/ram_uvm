class ram_scoreboard extends uvm_scoreboard;
    `uvm_component_utils(ram_scoreboard)
    ram_trans q[$];
    `uvm_analysis_imp_decl(_write)
    `uvm_analysis_imp_decl(_read)

    `uvm_analysis_imp_write #(ram_trans,scoreboard) wr_collect;
    `uvm_analysis_imp_read #(ram_trans,scoreboard) rd_collect;

    logic [`DATA_WIDTH-1:0] local_mem [0:`DEPTH-1];

    function new(string name = "ram_scoreboard", uvm_component parent = null);
        super.new(name,parent);
        wr_collect = new("wr_collect", this);
        rd_collect = new("rd_collect", this);
    endfunction

    function void write_write (ram_trans t);
        if(t.cases == WRITE || t.cases == SIM_WR) begin
            local_mem[t.waddr] = t.wdata;
            `uvm_info(get_type_name(),$sformatf("cases = %s, W_ADDR = %0h, W_DATA = %0h",t.cases.name(), t.waddr, t.wdata),UVM_HIGH)
        end
    endfunction

    function void write_read (ram_trans t);
        if(t.cases == READ || t.cases == SIM_WR) begin
            logic [`DATA_WIDTH-1:0] expected_data = local_mem[t.raddr];
            if(expected_data == t.rdata) begin
                `uvm_info(get_type_name,$sformatf("cases = %h, raddr = %0h, expected data = %0h, actual data = %0h", t.cases.name(), t.raddr, expected_data, t.rdata), UVM_HIGH)
            end
            else 
                `uvm_fatal(get_type_name(),$sformatf("mismatch"))
        end
    endfunction
endclass

    