`ifndef RDSEQ
`define RDSEQ
import uvm_pkg::*;
`include "uvm_macros.svh"
class ram_rd_seq extends uvm_sequence #(ram_trans);
    ram_trans seq_item;
    `uvm_object_utils(ram_rd_seq)

    function new(string name = "ram_rd_seq");
        super.new(name);
    endfunction

    task body();
        `uvm_info(get_type_name(),"Executing base write sequence", UVM_LOW);
        repeat(`no_of_itr) begin
            seq_item = ram_trans::type_id::create("seq_item");
            start_item(seq_item);
            if(!seq_item.randomize() with {this cases == READ;}) begin
                `uvm_error(get_type_name,"randomization failed")
            end
            finish_item(seq_item);
        end
    endtask
endclass

`endif

