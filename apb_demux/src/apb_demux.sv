module apb_demux 
#(
    parameter SLAVE_COUNT = 3,
    parameter ADDR_WIDTH  = 32,     
    parameter DATA_WIDTH  = 32
) (
    input   [SLAVE_COUNT - 1:0][ADDR_WIDTH - 1:0]       ms_paddr_i,
    input   [SLAVE_COUNT - 1:0]                         ms_pwrite_i,
    input   [SLAVE_COUNT - 1:0][DATA_WIDTH - 1:0]       ms_pwdata_i,

    input   [SLAVE_COUNT - 1:0]                         select,

    output logic               [ADDR_WIDTH - 1:0]       ms_paddr_o,
    output logic                                        ms_pwrite_o,
    output logic               [DATA_WIDTH - 1:0]       ms_pwdata_o
);

    genvar i;

    generate
    for(i = 0; i < SLAVE_COUNT; i++) begin
        assign ms_paddr_o  [i] = (select == (1 << i))? ms_paddr_i  : '0;
        assign ms_pwrite_o [i] = (select == (1 << i))? ms_pwrite_i : '0;
        assign ms_pwdata_o [i] = (select == (1 << i))? ms_pwdata_i : '0;    
    end
endgenerate
endmodule