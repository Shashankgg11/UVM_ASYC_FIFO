class afifo_w_active_monitor extends uvm_monitor;
  `uvm_component_utils(afifo_w_active_monitor)

  uvm_analysis_port #(afifo_seq_item) w_active_port;
  virtual afifo_if vif;
  afifo_seq_item seq;

  function new(string name, uvm_component parent);
    super.new(name, parent);
    seq = new();
    w_active_port = new("w_active_port", this);
  endfunction

  function void build_phase(uvm_phase phase);
		super.build_phase(phase);
    	if(!uvm_config_db#(virtual afifo_if)::get(this, "", "vif", vif))`uvm_fatal("NOVIF",{"virtual interface must be set for: ",get_full_name(),".vif"});
  endfunction
  
  task run_phase(uvm_phase phase);
    repeat(2)@(vif.wmonitor_cb);
    forever begin
        seq.wdata  = vif.wmonitor_cb.wdata;
        seq.winc = vif.wmonitor_cb.winc;
        seq.wfull = vif.wmonitor_cb.wfull;
        w_active_port.write(seq);
        `uvm_info(get_type_name(), $sformatf("Write monitor wdata = %0d, winc = %0d wfull = %0d", vif.wmonitor_cb.wdata, vif.wmonitor_cb.winc, vif.wmonitor_cb.wfull), UVM_MEDIUM)
        repeat(1)@(vif.wmonitor_cb);
      
    end
  endtask
endclass
