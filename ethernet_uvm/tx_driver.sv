`ifndef	TX_DRIVER__SV
`define	TX_DRIVER__SV
`include "packet.sv"

class tx_driver extends uvm_driver #(packet);
   `uvm_component_utils(tx_driver)

  // uvm_seq_item_pull_port #(packet)     seq_item_port;

   function new(input string name="tx_driver", input uvm_component parent);
      super.new(name, parent);
     
   endfunction

   virtual e_interface        vi;

   virtual function void build_phase(uvm_phase phase);
      super.build_phase(phase);

      uvm_config_db #(virtual e_interface)::get(this,"","vi",vi);

      if(vi==null)begin
	 `uvm_fatal("CFGERR", "Virtual Interface for tx_driver not set");
      end 
   endfunction 

   virtual task run_phase(uvm_phase phase);

      forever begin
	 seq_item_port.get_next_item(req);
	 `uvm_info("TX_DRIVER run_phase()", req.sprint(), UVM_HIGH);

	 forever begin

	  @(posedge vi.clk_156m25) 
	    if(!vi.pkt_tx_full) begin
	       vi.cbd.pkt_tx_data  <= req.pkt_tx_data;
	       vi.cbd.pkt_tx_eop  <= req.pkt_tx_eop;
	       vi.cbd.pkt_tx_sop  <= req.pkt_tx_sop;
	       vi.cbd.pkt_tx_mod  <= req.pkt_tx_mod;
	       vi.cbd.pkt_tx_val  <= req.pkt_tx_val;
	       break;
	       
	    end
	 end

	 seq_item_port.item_done();
	 

      end
      
   endtask 

   
endclass

`endif
