module ram #(parameter ADDR_WIDTH = 4 , parameter DATA_WIDTH = 8, parameter DEPTH = 16 ) (
    input clk,
    input wen,
    input rst,
    input ren,
    input [DATA_WIDTH-1:0] wdata,
    input [ADDR_WIDTH-1:0] waddr,
    input [ADDR_WIDTH-1:0] raddr,
    input cs,
    output reg [DATA_WIDTH-1:0] rdata
);

reg [DATA_WIDTH-1:0] ram [0:DEPTH-1];
integer i;

always @(posedge clk) begin
    if(rst) begin
        rdata <=0;
        for (i=0;i<DEPTH; i=i+1) begin
            ram[i] <= 0;
            end
    end
    else begin
        if(cs) begin
            if(wen) begin
                ram[waddr] <= wdata;
            end
            if (ren) begin
                rdata <= ram[raddr];
            end
        end
       
    end
end
endmodule
