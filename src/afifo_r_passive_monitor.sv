class afifo_r_passive_monitor extends uvm_monitor;
  `uvm_component_utils(afifo_r_passive_monitor)
  
  uvm_analysis_port #(afifo_seq_item) r_passive_port;
  virtual afifo_if vif;
  afifo_seq_item seq;

  function new(string name, uvm_component parent);
    super.new(name, parent);
    seq = new();
    r_passive_port = new("r_passive_port", this);
  endfunction
  
  function void build_phase(uvm_phase phase);
		super.build_phase(phase);
    if(!uvm_config_db#(virtual afifo_if)::get(this, "", "vif", vif))
			`uvm_fatal("NOVIF",{"virtual interface must be set for: ",get_full_name(),".vif"});
  endfunction

  task run_phase(uvm_phase phase);
    repeat(4)@(vif.rmonitor_cb);
    forever begin
      //repeat(3)@(vif.monitor_cb);
      seq.rdata = vif.rmonitor_cb.rdata;
      seq.rempty = vif.rmonitor_cb.rempty;
      r_passive_port.write(seq);
      //seq.print();
      `uvm_info(get_type_name(), $sformatf("*********************w_passive_monitor******************\n rempty_n = %0d, rdata = %0d", vif.rmonitor_cb.rempty, vif.rmonitor_cb.rdata), UVM_MEDIUM)
      repeat(2)@(vif.rmonitor_cb);
    end
  endtask
endclass
