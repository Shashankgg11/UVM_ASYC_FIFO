class afifo_r_agent extends uvm_agent;
  `uvm_component_utils(afifo_r_agent)

  afifo_rdriver    driver;
  afifo_read_sequencer sequencer;
  afifo_r_passive_monitor out_mon;

  virtual afifo_if vif;

  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    if(!uvm_config_db#(virtual afifo_if)::get(this, "", "vif", vif))
      `uvm_fatal("NOVIF", "No virtual interface set for write agent")
      
      sequencer = afifo_read_sequencer::type_id::create("sequencer", this);
      driver = afifo_rdriver::type_id::create("driver", this);
	  out_mon = afifo_r_passive_monitor::type_id::create("out_mon", this);
    
  endfunction

  function void connect_phase(uvm_phase phase);
      driver.seq_item_port.connect(sequencer.seq_item_export);
  endfunction
  
endclass
