`ifndef	TX_AGENT__SV
`define	TX_AGENT__SV
`include "tx_driver.sv"
`include "tx_monitor.sv"
`include "packet.sv"

typedef	uvm_sequencer #(packet)	tx_sequencer;

class tx_agent extends uvm_agent;
   `uvm_component_utils(tx_agent)

   tx_sequencer seqr_tx;
   tx_driver drv_tx;
   tx_monitor mon_tx;

   uvm_analysis_port #(packet)    analysis_port;
   

   function new(input string name="TxAgent", input uvm_component parent);
     super.new(name,parent);
   endfunction 

   virtual function void build_phase(input uvm_phase phase);
     
     super.build_phase(phase);
     if(is_active==UVM_ACTIVE) begin
//	seqr = reset_sequencer::type_id::create("seqr",this);
//	drv = reset_driver::type_id::create("drv", this);

	seqr_tx = tx_sequencer::type_id::create("seqr_tx",this);
	drv_tx = tx_driver::type_id::create("drv_tx", this);
     end
     mon_tx = tx_monitor::type_id::create("mon_tx", this);
     
     analysis_port=new("analysis_port", this);
      
      
      
   endfunction 

   virtual function void connect_phase(input uvm_phase phase);
     
     super.connect_phase(phase);
     if(is_active==UVM_ACTIVE) begin
//	drv.seq_item_port.connect(seqr.seq_item_export);      // reset
	drv_tx.seq_item_port.connect(seqr_tx.seq_item_export); //tx

     end
     mon_tx.ap.connect(this.analysis_port);
      
      
   endfunction 
   
endclass

`endif 
