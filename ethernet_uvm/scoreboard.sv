`ifndef SCOREBOARD_SV
`define SCOREBOARD_SV
`include "packet.sv"

class scoreboard extends uvm_scoreboard;
   
  `uvm_component_utils(scoreboard);

   typedef uvm_in_order_class_comparator #(packet) packet_comparator;
   packet_comparator comparator;
   
   uvm_analysis_export #(packet)     from_agent_rx;
   uvm_analysis_export #(packet)     from_agent_tx;

   function new(input string name="scoreboard",input uvm_component parent);
      super.new(name,parent);
   endfunction 

   virtual function void build_phase(input uvm_phase phase);
      super.build_phase(phase);

      comparator = packet_comparator::type_id::create("comparator", this);
      from_agent_rx = new("from_agent_rx", this);
      from_agent_tx = new("from_agent_tx", this);
   endfunction 


   virtual function void connect_phase(input uvm_phase phase);
      super.connect_phase(phase);

      this.from_agent_rx.connect(comparator.after_export);
      this.from_agent_tx.connect(comparator.before_export);

   endfunction 

   virtual function void report_phase(input uvm_phase phase);
      super.report_phase(phase);
      `uvm_info("SCOREBOARD CLASS report_phase()", $sformatf("Hierarchy: %m"), UVM_HIGH);

      `uvm_info("Scoreboard Report:", $sformatf("Number of Packet Matches=%od, Number of Packet Mismatches=%od",comparator.m_matches, comparator.m_mismatches), UVM_HIGH);
   endfunction 

endclass

`endif
