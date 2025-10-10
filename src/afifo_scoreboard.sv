`include "defines.sv"
`uvm_analysis_imp_decl(_w_in_sb)
`uvm_analysis_imp_decl(_r_out_sb)

class afifo_scoreboard extends uvm_component;
  `uvm_component_utils(afifo_scoreboard)

  uvm_analysis_imp_w_in_sb  #(afifo_seq_item, afifo_scoreboard)  w_in_imp;
  uvm_analysis_imp_r_out_sb #(afifo_seq_item, afifo_scoreboard)  r_out_imp;

  afifo_seq_item ref_q[$];
  int match, mismatch;

  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    w_in_imp  = new("w_in_imp",  this);
    r_out_imp = new("r_out_imp", this);
  endfunction

  function void write_w_in_sb(afifo_seq_item t);
  	afifo_seq_item#(.DSIZE(8)) item_copy;
  	item_copy = afifo_seq_item#(.DSIZE(8))::type_id::create("item_copy");
  	item_copy.copy(t);
    
    if(t.winc)begin
      if(ref_q.size() < `DEPTH)begin
        ref_q.push_back(item_copy);
        `uvm_info(get_type_name(),$sformatf("WRITE_IN: wdata=%0h (queue size=%0d)",item_copy.wdata, ref_q.size()),UVM_LOW)
      end
      else begin
        if (t.wfull) `uvm_info(get_full_name(),"FIFO FULL signal is correct",UVM_MEDIUM)
        else `uvm_info(get_full_name(),"FIFO FULL signal is not correct",UVM_MEDIUM)  
      end
     end
          
    `uvm_info(get_type_name(), $sformatf("\n***********************************************************\n\n"), UVM_LOW)   
  endfunction

  function void write_r_out_sb(afifo_seq_item t);
        
      if(t.rinc)begin
        if(ref_q.size() > 0)begin
          afifo_seq_item exp = ref_q.pop_front();
          `uvm_info(get_type_name(),$sformatf("READ (queue size=%0d)",ref_q.size()),UVM_LOW)
          if (exp.wdata === t.rdata)begin
            match++;
            `uvm_info(get_type_name(), $sformatf("match! Expected=%0d Got=%0d", exp.wdata, t.rdata), UVM_LOW)
          end
      
          else begin
            mismatch++;
            `uvm_error(get_type_name(), $sformatf("Mismatch! Expected=%0d Got=%0d", exp.wdata, t.rdata))
          end
        end
        else begin
          if(t.rempty) `uvm_info(get_full_name(),"FIFO EMPTY signal is correct",UVM_MEDIUM)
          else `uvm_info(get_full_name(),"FIFO EMPTY signal is not correct",UVM_MEDIUM)  
        end
     end
          
    
    `uvm_info(get_type_name(), $sformatf("\n MATCH = %0d   MISMATCH = %0d", match, mismatch), UVM_LOW)   
    `uvm_info(get_type_name(), $sformatf("\n***********************************************************\n \n***********************************************************\n \n"), UVM_LOW)   
  endfunction

endclass
