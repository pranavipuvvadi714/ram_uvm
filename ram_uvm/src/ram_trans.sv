import uvm_pkg::*;
`include "uvm_macros.svh"

class ram_trans extends uvm_sequence_item;
    typedef enum{WRITE, READ, SIM_WR, IDLE} case_e;
    rand bit wen;
    rand bit ren;
    rand bit [`DATA_WIDTH-1:0] wdata;
     bit [`DATA_WIDTH-1:0] rdata;
    rand bit [`ADDR_WIDTH-1:0] waddr;
     rand bit [`ADDR_WIDTH-1:0] raddr;
     bit cs = 1;
    rand case_e cases;

    constraint valid_addresses {waddr inside [0:(1<<ADDR_WIDTH)-1];
                        raddr inside [0:(1<<ADDR_WIDTH)-1];}
    constraint casess {
        cases == WRITE -> {wen==1;ren==0};
        cases == READ ->  {wen==0;ren==1};
        cases == SIM_WR ->  {wen==1;ren==1};
        cases == IDLE ->  {wen==0;ren==0};
        
    }

    `uvm_object_utils_begin(ram_trans)
        `uvm_field_enum(case_e, cases, UVM_ALL_ON)
        `uvm_field_int(wen,UVM_ALL_ON)
        `uvm_field_int(ren,UVM_ALL_ON)
        `uvm_field_int(raddr,UVM_ALL_ON)
        `uvm_field_int(waddr,UVM_ALL_ON)
        `uvm_field_int(cs,UVM_ALL_ON)
        `uvm_field_int(rdata,UVM_ALL_ON)
        `uvm_field_int(wdata,UVM_ALL_ON)
    `uvm_object_utils_end

    function new(string name = "ram_trans");
        super.new(name);
    endfunction

    function void do_print(uvm_printer printer);
        super.do_print(printer);
        printer.print_field("cs", cs, 1);
        printer.print_field("cases", cases.name());
        printer.print_field("wen",wen,1);
        printer.print_field("ren",ren,1);
        printer.print_field("raddr",raddr,`ADDR_WIDTH);
        printer.print_field("waddr",waddr,`ADDR_WIDTH);
        printer.print_field("rdata",rdata,`DATA_WIDTH);
        printer.print_field("wdata",wdata,`DATA_WIDTH);
    endfunction

endclass

