`include "uvm_macros.svh"
import uvm_pkg::*
`include "ram_pkg.sv"

module tb;
    bit clk =0;
    bit rst;

    always #5 clk = ~clk;

    ram_if inf(.clk(clk));
    ram d0(.clk(clk),
        .rst(rst),
        .wen(inf.wen),
        .ren(inf.ren),
        .wdata(inf.wdata),
        .rdata(inf.rdata),
        .raddr(inf.raddr),
        .waddr(inf.waddr),
        .cs(inf.cs));
    
    task automatic reset();
        rst = 1;
        inf.rst = 1;
        #20;
        rst = 0;
        inf.rst = 0;
    endtask

    initial begin
        uvm_config_db #(virtual ram_if)::set(null,*,"vif",inf);
        $dumpfile("dump.vcd");
        $dumpvars();
    end

    initial begin
        fork
            reset();
            run_test("ram_test");
        join
    end

endmodule
