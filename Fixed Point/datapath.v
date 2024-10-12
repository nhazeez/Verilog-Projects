`timescale 1ns / 1ps

// y = x^2 + x
`define WImax (WIO_mul > WI_in ? (WIO_mul+1) : (WI_in+1))
`define WFmax (WFO_mul > WF_in ? WFO_mul : WF_in)
module datapath #(parameter WI_in = 8, WF_in = 8, WIO_mul = (WI_in + WI_in), WFO_mul = (WF_in + WF_in),
                  WI_out = `WImax, WF_out = `WFmax)
                (input CLK, EN, RST,
                input signed [WI_in + WF_in - 1 : 0] X,
                output signed [WI_out + WF_out - 1 : 0] Y);
                
                wire signed [WIO_mul + WFO_mul - 1 : 0] out_mul; // output of multiplier
                
                reg signed [WIO_mul + WFO_mul - 1 : 0] X1;   // multiplication
                reg signed [WI_in + WF_in - 1 : 0] X2;   // input
              
                // instantiate modules
                multiplier #(.WI1(WI_in), .WI2(WI_in), .WIO(WIO_mul), .WF1(WF_in), .WF2(WF_in), .WFO(WFO_mul)) m1 (.in1(X), .in2(X), .out(out_mul));
                adder #(.WI1(WIO_mul), .WI2(WI_in), .WIO(WI_out), .WF1(WFO_mul), .WF2(WF_in), .WFO(WF_out)) a1 (.in1(X1), .in2(X2), .out(Y));
                
                always @(posedge CLK) begin
                    if(RST) begin
                        X1 <= 0;
                        X2 <= 0;
                    end 
                    else begin
                        if(EN) begin  // enable registers
                            X1 <= out_mul;
                            X2 <= X;
                        end
                    end
                end
endmodule
