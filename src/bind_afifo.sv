bind FIFO afifo_assertions afifo_assert_inst (
  .wclk(wclk),
  .rclk(rclk),
  .wrst_n(wrst_n),
  .rrst_n(rrst_n),
  .wdata(wdata),
  .rdata(rdata),
  .winc(winc),
  .rinc(rinc),
  .wfull(wfull),
  .rempty(rempty)
);
