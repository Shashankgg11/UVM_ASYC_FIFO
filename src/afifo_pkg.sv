`include "uvm_macros.svh"

package afifo_pkg;
  import uvm_pkg::*;

  `include "afifo_seq_item.sv"
  `include "afifo_write_seq.sv"
  `include "afifo_read_seq.sv"
  `include "afifo_write_sequencer.sv"
  `include "afifo_read_sequencer.sv"
  `include "afifo_virtual_sequencer.sv"
  `include "virtual_sequence.sv"
  `include "afifo_wdriver.sv"
  `include "afifo_rdriver.sv"
  `include "afifo_w_active_monitor.sv"
  `include "afifo_r_passive_monitor.sv"
  `include "afifo_w_agent.sv"
  `include "afifo_r_agent.sv"
  `include "afifo_scoreboard.sv"    
  `include "afifo_subscriber.sv"
  `include "afifo_env.sv"
  `include "afifo_test.sv"

endpackage
