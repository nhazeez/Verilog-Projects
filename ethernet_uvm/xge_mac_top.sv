module xge_mac_top();

   bit		clk_156m25;
   bit          clk_xgmii_rx;
   bit          clk_xgmii_tx;
   bit          wb_clk_i;
   
   logic 	reset_156m25_n;
   logic        reset_xgmii_rx_n;
   logic        reset_xgmii_tx_n;
   logic        wb_rst_i;	

   logic [7:0]  xgmii_rxc;
   logic [63:0] xgmii_rxd;

   logic [7:0]  xgmii_txc;
   logic [63:0] xgmii_txd;
   
   
   

   // Generate Clock

   always #3200 clk_156m25 = ~clk_156m25;
   always #3200 clk_xgmii_rx = ~clk_xgmii_rx;
   always #3200 clk_xgmii_tx = ~clk_xgmii_tx;
   always #3200 wb_clk_i = ~wb_clk_i;


   e_interface riff(clk_156m25, clk_xgmii_rx, clk_xgmii_tx, wb_clk_i, reset_156m25_n, reset_xgmii_rx_n, reset_xgmii_tx_n, wb_rst_i);


   xge_mac dut(
            // Outputs
       /*     .pkt_rx_avail               (pkt_rx_avail),
            .pkt_rx_data                (pkt_rx_data[63:0]),
            .pkt_rx_eop                 (pkt_rx_eop),
            .pkt_rx_err                 (pkt_rx_err),
            .pkt_rx_mod                 (pkt_rx_mod[2:0]),
            .pkt_rx_sop                 (pkt_rx_sop),
            .pkt_rx_val                 (pkt_rx_val),    */
            .pkt_tx_full                (riff.pkt_tx_full),
         /*   .wb_ack_o                   (wb_ack_o),
            .wb_dat_o                   (wb_dat_o[31:0]),
            .wb_int_o                   (wb_int_o),       */
            .xgmii_txc                  (xgmii_txc),
            .xgmii_txd                  (xgmii_txd),    
            // Inputs
            .clk_156m25                 (clk_156m25),
            .clk_xgmii_rx               (clk_xgmii_rx),
            .clk_xgmii_tx               (clk_xgmii_tx),
        //   .pkt_rx_ren                 (pkt_rx_ren),
            .pkt_tx_data                (riff.pkt_tx_data),
            .pkt_tx_eop                 (riff.pkt_tx_eop),
            .pkt_tx_mod                 (riff.pkt_tx_mod),
            .pkt_tx_sop                 (riff.pkt_tx_sop),
            .pkt_tx_val                 (riff.pkt_tx_val),   
            .reset_156m25_n             (riff.reset_156m25_n),
            .reset_xgmii_rx_n           (riff.reset_xgmii_rx_n),
            .reset_xgmii_tx_n           (riff.reset_xgmii_tx_n),
       //     .wb_adr_i                   (wb_adr_i[7:0]),    
            .wb_clk_i                   (riff.wb_clk_i),
       //     .wb_cyc_i                   (wb_cyc_i),
       //    .wb_dat_i                   (wb_dat_i[31:0]),
            .wb_rst_i                   (wb_rst_i),
       /*     .wb_stb_i                   (wb_stb_i),
            .wb_we_i                    (wb_we_i),   */
            .xgmii_rxc                  (xgmii_rxc),
            .xgmii_rxd                  (xgmii_rxd)  
	 );

   // CODE FOR LOOPBACK:
   assign dut.xgmii_rxc = dut.xgmii_txc;
   assign dut.xgmii_rxd = dut.xgmii_txd;
   
   initial begin
      $vcdpluson();
   end
		
endmodule
