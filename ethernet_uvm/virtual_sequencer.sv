`ifndef	VIRTUALSEQUENCER__SV
`define	VIRTUALSEQUENCER__SV


class virtual_sequencer  extends uvm_sequencer;
   `uvm_component_utils(virtual_sequencer);
   
   reset_sequencer seqr;
   tx_sequencer seqr_tx;

   function new(input string name, input uvm_component parent);
     super.new(name,parent);
   endfunction


endclass

`endif 
