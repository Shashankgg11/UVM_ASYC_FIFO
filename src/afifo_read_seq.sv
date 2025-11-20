class afifo_read_seq extends uvm_sequence #(afifo_seq_item);
  `uvm_object_utils(afifo_read_seq)
  function new(string name="afifo_read_seq"); 
    super.new(name); 
  endfunction
  
  task body();
    afifo_seq_item req;
    repeat (30) begin
      req = afifo_seq_item#(.DSIZE(8))::type_id::create("req");
      start_item(req);
      void'(req.randomize() with { rinc == 1;});
      finish_item(req);
    end
  endtask
endclass

class afifo_r_seq1 extends uvm_sequence #(afifo_seq_item);
  `uvm_object_utils(afifo_r_seq1)
  function new(string name="afifo_r_seq1"); 
    super.new(name); 
  endfunction
  
  task body();
    afifo_seq_item req;
    repeat (30) begin
      req = afifo_seq_item#(.DSIZE(8))::type_id::create("req");
      start_item(req);
      void'(req.randomize() with { rinc == 0;});
      finish_item(req);
    end
  endtask
endclass
