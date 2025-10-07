class afifo_rdriver extends uvm_driver #(afifo_seq_item);

	virtual afifo_if rvif;
	afifo_seq_item seq;

    `uvm_component_utils(afifo_rdriver)
  
    function new(string name = "afifo_rdriver", uvm_component parent);
		super.new(name, parent);
	endfunction

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
      if(!uvm_config_db #(virtual afifo_if)::get(this,"","vif",rvif))
        `uvm_error(get_type_name(), $sformatf("Failed to get RVIF"))
	endfunction

	virtual task run_phase(uvm_phase phase);
      //repeat(2) @(vif.driver_cb);
		forever 
		begin
            //@(vif.driver_cb);
			seq_item_port.get_next_item(seq);
			drive();
            //@(vif.driver_cb);
			seq_item_port.item_done();
		end
	endtask

	virtual task drive();
      repeat(1) @(rvif.rdriver_cb);
		rvif.rdriver_cb.rinc <= seq.rinc;
      //repeat(1) @(rvif.driver_cb);
      `uvm_info(get_type_name(), $sformatf("RDRIVER: rinc = %0d ", rvif.rdriver_cb.rinc), UVM_MEDIUM)
      //repeat(2) @(rvif.driver_cb);
      //seq.print();
	endtask
endclass
