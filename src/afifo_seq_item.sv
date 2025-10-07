`include "uvm_macros.svh"
import uvm_pkg ::*;

class afifo_seq_item #(parameter DSIZE = 8)extends uvm_sequence_item;
  
    rand logic[DSIZE-1:0] wdata;
	rand logic winc;
	rand logic rinc;

	logic [DSIZE-1:0] rdata;
	logic wfull, rempty;

  `uvm_object_utils_begin(afifo_seq_item)
	`uvm_field_int(wdata, UVM_ALL_ON | UVM_DEC)
  	`uvm_field_int(winc, UVM_ALL_ON | UVM_DEC)
  	`uvm_field_int(rinc, UVM_ALL_ON | UVM_DEC)
  	`uvm_field_int(rdata, UVM_ALL_ON | UVM_DEC)
  	`uvm_field_int(rempty, UVM_ALL_ON | UVM_DEC)
  	`uvm_field_int(wfull, UVM_ALL_ON | UVM_DEC)
  `uvm_object_utils_end

  function new(string name = "afifo_seq_item");
     super.new(name);
  endfunction

endclass
