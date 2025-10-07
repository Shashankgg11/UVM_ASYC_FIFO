class afifo_w_passive_monitor extends uvm_monitor;
  `uvm_component_utils(afifo_w_passive_monitor)
  
  uvm_analysis_port #(afifo_seq_item) w_passive_port;
  virtual afifo_if vif;
  afifo_seq_item seq;

  function new(string name, uvm_component parent);
    super.new(name, parent);
    seq = new();
    w_passive_port = new("w_passive_port", this);
  endfunction
  
  function void build_phase(uvm_phase phase);
		super.build_phase(phase);
    if(!uvm_config_db#(virtual afifo_if)::get(this, "", "vif", vif))
			`uvm_fatal("NOVIF",{"virtual interface must be set for: ",get_full_name(),".vif"});
  endfunction

  task run_phase(uvm_phase phase);
    
    forever begin
      repeat(2)@(vif.wmonitor_cb);
      seq.wfull = vif.wmonitor_cb.wfull;
      w_passive_port.write(seq);
      //seq.print();
      repeat(1)@(vif.wmonitor_cb);
    end
  endtask
endclass
