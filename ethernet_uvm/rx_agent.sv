`ifndef	RX_AGENT__SV
`define	RX_AGENT__SV
`include "rx_monitor.sv"
`include "packet.sv"


class rx_agent extends uvm_agent;
   `uvm_component_utils(rx_agent)

   rx_monitor mon_rx;

   uvm_analysis_port #(packet)    analysis_port;
   

   function new(input string name="RxAgent", input uvm_component parent);
     super.new(name,parent);
   endfunction 

   virtual function void build_phase(input uvm_phase phase);
     
     super.build_phase(phase);

     mon_rx = rx_monitor::type_id::create("mon_rx", this);
     
      
      
      
   endfunction 

   virtual function void connect_phase(input uvm_phase phase);
     
     super.connect_phase(phase);

    this.analysis_port =  mon_rx.ap;
      
      
   endfunction 
   
endclass

`endif 
