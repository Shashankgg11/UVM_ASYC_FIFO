class afifo_env extends uvm_env;
  afifo_w_agent w_active_agent;
  afifo_r_agent r_active_agent;
  afifo_scoreboard scoreboard;
  afifo_subscriber subscriber;
  afifo_virtual_sequencer vseqr;

  `uvm_component_utils(afifo_env)

  function new(string name = "afifo_env", uvm_component parent);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    
    w_active_agent = afifo_w_agent::type_id::create("w_active_agent", this);
    r_active_agent = afifo_r_agent::type_id::create("r_active_agent", this);
    scoreboard = afifo_scoreboard::type_id::create("scoreboard", this);
    subscriber = afifo_subscriber::type_id::create("subscriber", this);
    vseqr   = afifo_virtual_sequencer::type_id::create("vseqr", this);
  endfunction

  function void connect_phase(uvm_phase phase);
    w_active_agent.in_mon.w_active_port.connect(scoreboard.w_in_imp);
    r_active_agent.out_mon.r_passive_port.connect(scoreboard.r_out_imp);
    w_active_agent.in_mon.w_active_port.connect(subscriber.aport_w_in);
    r_active_agent.out_mon.r_passive_port.connect(subscriber.aport_r_out);
    vseqr.w_seqr = w_active_agent.sequencer;
    vseqr.r_seqr = r_active_agent.sequencer;
  endfunction
  
endclass
