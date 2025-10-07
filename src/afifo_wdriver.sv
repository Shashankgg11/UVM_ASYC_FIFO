class afifo_wdriver extends uvm_driver #(afifo_seq_item);

	virtual afifo_if wvif;
	afifo_seq_item seq;

    `uvm_component_utils(afifo_wdriver)

    function new(string name = "afifo_wdriver", uvm_component parent);
		super.new(name, parent);
	endfunction

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
      if(!uvm_config_db #(virtual afifo_if)::get(this,"","vif",wvif))
        `uvm_error(get_type_name(), $sformatf("Failed to get WVIF"))
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
      repeat(1) @(wvif.wdriver_cb);
		wvif.wdriver_cb.wdata <= seq.wdata;
		wvif.wdriver_cb.winc <= seq.winc;
      `uvm_info(get_type_name(), $sformatf("*********************DRiver******************\n DRIVER:, wdata = %0d, winc = %0d", wvif.wdriver_cb.wdata, wvif.wdriver_cb.winc), UVM_MEDIUM)
      //repeat(2) @(wvif.driver_cb);
      //seq.print();
	endtask
endclass
