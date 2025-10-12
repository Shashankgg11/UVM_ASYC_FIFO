class afifo_base_test extends uvm_test;
	afifo_env env;

  `uvm_component_utils(afifo_base_test)

  function new(string name = "afifo_base_test", uvm_component parent = null);
	super.new(name, parent);
	endfunction

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		env = afifo_env::type_id::create("env", this);
	endfunction

	virtual function void end_of_elaboration();
		print();
	endfunction
endclass

//---------------------------------------------------------------------------------------------------------
class write_only_test extends afifo_base_test;
  `uvm_component_utils(write_only_test)
  
  function new(string name = "write_only_test", uvm_component parent = null);
	super.new(name, parent);
  endfunction

  task run_phase(uvm_phase phase);
    afifo_virtual_seq vseq;
    phase.raise_objection(this);

    vseq = afifo_virtual_seq::type_id::create("vseq");
    vseq.run_write = 1;
    vseq.run_read  = 0;
    vseq.run_write_read_parallel  = 0;
    vseq.run_write_after_read  = 0;

    vseq.start(env.vseqr);

    phase.drop_objection(this);
  endtask
endclass


class read_only_test extends afifo_base_test;
  `uvm_component_utils(read_only_test)
  
  function new(string name = "read_only_test", uvm_component parent = null);
	super.new(name, parent);
  endfunction

  task run_phase(uvm_phase phase);
    afifo_virtual_seq vseq;
    phase.raise_objection(this);

    vseq = afifo_virtual_seq::type_id::create("vseq");
    vseq.run_write = 0;
    vseq.run_read  = 1;
    vseq.run_write_read_parallel  = 0;
    vseq.run_write_after_read  = 0;

    vseq.start(env.vseqr);

    phase.drop_objection(this);
  endtask
endclass

class write_read_par_test extends afifo_base_test;
  `uvm_component_utils(write_read_par_test)
  
  function new(string name = "write_read_par_test", uvm_component parent = null);
	super.new(name, parent);
  endfunction

  task run_phase(uvm_phase phase);
    afifo_virtual_seq vseq;
    phase.raise_objection(this);

    vseq = afifo_virtual_seq::type_id::create("vseq");
    vseq.run_write = 0;
    vseq.run_read  = 0;
    vseq.run_write_read_parallel  = 1;
    vseq.run_write_after_read  = 0; 

    vseq.start(env.vseqr);

    phase.drop_objection(this);
  endtask
endclass

class write_after_read_test extends afifo_base_test;
  `uvm_component_utils(write_after_read_test)
  
  function new(string name = "write_after_read_test", uvm_component parent = null);
	super.new(name, parent);
  endfunction

  task run_phase(uvm_phase phase);
    afifo_virtual_seq vseq;
    phase.raise_objection(this);

    vseq = afifo_virtual_seq::type_id::create("vseq");
    vseq.run_write = 0;
    vseq.run_read  = 0;
    vseq.run_write_read_parallel  = 0;
    vseq.run_write_after_read  = 1; 

    vseq.start(env.vseqr);

    phase.drop_objection(this);
  endtask
endclass


