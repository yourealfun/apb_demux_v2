module decoder
# ( 
    parameter SLAVE_COUNT  =  3,
    parameter ADDR_WIDTH   =  32,
    parameter SLAVE_REG_N  =  32, // Number af regs in 1 slave
    parameter SLAVE_OFFSET =  32, // Shift of one slave of base addr of other slave
    parameter BASE_OFFSET  =  0   // Base addr of first slave
    ) 
(
    input           [ADDR_WIDTH-1:0]  paddr_i,
    output logic    [SLAVE_COUNT-1:0] select_o
);

genvar i;
generate
    for(i = 0; i < SLAVE_COUNT; i++) begin
        assign select_o [i] = (paddr_i >=  (BASE_OFFSET + SLAVE_OFFSET * i)) &&
                              (paddr_i <   (BASE_OFFSET + SLAVE_OFFSET * i + SLAVE_REG_N));    
    end
endgenerate
endmodule   