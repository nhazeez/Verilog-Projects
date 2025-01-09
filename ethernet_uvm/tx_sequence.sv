`ifndef TX_SEQUENCE_SV
`define TX_SEQUENCE_SV

`include "packet.sv"

class tx_sequence extends uvm_sequence #(packet);
   `uvm_object_utils(tx_sequence);

   int num_packets = 4;   
 

   function new(input string name="tx_seq");
     super.new(name);

     `uvm_info("PACKET CLASS", $sformatf("Hierarchy: %m"), UVM_HIGH);
   endfunction 

  
   virtual task pre_start();
      super.pre_start();
      
      uvm_config_db #(int)::get(null, get_full_name(), "num_packets", num_packets);
      
      if(starting_phase != null)begin
	 starting_phase.raise_objection(this);
      end
   endtask
   
   virtual task body();

     repeat(num_packets) `uvm_do(req);

   endtask 

  virtual task post_start();
     super.post_start();
     
     if(starting_phase != null)begin
	starting_phase.drop_objection(this);
     end 
  endtask 

endclass   

`endif
