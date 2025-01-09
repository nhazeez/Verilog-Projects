`ifndef	ENV__SV
`define	ENV__SV

`include "reset_agent.sv"
`include "tx_agent.sv"
`include "rx_agent.sv"
`include "scoreboard.sv"

class env extends uvm_env;
   `uvm_component_utils(env)
   reset_agent agent_rst;
   tx_agent agent_tx;
   rx_agent agent_rx;
   scoreboard sb;
   
   

   function new(input string name="Environment", input uvm_component parent);
     super.new(name,parent);
   endfunction

   virtual function void build_phase(input uvm_phase phase);
     
     super.build_phase(phase);
     agent_rst = reset_agent::type_id::create("agent_rst",this);
     agent_tx = tx_agent::type_id::create("agent_tx",this);
     agent_rx = rx_agent::type_id::create("agent_rx",this);
     sb = scoreboard::type_id::create("sb",this);
   endfunction // build_phase

   virtual function void connect_phase(input uvm_phase phase);
     
     super.connect_phase(phase);
      agent_rx.analysis_port.connect(sb.from_agent_rx);
      agent_tx.analysis_port.connect(sb.from_agent_tx);
   endfunction 


endclass

`endif 
