module apb_demux_top
# (
    parameter SLAVE_COUNT =  3, 
    parameter ADDR_WIDTH   =  32, 
    parameter DATA_WIDTH   =  32,
    parameter SLAVE_REG_N  =  32,
    parameter SLAVE_OFFSET =  32,
    parameter BASE_OFFSET  =  0  
    )
(
    input                                               PCLK,
    input                                               PRESETn,

    apb_if.apb_m                      mstr,
    apb_if.apb_s  [SLAVE_COUNT-1:0]   slv

);

logic [SLAVE_COUNT - 1:0] select;
logic                     pready;

assign pready = sl_pready_i;


decoder #(SLAVE_COUNT, ADDR_WIDTH, SLAVE_REG_N, SLAVE_OFFSET, BASE_OFFSET) dec1(
    .paddr_i  (slv.PADDR),
    .select_o (select)
);

mux #(SLAVE_COUNT, DATA_WIDTH ) mux1(
    .select (select),
    .sl_pready_i  (mstr.PREADY),
    .sl_prdata_i  (mstr.PRDATA),
    .sl_pslverr_i (mstr.PSLVERR),
    .sl_pready_o (slv.PREADY),
    .sl_prdata_o  (slv.PRDATA),
    .sl_pslverr_o (slv.PSLVERR)

);

demux #(SLAVE_COUNT, ADDR_WIDTH, DATA_WIDTH ) demux1(
   .ms_paddr_i (slv.PADDR),
   .ms_pwrite_i (slv.PWRITE),
   .ms_pwdata_i (slv.PWDATA),
   .select      (select),
   .ms_paddr_o (mstr.PADDR),
   .ms_pwrite_o (mstr.PWRITE),
   .ms_pwdata_o (mstr.PWDATA)
);


endmodule
