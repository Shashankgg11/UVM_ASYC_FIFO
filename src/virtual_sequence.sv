class afifo_virtual_seq extends uvm_sequence;
  `uvm_object_utils(afifo_virtual_seq)

  afifo_virtual_sequencer vseqr;
  afifo_write_seq w_seq;
  afifo_read_seq  r_seq;
  afifo_w_seq1 w_seq1;
  afifo_r_seq1 r_seq1;

  bit run_write = 1;
  bit run_read  = 1;
  bit run_write_read_parallel  = 1;
  bit run_write_after_read  = 1;

  function new(string name="afifo_virtual_seq");
    super.new(name);
  endfunction

  task body();
    $cast(vseqr, m_sequencer);

    if (run_write) begin
      w_seq  = afifo_write_seq::type_id::create("w_seq");
    end
    else if (run_read) begin
      r_seq  = afifo_read_seq::type_id::create("r_seq");
    end
    else if (run_write_read_parallel) begin
      w_seq  = afifo_write_seq::type_id::create("w_seq");
      r_seq  = afifo_read_seq::type_id::create("r_seq");
    end
    else begin
      w_seq  = afifo_write_seq::type_id::create("w_seq");
      r_seq  = afifo_read_seq::type_id::create("r_seq");
    end
    
    if (run_write) begin
      w_seq.start(vseqr.w_seqr);
    end
    
    else if (run_read) begin
     r_seq.start(vseqr.r_seqr);
    end
    
    else if (run_write_read_parallel) begin
      fork
        w_seq.start(vseqr.w_seqr);
        r_seq.start(vseqr.r_seqr);
      join
    end
    
    else begin
      begin
        w_seq.start(vseqr.w_seqr);
        r_seq.start(vseqr.r_seqr);
      end
    end

  endtask
endclass

