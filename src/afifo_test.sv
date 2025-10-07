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
class test1 extends afifo_base_test;
  `uvm_component_utils(test1)

  function new(string name = "test1", uvm_component parent = null);
		super.new(name, parent);
	endfunction

	virtual task run_phase(uvm_phase phase);
      
	  afifo_virtual_seq vseq;
	  super.run_phase(phase);
	  phase.raise_objection(this, "Objection Raised");
      //repeat(20)begin
		vseq = afifo_virtual_seq::type_id::create("vseq");
    	vseq.start(env.vseqr);
      //end
	  phase.drop_objection(this, "Objection Dropped");
	endtask

	virtual function void end_of_elaboration();
		print();
	endfunction
endclass
