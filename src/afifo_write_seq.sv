class afifo_write_seq extends uvm_sequence #(afifo_seq_item);
  `uvm_object_utils(afifo_write_seq)
  function new(string name="afifo_write_seq"); 
    super.new(name); 
  endfunction
  
  task body();
    afifo_seq_item req;
    repeat (100) begin
      req = afifo_seq_item#(.DSIZE(8))::type_id::create("req");
      start_item(req);
      req.randomize() with { winc == 1;};
      finish_item(req);
    end
  endtask
endclass

class afifo_w_seq1 extends uvm_sequence #(afifo_seq_item);
  `uvm_object_utils(afifo_w_seq1)
  function new(string name="afifo_w_seq1"); 
    super.new(name); 
  endfunction
  
  task body();
    afifo_seq_item req;
    repeat (100) begin
      req = afifo_seq_item#(.DSIZE(8))::type_id::create("req");
      start_item(req);
      req.randomize() with { winc == 0;};
      finish_item(req);
    end
  endtask
endclass
