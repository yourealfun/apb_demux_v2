module apb_demux #(
    parameter MSTR_PORT_N = 3
) (
    apb_if.apb_s                     slv,
    apb_if.apb_m  [MSTR_PORT_N-1:0]  mst
);

    always_comb begin
        //generate
        for (i = 1, i < MSTR_PORT_N, i++) begin
            mstr[i].paddr   = slv.paddr;
            mstr[i].pwrite  = slv.pwrite;
            mstr[i].pwdata  = slv.pwdata;
            mstr[i].penable = slv.penable;
        end
    end

    decode_addr u_dec(
        //signal for demux
        //signal for mux
        //signal if addr is invalid (not match with any master port)
    );



    // psel demux
    // recieves signal for demux from decoder
    
    generate;
        for (i =1, i<MSTR_PORT_N, i++) begin
            mstr[i].psel   =  signal_from_dec_for_demux == slv_addr[i] ? slv.sel : '0;
        end
    endgenerate

    //mux  for signals from slaves
    always_comb begin
        case (signal_from_dec_for_mux)
            slv1_addr: begin
                slv.pready  = mstr[1].pready;
                slv.prdata  = mstr[1].prdata;
                slv.pslverr = mstr[1].pslverr;
            end

            //...

            default: begin
                slv.pready  = '1;
                slv.prdata  = '0;
                slv.pslverr = '1;
            end
        endcase
    end



endmodule