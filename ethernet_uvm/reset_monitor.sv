`ifndef RESET_MONITOR_SV
`define RESET_MONITOR_SV

class reset_monitor extends uvm_monitor;
   
  `uvm_component_utils(reset_monitor);

   function new(input string name="ResetMonitor",input uvm_component parent);
      super.new(name,parent);
   endfunction

endclass

`endif
