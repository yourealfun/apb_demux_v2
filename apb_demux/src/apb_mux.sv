module apb_mux 
#(
    parameter SLAVE_COUNT = 3, 
    parameter DATA_WIDTH  = 32
) (
    input                                               sl_pready_i,
    input                       [DATA_WIDTH - 1:0]      sl_prdata_i,
    input                                               sl_pslverr_i,

    input   [SLAVE_COUNT - 1:0]                         select,

    output logic [SLAVE_COUNT - 1:0]                    sl_pready_o,
    output logic [SLAVE_COUNT - 1:0] [DATA_WIDTH - 1:0] sl_prdata_o,
    output logic [SLAVE_COUNT - 1:0]                    sl_pslverr_o
);

logic                                                   pready_arr;    //array of pready signals 
logic                           [DATA_WIDTH - 1:0]      prdata_arr;    //array of prdata signals 
logic                                                   pslverr_arr;   //array of pslverr signals

genvar i;

generate
    for(i = 0; i < SLAVE_COUNT; i++) begin
        always_comb begin
            pready_arr [i] = (select == (1 << i))? sl_pready_i  [i] : '0;
            prdata_arr [i] = (select == (1 << i))? sl_prdata_i  [i] : '0;
            pslverr_arr[i] = (select == (1 << i))? sl_pslverr_i [i] : '0;    
        end
    end
endgenerate

always_comb begin
    sl_pready_o  = '0;
    sl_prdata_o = '0;
    sl_pslverr_o = '0;
    for(int i = 0; i < SLAVE_COUNT; i++) begin
        sl_pready_o   |= pready_arr[i];
        sl_prdata_o   |= prdata_arr [i];
        sl_pslverr_o  |= pslverr_arr [i];
    end
end

endmodule
