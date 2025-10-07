`include "defines.sv"
`include "afifo_write_if.sv"
`include "afifo_read_if.sv"
`include "afifo_pkg.sv"
`include "design.sv"
//`include "uvm_macros.svh"

import uvm_pkg::*;
import afifo_pkg::*;

module top();
  
  localparam DSIZE = 8;
  localparam ASIZE = 4;
  
  bit wclk, rclk, wrst_n, rrst_n;

  afifo_write_if wvif(wclk, wrst_n);
  afifo_read_if  rvif(rclk, rrst_n);

  FIFO DUT(
    .wclk(wclk),
    .wrst_n(wrst_n),
    .wdata  (wvif.wdata),
    .winc  (wvif.winc),
    .wfull  (wvif.wfull),
    
    .rclk(rclk),
    .rrst_n (rrst_n),
    .rdata  (rvif.rdata),
    .rinc  (rvif.rinc),
    .rempty (rvif.rempty)
  );

  always #10  wclk = ~wclk;
  always #20  rclk = ~rclk;

  initial
  begin
    wclk = 0;
    rclk = 0;
    wvif.winc=0;
    rvif.rinc=0;
    wrst_n = 0;
    rrst_n = 0;
    #10;
    wrst_n = 1;
    rrst_n = 1;
  end

  initial
  begin
    uvm_config_db #(virtual afifo_write_if)::set(uvm_root::get(),"*","vif",wvif);
    uvm_config_db #(virtual afifo_read_if)::set(uvm_root::get(),"*","vif",rvif);

    $dumpfile("dump.vcd");
    $dumpvars;
  end

  initial
  begin
    run_test("random_test");
    #100 $finish;
  end
 endmodule
