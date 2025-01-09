`ifndef RESET_ITEM_SV
`define RESET_ITEM_SV

class reset_item extends uvm_sequence_item;
   rand bit reset_156m25_n;
   rand bit reset_xgmii_rx_n;
   rand bit reset_xgmii_tx_n;
   rand bit wb_rst_i;
   rand int cycles;
   
   `uvm_object_utils_begin(reset_item)
      `uvm_field_int(reset_156m25_n, UVM_ALL_ON)
      `uvm_field_int(reset_xgmii_rx_n, UVM_ALL_ON)
      `uvm_field_int(reset_xgmii_tx_n, UVM_ALL_ON)
      `uvm_field_int(wb_rst_i, UVM_ALL_ON)
      `uvm_field_int(cycles, UVM_ALL_ON)
   `uvm_object_utils_end

   function new(input string name="rst");
     super.new(name);

     `uvm_info("RESET_ITEM CLASS", $sformatf("Hierarchy: %m"), UVM_HIGH); 
   endfunction

endclass   

`endif
