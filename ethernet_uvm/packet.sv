`ifndef PACKET_SV
`define PACKET_SV

class packet extends uvm_sequence_item;
   rand bit [63:0] pkt_tx_data;
   rand bit         pkt_tx_eop;
   rand bit         pkt_tx_sop;
   rand bit [2:0]   pkt_tx_mod;
   rand bit         pkt_tx_val;
   
   `uvm_object_utils_begin(packet)
      `uvm_field_int(pkt_tx_data, UVM_ALL_ON)
      `uvm_field_int(pkt_tx_eop, UVM_ALL_ON)
      `uvm_field_int(pkt_tx_sop, UVM_ALL_ON)
      `uvm_field_int(pkt_tx_mod, UVM_ALL_ON)
      `uvm_field_int(pkt_tx_val, UVM_ALL_ON)
   `uvm_object_utils_end

   constraint packet {
		      pkt_tx_mod == 0; // According to design, pkt_tx_mod is valid when 0 for both little endian and big endian format
		      pkt_tx_sop == 1;
		      pkt_tx_eop == 1;
                      pkt_tx_val == 1;
		      };
   
   
   function new(input string name="PACKET");
     super.new(name);

     `uvm_info("PACKET CLASS", $sformatf("Hierarchy: %m"), UVM_HIGH); 
   endfunction

endclass   

`endif
