`ifndef TESTCLASS_SV
`define TESTCLASS_SV
`include "env.sv"
`include "reset_sequence.sv"
`include "tx_sequence.sv"
`include "virtual_sequencer.sv"

// RESET ITEM FOR RESET AGENT
// PACKET FOR TX AGENT

class test_base extends uvm_test;

  `uvm_component_utils(test_base);
   reset_sequence seq;
   env envo;
   tx_sequence seq_tx;
   virtual_sequencer v_seqr;
   

   function new(input string name, input uvm_component parent);
     super.new(name,parent);
   endfunction
 

  virtual function void end_of_elaboration_phase(input uvm_phase phase) ;
   super.end_of_elaboration_phase(phase);
   uvm_top.print_topology();
   factory.print();
   
  endfunction 

  virtual task run_phase(input uvm_phase phase);
     `uvm_info("TEST_BASE", $sformatf("%m"), UVM_HIGH);

     seq = reset_sequence::type_id::create("seq",this);

     seq_tx = tx_sequence::type_id::create("seq_tx",this);

      
  endtask

  virtual function void build_phase(input uvm_phase phase);
     
     super.build_phase(phase);
     envo = env::type_id::create("envo",this);
     v_seqr = virtual_sequencer::type_id::create("v_seqr", this);
     

     // change null to  TX_SEQUENCE::GET_TYPE() when testing tx  agent without virtual sequencer
     phase.raise_objection(this);
     uvm_config_db #(uvm_object_wrapper)::set(this,"envo.agent_tx.seqr_tx.main_phase","default_sequence",null);
     phase.drop_objection(this);

     // change null to RESET_SEQUENCE::GET_TYPE() when testing reset agent without virtual sequencer
    phase.raise_objection(this); 
    uvm_config_db #(uvm_object_wrapper)::set(this,"envo.agent_rst.seqr.reset_phase","default_sequence", null);
    phase.drop_objection(this);

     uvm_config_db #(virtual e_interface)::set(this, "envo.agent_tx.drv_tx", "vi", xge_mac_top.riff);

     uvm_config_db #(virtual e_interface)::set(this, "envo.agent_rst.drv", "vi", xge_mac_top.riff);

     uvm_config_db #(virtual e_interface)::set(this, "envo.agent_tx.mon_tx", "mi", xge_mac_top.riff);

     uvm_config_db #(virtual e_interface)::set(this, "envo.agent_rx.mon_rx", "mi", xge_mac_top.riff);
     
     uvm_config_db #(int)::set(this, "envo.agent_tx.seqr_tx.seq_tx", "num_packets", 4);    
     
      
  endfunction


  virtual function void connect_phase(input uvm_phase phase);
     
     super.connect_phase(phase);
     v_seqr.seqr = envo.agent_rst.seqr;
     v_seqr.seqr_tx = envo.agent_tx.seqr_tx;
     

   endfunction 

endclass

`endif
