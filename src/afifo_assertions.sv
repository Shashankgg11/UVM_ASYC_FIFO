interface afifo_assertions(input logic wclk, wrst_n, winc, wfull, rclk, rrst_n, rinc, rempty, input logic [7:0] wdata, input logic [7:0] rdata);

    property wrst_check;
        @(posedge wclk) (!wrst_n) |-> (wfull == 0);
    endproperty

    property winc_stable;
        @(posedge wclk) disable iff (!wrst_n)
            (!winc) |=> $stable(wfull);
    endproperty

    property rrst_check;
        @(posedge rclk) (!rrst_n) |-> (rempty == 1) && (rdata == 0);
    endproperty

    property rinc_stable;
        @(posedge rclk) disable iff (!rrst_n)
            (!rinc) |=> ($stable(rdata) && $stable(rempty));
    endproperty


    assert property(wrst_check)
        $display("WRITE RESET asserted correctly");
    else
        $display("WRITE RESET check FAILED");

    assert property(winc_stable)
      $display("Write data or wfull stable when winc=0");
    else
      $display("Write data or wfull not stable when winc=0");


    assert property(rrst_check)
        $display("READ RESET asserted correctly");
    else
        $display("READ RESET check FAILED");

    assert property(rinc_stable)
      $display("Read data or rempty stable when rinc=0");
    else
      $display("Read data or rempty not stable when rinc=0");

endinterface
