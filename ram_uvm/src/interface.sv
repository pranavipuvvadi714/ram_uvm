interface ram_if (input clk);
    logic wen;
    logic ren;
    logic [`DATA_WIDTH-1:0] wdata;
    logic [`DATA_WIDTH-1:0] rdata;
    logic [`ADDR_WIDTH-1:0] raddr;
    logic [`ADDR_WIDTH-1:0] waddr;
    logic cs;

    clocking drv_cb @(posedge clk);
        default input #1 output #0;
        output wen, ren, wdata, cs, waddr, raddr;
        input rst, rdata;
    endclocking

    clocking mon_cb @(posedge clk);
        default input #1 output #0;
        input wen, ren, wdata, rdata, cs, waddr, raddr, rst;
    endclocking

    modport drv_mp (clocking drv_cb, input clk);
    modport mon_mp (clocking mon_cb, input clk);

endinterface





