`ifndef	VIRTUALSEQUENCE__SV
`define	VIRTUALSEQUENCE__SV


class virtual_sequence  extends uvm_sequence;
   `uvm_object_utils(virtual_sequence);

   `uvm_declare_p_sequencer(virtual_sequencer);
   
   
   reset_sequence seq;
   tx_sequence seq_tx;

   function new(input string name);
     super.new(name);
   endfunction

   virtual task pre_start();
     super.pre_start();

     `uvm_info("VIRTUAL SEQUENCE CLASS pre_start()", $sformatf("Hierarchy: %m"), UVM_HIGH);
     
     if((get_parent_sequence()==null) && (starting_phase != null))begin
	starting_phase.raise_objection(this);
     end 
  endtask 
   

   virtual task body()
     
     `uvm_do_on(seq, p_sequencer.seqr ): // DO RESET FIRST

     fork
	`uvm_do_on(seq_tx, p_sequencer.seqr_tx):

     join
   endtask // body

   virtual task post_start();
     super.post_start();

       `uvm_info("VIRTUAL SEQUENCE CLASS post_start()", $sformatf("Hierarchy: %m"), UVM_HIGH);
     
     if((get_parent_sequence()==null) && (starting_phase != null))begin
	starting_phase.drop_objection(this);
     end 
  endtask 

endclass

`endif 
