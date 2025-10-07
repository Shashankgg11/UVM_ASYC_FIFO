class afifo_r_active_monitor extends uvm_monitor;
  `uvm_component_utils(afifo_r_active_monitor)

  uvm_analysis_port #(afifo_seq_item) r_active_port;
  virtual afifo_if vif;
  afifo_seq_item seq;

  function new(string name, uvm_component parent);
    super.new(name, parent);
    seq = new();
    r_active_port = new("r_active_port", this);
  endfunction

  function void build_phase(uvm_phase phase);
		super.build_phase(phase);
    if(!uvm_config_db#(virtual afifo_if)::get(this, "", "vif", vif))
			`uvm_fatal("NOVIF",{"virtual interface must be set for: ",get_full_name(),".vif"});
  endfunction
  
  task run_phase(uvm_phase phase);
    
    forever begin
      repeat(2)@(vif.rmonitor_cb);
        seq.rinc = vif.rmonitor_cb.rinc;
        r_active_port.write(seq);
      repeat(1)@(vif.rmonitor_cb);
      //seq.print();
    end
  endtask
endclass
