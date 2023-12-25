interface apb_if
    #(DATA_WIDTH = 32, ADDR_WIDTH = 32)
    ();
        logic [ADDR_WIDTH - 1:0] PADDR;
        logic PSELx;
        logic PENABLE;
        logic PWRITE;
        logic [DATA_WIDTH - 1:0] PWDATA;
        logic PREADY;
        logic [DATA_WIDTH - 1:0] PRDATA;
        logic PSLVERR;

        
        modport apb_s(
            input   PSELx,
                    PENABLE,
                    PADDR,
                    PWRITE,
                    PWDATA,
            output  PREADY, 
                    PRDATA, 
                    PSLVERR
        );

        modport apb_m(
            input   PRDATA, 
                    PREADY, 
                    PSLVERR,
            output  PSELx,
                    PENABLE,
                    PADDR,
                    PWRITE,
                    PWDATA
        );
endinterface