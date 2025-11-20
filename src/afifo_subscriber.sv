`uvm_analysis_imp_decl(_w_in_sub)
`uvm_analysis_imp_decl(_r_out_sub)

class afifo_subscriber extends uvm_component;
  `uvm_component_utils(afifo_subscriber)

  uvm_analysis_imp_w_in_sub  #(afifo_seq_item, afifo_subscriber)  aport_w_in;
  uvm_analysis_imp_r_out_sub #(afifo_seq_item, afifo_subscriber)  aport_r_out;

  afifo_seq_item trans_w_in, trans_r_out;

  covergroup cov_write_in;
    option.per_instance = 1;
    wdata_cp : coverpoint trans_w_in.wdata {
      bins low   = {[0:63]};
      bins mid   = {[64:127]};
      bins high  = {[128:255]};
    }
    winc_cp : coverpoint trans_w_in.winc {
      bins winc0 = {0};
      bins winc1 = {1};
    }
    full_cp : coverpoint trans_w_in.wfull {
      bins not_full = {0};
      bins full     = {1};
    }
    
  endgroup

  covergroup cov_read_out;
    option.per_instance = 1;
    rdata_cp : coverpoint trans_r_out.rdata {
      bins low   = {[0:63]};
      bins mid   = {[64:127]};
      bins high  = {[128:255]};
    }
    rinc_cp : coverpoint trans_r_out.rinc {
      bins rinc0 = {0};
      bins rinc1 = {1};
    }
    empty_cp : coverpoint trans_r_out.rempty {
      bins not_empty = {0};
      bins empty     = {1};
    }
    
  endgroup

  real cov_w_in, cov_r_out;

  function new(string name="afifo_subscriber", uvm_component parent=null);
    super.new(name, parent);
    aport_w_in  = new("aport_w_in", this);
    aport_r_out = new("aport_r_out", this);
    cov_write_in = new();
    cov_read_out = new();
  endfunction

  function void write_w_in_sub(afifo_seq_item t);
    trans_w_in = t;
    cov_write_in.sample();
  endfunction

  function void write_r_out_sub(afifo_seq_item t);
    trans_r_out = t;
    cov_read_out.sample();
  endfunction

  function void extract_phase(uvm_phase phase);
    cov_w_in  = cov_write_in.get_coverage();
    cov_r_out = cov_read_out.get_coverage();
  endfunction

  function void report_phase(uvm_phase phase);
    `uvm_info(get_type_name(), $sformatf("[COV] Write_In = %0.2f%%", cov_w_in),  UVM_MEDIUM)
    `uvm_info(get_type_name(), $sformatf("[COV] Read_Out = %0.2f%%", cov_r_out), UVM_MEDIUM)
  endfunction

endclass
