module multiplier #(parameter WI1 = 5, WI2 = 7, WIO = 12, WF1 = 4, WF2 = 3, WFO = 7)
    (input signed [WI1+WF1 - 1 : 0] in1,
     input signed [WI2+WF2 - 1 : 0] in2,
     output OVF,
     output signed [WIO+WFO - 1 : 0] out);
     
     wire signed [WI1+WF1 + WI2+WF2 - 1 : 0] sum_full;
     wire [WIO - 1: 0] out_i;
     wire [WFO - 1: 0] out_f;
     
     // temporary sum
     assign sum_full = in1 * in2;
     // case 1: zero extension, case 2: select WFO bits
     assign out_f = (WFO > (WF1+WF2)) ? {sum_full[WF1 + WF2 - 1 : 0], {(WFO - (WF1+WF2)){1'b0}}}  :  sum_full[WF1 + WF2 - 1 -: WFO];  
     // case 1: sign extension, case 2: truncate integer, case 3: get default integer bits if WIO == WI
     assign out_i = (WIO > (WI1+WI2)) ? {{(WIO - (WI1+WI2)){sum_full[WI1+WF1 + WI2+WF2 - 1]}}, sum_full[WI1+WF1 + WI2+WF2 - 1 : WF1+WF2]} : (WIO < (WI1+WI2)) ? {sum_full[WI1+WF1 + WI2+WF2 - 1], sum_full[WF1+WF2 +: WIO-1]} : sum_full[WI1+WF1 + WI2+WF2 - 1 -: WIO];
     // final output
     assign out = {out_i, out_f};
     // set overflow flag
     assign OVF = (WIO < (WI1 + WI2)) ? 
                   ((!(&sum_full[WI1+WF1 + WI2+WF2 - 1 : WF1+WF2+WIO-1]) || !(&(~sum_full[WI1+WF1 + WI2+WF2 - 1 : WF1+WF2+WIO-1]))) ? 1 : 0) : 0;
     
endmodule