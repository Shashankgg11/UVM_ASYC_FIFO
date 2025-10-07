class afifo_virtual_sequencer extends uvm_sequencer;
  `uvm_component_utils(afifo_virtual_sequencer)

  afifo_write_sequencer w_seqr;
  afifo_read_sequencer  r_seqr;
  
  function new(string name="afifo_virtual_sequencer", uvm_component parent);
    super.new(name,parent);
  endfunction
  
endclass
