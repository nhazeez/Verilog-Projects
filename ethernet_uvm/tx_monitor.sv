`ifndef TX_MONITOR_SV
`define TX_MONITOR_SV
`include "packet.sv"

class tx_monitor extends uvm_monitor;
   
  `uvm_component_utils(tx_monitor);

   virtual e_interface             mi;
   uvm_analysis_port #(packet)     ap;
   

   function new(input string name="TxMonitor",input uvm_component parent);
      super.new(name,parent);
   endfunction 

   virtual function void build_phase(uvm_phase phase);
      super.build_phase(phase);

      ap = new("ap", this);
      

      uvm_config_db #(virtual e_interface)::get(this,"","mi",mi);

      if(mi==null)begin
	 `uvm_fatal("CFGERR", "Virtual Interface for tx_monitor not set");
      end 
   endfunction 


   virtual task run_phase(uvm_phase phase);
      packet drvpkt;
      
      forever begin
	 
	 drvpkt =  packet::type_id::create("drvpkt", this);
	 `uvm_info("TX_MONITOR run_phase()", $sformatf("%m"), UVM_HIGH);


	 @(posedge mi.clk_156m25) 
	       drvpkt.pkt_tx_data  <= mi.cbm.pkt_tx_data;
	       drvpkt.pkt_tx_eop  <= mi.cbm.pkt_tx_eop;
	       drvpkt.pkt_tx_sop  <= mi.cbm.pkt_tx_sop;
	       drvpkt.pkt_tx_mod  <= mi.cbm.pkt_tx_mod;
	       drvpkt.pkt_tx_val  <= mi.cbm.pkt_tx_val;
	    
	 

         `uvm_info("Content of drvpkt is", drvpkt.sprint(), UVM_HIGH);
         `uvm_info("Got_Input_Packet", {"\n", drvpkt.sprint()}, UVM_MEDIUM);
   
         ap.write(drvpkt);
	 

      end
   endtask

endclass

`endif
