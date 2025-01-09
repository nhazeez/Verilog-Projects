`ifndef RESET_SEQUENCE_SV
`define RESET_SEQUENCE_SV

`include "reset_item.sv"

class reset_sequence extends uvm_sequence #(reset_item);
   `uvm_object_utils(reset_sequence);

   function new(input string name="rst_seq");
     super.new(name);

     `uvm_info("RESET_SEQUENCE CLASS", $sformatf("Hierarchy: %m"), UVM_HIGH);
   endfunction // new

  
   virtual task pre_start();
      super.pre_start();
      if(starting_phase != null)begin
	 starting_phase.raise_objection(this);
      end
   endtask
   
   virtual task body();

      `uvm_do_with(req, {reset_156m25_n==1; cycles==1;});
      `uvm_do_with(req, {reset_156m25_n==0; cycles==1;});
      `uvm_do_with(req, {reset_156m25_n==1; cycles==1;});

      `uvm_do_with(req, {reset_xgmii_rx_n==1; cycles==1;});
      `uvm_do_with(req, {reset_xgmii_rx_n==0; cycles==1;});
      `uvm_do_with(req, {reset_xgmii_rx_n==1; cycles==1;});

      `uvm_do_with(req, {reset_xgmii_tx_n==1; cycles==1;});
      `uvm_do_with(req, {reset_xgmii_tx_n==0; cycles==1;});
      `uvm_do_with(req, {reset_xgmii_tx_n==1; cycles==1;});

      `uvm_do_with(req, {wb_rst_i==0; cycles==1;});
      `uvm_do_with(req, {wb_rst_i==1; cycles==1;});
      `uvm_do_with(req, {wb_rst_i==0; cycles==1;});

   endtask 

  virtual task post_start();
     super.post_start();
     if(starting_phase != null)begin
	starting_phase.drop_objection(this);
     end 
  endtask 

endclass   

`endif
