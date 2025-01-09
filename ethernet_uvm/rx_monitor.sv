`ifndef RX_MONITOR_SV
`define RX_MONITOR_SV
`include "packet.sv"

class rx_monitor extends uvm_monitor;
   
  `uvm_component_utils(rx_monitor);

   virtual e_interface             mi;
   uvm_analysis_port #(packet)     ap;
   

   function new(input string name="RxMonitor",input uvm_component parent);
      super.new(name,parent);
   endfunction 

   virtual function void build_phase(uvm_phase phase);
      super.build_phase(phase);

      ap = new("ap", this);
      

      uvm_config_db #(virtual e_interface)::get(this,"","mi",mi);

      if(mi==null)begin
	 `uvm_fatal("CFGERR", "Virtual Interface for rx_monitor not set");
      end 
   endfunction 


   virtual task run_phase(uvm_phase phase);
      packet rcvpkt;
      
      forever begin
	 
	 rcvpkt =  packet::type_id::create("rcvpkt", this);
	 `uvm_info("RX_MONITOR run_phase()", $sformatf("%m"), UVM_HIGH);


	 @(posedge mi.clk_156m25) 
	       rcvpkt.pkt_tx_data  <= mi.cbm.pkt_tx_data;
	       rcvpkt.pkt_tx_eop  <= mi.cbm.pkt_tx_eop;
	       rcvpkt.pkt_tx_sop  <= mi.cbm.pkt_tx_sop;
	       rcvpkt.pkt_tx_mod  <= mi.cbm.pkt_tx_mod;
	       rcvpkt.pkt_tx_val  <= mi.cbm.pkt_tx_val;
	    
	 

         `uvm_info("Content of rcvpkt is", rcvpkt.sprint(), UVM_HIGH);
         `uvm_info("Got_Output_Packet", {"\n", rcvpkt.sprint()}, UVM_MEDIUM);
   
         ap.write(rcvpkt);
	 

      end
   endtask

endclass

`endif
