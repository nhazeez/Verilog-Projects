`define WImax (WI1 > WI2 ? (WI1+1) : (WI2+1))
`define WFmax (WF1 > WF2 ? WF1 : WF2)
module adder #(parameter WI1 = 5, WI2 = 7, WIO = 8, WF1 = 4, WF2 = 3, WFO = 4)
    (input signed [WI1+WF1 - 1 : 0] in1,
     input signed [WI2+WF2 - 1 : 0] in2,
     output OVF,
     output signed [WIO+WFO - 1 : 0] out);
     
     wire [`WImax - 1: 0] int1, int2;
     wire [`WFmax - 1: 0] f1, f2;
     wire signed [`WImax + `WFmax - 1 : 0] temp1, temp2;
     wire signed [`WImax + `WFmax - 1 : 0] temp3;
     wire [WIO - 1: 0] out_i;
     wire [WFO - 1: 0] out_f;

    // Sign extend + 1
    assign int1 = {{(`WImax - WI1){in1[WI1+WF1-1]}}, in1[WI1+WF1-1 : WF1]};
    assign int2 = {{(`WImax - WI2){in2[WI2+WF2-1]}}, in2[WI2+WF2-1 : WF2]};
    
    // Zero extend
    assign f1 = (`WFmax > WF1) ? {in1[WF1 - 1 : 0], {(`WFmax - WF1){1'b0}}} : in1[WF1 - 1 : 0];
    assign f2 = (`WFmax > WF2) ? {in2[WF2 - 1 : 0], {(`WFmax - WF2){1'b0}}} : in2[WF2 - 1 : 0];
    
    // Add sum
    assign temp1 = {int1, f1};
    assign temp2 = {int2, f2};
    assign temp3 = temp1 + temp2;
    
    // Extend or Truncate or Leave as is
    assign out_f = (WFO > `WFmax) ? {temp3[`WFmax - 1 : 0], {(WFO - `WFmax){1'b0}}}  :  temp3[`WFmax - 1 -: WFO]; 
    assign out_i = (WIO > `WImax) ? {{(WIO - `WImax){temp3[`WImax + `WFmax - 1]}}, temp3[`WImax + `WFmax - 1 : `WFmax]} : (WIO < `WImax) ? {temp3[`WImax + `WFmax - 1], temp3[`WFmax +: WIO-1]} : temp3[`WImax + `WFmax - 1 -: WIO];

    // Assign output
    assign out = {out_i, out_f};
    
    // Set overflow flag
    assign OVF = (WIO < `WImax) ? 
                 ((!(&temp3[`WImax + `WFmax - 1 : `WFmax+WIO-1]) || !(&(~temp3[`WImax + `WFmax - 1 : `WFmax+WIO-1]))) ? 1 : 0) : 0;
    
endmodule