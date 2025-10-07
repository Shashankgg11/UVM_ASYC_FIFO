interface afifo_if #(parameter DSIZE = 8)(input logic rclk, wclk, rrst_n, wrst_n);
  logic [DSIZE-1:0] rdata, wdata; 
  logic rempty, wfull;
  logic rinc, winc;
  
  
  clocking wdriver_cb@(posedge wclk);
    
		default input #0 output #0;
		output wrst_n;
		output wdata, winc;
  endclocking

  clocking wmonitor_cb@(posedge wclk);                                                                                  
		default input #0 output #0;
		input wdata, wrst_n, wfull,winc;
  endclocking

  modport WDRIVER (clocking wdriver_cb, input wclk);
  modport WMONITOR (clocking wmonitor_cb, input wclk);
    
  clocking rdriver_cb@(posedge rclk);
    
		default input #0 output #0;
		output rrst_n, rinc;
  endclocking

  clocking rmonitor_cb@(posedge rclk);                                                                                  
		default input #0 output #0;
		input rdata, rrst_n, rempty, rinc;
  endclocking

  modport RDRIVER (clocking rdriver_cb, input rclk);
  modport RMONITOR (clocking rmonitor_cb, input rclk);


endinterface
