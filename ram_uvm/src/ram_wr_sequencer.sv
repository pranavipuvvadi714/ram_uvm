`ifndef WR_SEQR
`define WR_SEQR
`include "uvm_macros.svh"
import uvm_pkg::*;

class ram_wr_sequencer extends uvm_sequencer #(ram_trans);
    ram_trans seq_item
    `uvm_object_utils(ram_wr_sequencer)

    function new(string name = "ram_wr_sequencer");
        super.new(name);
    endfunction
endclass
`endif
