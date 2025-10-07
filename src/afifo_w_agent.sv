class afifo_w_agent extends uvm_agent;
  `uvm_component_utils(afifo_w_agent)

  afifo_wdriver    driver;
  afifo_write_sequencer sequencer;
  afifo_w_active_monitor in_mon;

  virtual afifo_if vif;

  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    if(!uvm_config_db#(virtual afifo_if)::get(this, "", "vif", vif))
      `uvm_fatal("NOVIF", "No virtual interface set for write agent")
      
      sequencer = afifo_write_sequencer::type_id::create("sequencer", this);
      driver = afifo_wdriver::type_id::create("driver", this);
      in_mon = afifo_w_active_monitor::type_id::create("in_mon", this);
    
  endfunction

  function void connect_phase(uvm_phase phase);
    	driver.seq_item_port.connect(sequencer.seq_item_export);
  endfunction
  
endclass
