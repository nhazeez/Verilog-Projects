`ifndef	RESET_DRIVER__SV
`define	RESET_DRIVER__SV
`include "reset_item.sv"

class reset_driver extends uvm_driver #(reset_item);
   `uvm_component_utils(reset_driver)

  // uvm_seq_item_pull_port #(reset_item)     seq_item_port;

   function new(input string name="rst_driver", input uvm_component parent);
      super.new(name, parent);
    //  seq_item_port = new("seq_item_port", this);
      
   endfunction

   virtual e_interface        vi;

   virtual function void build_phase(uvm_phase phase);
      super.build_phase(phase);

      uvm_config_db #(virtual e_interface)::get(this,"","vi",vi);

      if(vi==null)begin
	 `uvm_fatal("CFGERR", "Virtual Interface for reset_driver not set");
      end 
   endfunction 

   virtual task run_phase(uvm_phase phase);

      forever begin
	 seq_item_port.get_next_item(req);
	 `uvm_info("RESET_DRIVER run_phase()", req.sprint(), UVM_HIGH);

	 @(posedge vi.clk_156m25)  vi.reset_156m25_n <= req.reset_156m25_n;
	 repeat(req.cycles) @(posedge vi.clk_156m25);
	   vi.reset_156m25_n <= req.reset_156m25_n;

	 @(posedge vi.clk_xgmii_rx)  vi.reset_xgmii_rx_n <= req.reset_xgmii_rx_n;
	 repeat(req.cycles) @(posedge vi.clk_xgmii_rx);
	   vi.reset_xgmii_rx_n <= req.reset_xgmii_rx_n;

	 @(posedge vi.clk_xgmii_tx)  vi.reset_xgmii_tx_n <= req.reset_xgmii_tx_n;
	 repeat(req.cycles) @(posedge vi.clk_xgmii_tx);
	   vi.reset_xgmii_tx_n <= req.reset_xgmii_tx_n;

	 @(posedge vi.wb_clk_i)  vi.wb_rst_i <= req.wb_rst_i;
	 repeat(req.cycles) @(posedge vi.wb_clk_i);
	   vi.wb_rst_i <= req.wb_rst_i;
	 

	 seq_item_port.item_done();
	 

      end
      
   endtask 

   
endclass

`endif
