`ifndef	RESET_AGENT__SV
`define	RESET_AGENT__SV
`include "reset_driver.sv"
`include "reset_monitor.sv"
`include "reset_item.sv"

typedef	uvm_sequencer #(reset_item)	reset_sequencer;

class reset_agent extends uvm_agent;
   `uvm_component_utils(reset_agent)

   reset_sequencer seqr;
   reset_driver drv;
   reset_monitor mon;
   

   function new(input string name="ResetAgent", input uvm_component parent);
     super.new(name,parent);
   endfunction 

   virtual function void build_phase(input uvm_phase phase);
     
     super.build_phase(phase);
     if(is_active==UVM_ACTIVE) begin
	seqr = reset_sequencer::type_id::create("seqr",this);
	drv = reset_driver::type_id::create("drv", this);
     end
     mon = reset_monitor::type_id::create("mon", this);
      
      
   endfunction 

   virtual function void connect_phase(input uvm_phase phase);
     
     super.connect_phase(phase);
     if(is_active==UVM_ACTIVE) begin
	drv.seq_item_port.connect(seqr.seq_item_export);
     end
      
      
   endfunction 
   
endclass

`endif 
