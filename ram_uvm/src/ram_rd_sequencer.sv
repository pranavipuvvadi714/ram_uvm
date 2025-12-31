`ifndef RD_SEQR
`define RD_SEQR
`include "uvm_macros.svh"
import uvm_pkg::*;

class ram_rd_sequencer extends uvm_sequencer #(ram_trans);
    ram_trans seq_item
    `uvm_object_utils(ram_rd_sequencer)

    function new(string name = "ram_rd_sequencer");
        super.new(name);
    endfunction
endclass
`endif
