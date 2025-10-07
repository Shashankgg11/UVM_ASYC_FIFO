class afifo_virtual_seq extends uvm_sequence;
  `uvm_object_utils(afifo_virtual_seq)

  afifo_virtual_sequencer vseqr;
  afifo_write_seq w_seq;
  afifo_read_seq  r_seq;
  afifo_w_seq1 w_seq1;
  afifo_r_seq1 r_seq1;

  function new(string name="afifo_virtual_seq");
    super.new(name);
  endfunction

  task body();
    $cast(vseqr, m_sequencer);

    w_seq = afifo_write_seq::type_id::create("w_seq");
    r_seq = afifo_read_seq::type_id::create("r_seq");
    w_seq1 = afifo_w_seq1::type_id::create("w_seq1");
    r_seq1 = afifo_r_seq1::type_id::create("r_seq1");

    fork
      begin
        w_seq.start(vseqr.w_seqr);
        w_seq1.start(vseqr.w_seqr); 
      end
     begin
       r_seq.start(vseqr.r_seqr);
       r_seq1.start(vseqr.r_seqr);
     end
    join
  endtask
endclass
