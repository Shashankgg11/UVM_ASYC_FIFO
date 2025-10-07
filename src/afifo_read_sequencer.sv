class afifo_read_sequencer extends uvm_sequencer #(afifo_seq_item);
  `uvm_component_utils(afifo_read_sequencer)
  
  function new(string name = "afifo_read_sequencer", uvm_component parent);
    super.new(name, parent);
  endfunction
endclass
