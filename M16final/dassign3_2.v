// EEM16 - Logic Design
// Design Assignment #3.2
// dassign3_2.v
// Verilog template

// You may define any additional modules as necessary
// Do not delete or modify any of the modules provided

// ****************
// Blocks to design
// ****************

// 3.2a) Inter-layer module
// four sets of inputs: 8 bit value, 1 bit input ready
// one 1 bit input new (from input layer of neurons)
// four sets of 8 bits output
// one 1 bit output ready
module interlayer(clk, new, in1, ready1, in2, ready2, in3, ready3, in4, ready4, out1, out2, out3, out4, ready_out);
    input clk;
    input new;
    input [7:0] in1, in2, in3, in4;
    input ready1, ready2, ready3, ready4;
    output [7:0] out1, out2, out3, out4;
    output ready_out;

    // your code here
  
  //decalre wires
  wire [7:0] reg1_to_mux, reg2_to_mux, reg3_to_mux, reg4_to_mux;
  wire all_ready;
  
  //declare all dregs used
  dreg #(8) reg1(clk, in1, reg1_to_mux);
  dreg #(8) reg2(clk, in2, reg2_to_mux);
  dreg #(8) reg3(clk, in3, reg3_to_mux);
  dreg #(8) reg4(clk, in4, reg4_to_mux);
  
  //declare all muxes
  //module mux2(a, b, sel, y);
  mux2 #(8) mux1 (8'b0, reg1_to_mux, all_ready, out1);
  mux2 #(8) mux2 (8'b0, reg2_to_mux, all_ready, out2);
  mux2 #(8) mux3 (8'b0, reg3_to_mux, all_ready, out3);
  mux2 #(8) mux4 (8'b0, reg4_to_mux, all_ready, out4);
  
  //ready out is 1 when all ready's are 1
  assign all_ready = ready1 & ready2 & ready3 & ready4;
  
 // assign ready_out = all_ready;
  wire prev_all_ready;
  dreg flag_pulse(clk, all_ready, prev_all_ready);
  
  assign ready_out = all_ready & ~prev_all_ready;
  
endmodule











