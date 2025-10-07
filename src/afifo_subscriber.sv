`uvm_analysis_imp_decl(_w_in_sub)
`uvm_analysis_imp_decl(_w_out_sub)
`uvm_analysis_imp_decl(_r_in_sub)
`uvm_analysis_imp_decl(_r_out_sub)


class afifo_subscriber extends uvm_component;
  `uvm_component_utils(afifo_subscriber)

    uvm_analysis_imp_w_in_sub  #(afifo_seq_item, afifo_subscriber)  aport_w_in;
    uvm_analysis_imp_w_out_sub #(afifo_seq_item, afifo_subscriber)  aport_w_out;
    uvm_analysis_imp_r_in_sub  #(afifo_seq_item, afifo_subscriber)  aport_r_in;
    uvm_analysis_imp_r_out_sub #(afifo_seq_item, afifo_subscriber)  aport_r_out;

  afifo_seq_item trans_w_in, trans_w_out, trans_r_in, trans_r_out;
  afifo_seq_item ref_q[$];

  real cov_w_in, cov_w_out, cov_r_in, cov_r_out;

  covergroup cov_write_in;
    data_cp: coverpoint trans_w_in.wdata;
  endgroup

  covergroup cov_write_out;
    full_cp: coverpoint trans_w_out.wfull;
  endgroup

  covergroup cov_read_in;
    rinc_cp: coverpoint trans_r_in.rinc;
  endgroup

  covergroup cov_read_out;
    data_cp: coverpoint trans_r_out.rdata;
    empty_cp: coverpoint trans_r_out.rempty;
  endgroup

  function new(string name="afifo_subscriber", uvm_component parent=null);
    super.new(name, parent);
    aport_w_in  = new("aport_w_in", this);
    aport_w_out = new("aport_w_out", this);
    aport_r_in  = new("aport_r_in", this);
    aport_r_out = new("aport_r_out", this);

    cov_write_in  = new();
    cov_write_out = new();
    cov_read_in   = new();
    cov_read_out  = new();
  endfunction

  function void write_w_in_sub(afifo_seq_item t);
    trans_w_in = t;
    ref_q.push_back(t);
    cov_write_in.sample();
    //`uvm_info(get_type_name(), $sformatf("WRITE_IN: wdata=%0h", t.wdata), UVM_MEDIUM)
  endfunction

  function void write_w_out_sub(afifo_seq_item t);
    trans_w_out = t;
    cov_write_out.sample();
    //`uvm_info(get_type_name(), $sformatf("WRITE_OUT: wfull=%0b", t.wfull), UVM_MEDIUM)
  endfunction

  function void write_r_in_sub(afifo_seq_item t);
    trans_r_in = t;
    cov_read_in.sample();
    //`uvm_info(get_type_name(), $sformatf("READ_IN: rinc=%0b rempty=%0b", t.rinc, t.rempty), UVM_MEDIUM)
  endfunction

  function void write_r_out_sub(afifo_seq_item t);
    trans_r_out = t;
    cov_read_out.sample();
//     if (ref_q.size() == 0) begin
//       `uvm_error(get_type_name(), "READ_OUT when queue empty!")
//     end else begin
//       afifo_seq_item exp = ref_q.pop_front();
//       if (exp.rdata !== t.rdata)
//         `uvm_error(get_type_name(), $sformatf("Mismatch! Expected %0h, Got %0h", exp.rdata, t.rdata))
//       else
//         `uvm_info(get_type_name(), $sformatf("PASS: Read matched %0h", t.rdata), UVM_LOW)
//     end
  endfunction

  function void extract_phase(uvm_phase phase);
    super.extract_phase(phase);
    cov_w_in  = cov_write_in.get_coverage();
    cov_w_out = cov_write_out.get_coverage();
    cov_r_in  = cov_read_in.get_coverage();
    cov_r_out = cov_read_out.get_coverage();
  endfunction

  function void report_phase(uvm_phase phase);
    super.report_phase(phase);
    `uvm_info(get_type_name(), $sformatf("[COV] Write_In  = %0.2f", cov_w_in),  UVM_MEDIUM)
    `uvm_info(get_type_name(), $sformatf("[COV] Write_Out = %0.2f", cov_w_out), UVM_MEDIUM)
    `uvm_info(get_type_name(), $sformatf("[COV] Read_In   = %0.2f", cov_r_in),  UVM_MEDIUM)
    `uvm_info(get_type_name(), $sformatf("[COV] Read_Out  = %0.2f", cov_r_out), UVM_MEDIUM)
  endfunction
endclass
