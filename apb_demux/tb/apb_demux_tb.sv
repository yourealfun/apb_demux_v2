`timescale 1ns/1ps

module apb_demux_tb ();
   localparam SLAVE_COUNT = 3;
   apb_if IF ();
   bit clk,
       rstn;

   always #5 clk = ~clk;

   apb_demux_top demux
    (
    .PRESETn (rstn),  
    .PCLK (clk),
    .slv  (IF.apb_s),
    .mstr (IF.apb_m)
   )

  //  task apb_write(addr, data);
  //   apb.mstr.PADDR   =  addr;
  //   apb.mstr.PWDATA  =  data;
  //   @(posedge clk);
  //   apb.mstr.PWRITE  = 1;
  //   apb.mstr.PSELx    = 1;
  //   @(posedge clk);
  //   apb.mstr.PENABLE = 1;
  //   @(posedge clk);
  //   apb.mstr.PENABLE = 0;
  //   apb.mstr.PSELx    = 0;
  // endtask

  // task apb_read(addr);
  //   apb.mstr.PADDR   =  addr;
  //   @(posedge clk);
  //   apb.mstr.PWRITE  = 0;
  //   apb.mstr.PSELx    = 1;
  //   @(posedge clk);
  //   apb.mstr.PENABLE = 1;
  //   @(posedge clk);
  //   apb.mstr.PENABLE = 0;
  //   apb.mstr.PSELx    = 0;
  //   apb_rd_data      = apb.mstr.PRDATA;
  // endtask

   initial begin
    clk <= 0;
    rstn <= 0;
    #25
    rstn <=1; 
    #1000
    $finish ;
   end

  // initial begin
  //   #50 
  //   apb_write(10, 50);
  //   #50 
  //   apb_read(10, 50);
  // end


endmodule
