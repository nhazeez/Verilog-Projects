interface e_interface(input bit clk_156m25, input bit clk_xgmii_rx, input bit clk_xgmii_tx, input bit wb_clk_i, ref logic reset_156m25_n, ref logic reset_xgmii_rx_n, ref logic reset_xgmii_tx_n, ref logic wb_rst_i);

   logic [63:0] pkt_tx_data;
   logic 	pkt_tx_eop;
   logic [2:0]	pkt_tx_mod;
   logic 	pkt_tx_sop;
   logic 	pkt_tx_val;
   logic 	pkt_tx_full;

   clocking cbd @(posedge clk_156m25);
  // for driver
     output #1  pkt_tx_data,
                pkt_tx_eop,
                pkt_tx_mod,
                pkt_tx_sop,
                pkt_tx_val;
   endclocking // cbd
   
  clocking cbm @(negedge clk_156m25);
  // for monitor
     input #1  pkt_tx_data,
                pkt_tx_eop,
                pkt_tx_mod,
                pkt_tx_sop,
                pkt_tx_val;
   endclocking
      
   modport tx_emac_testcase_port( inout  pkt_tx_data, pkt_tx_eop, pkt_tx_mod, pkt_tx_sop, pkt_tx_val, pkt_tx_full  // can use for both driver or emac
		      );
   
  
endinterface
