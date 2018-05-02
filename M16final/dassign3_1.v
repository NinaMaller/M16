// EEM16 - Logic Design
// Design Assignment #3.1
// dassign3_1.v
// Verilog template

// You may define any additional modules as necessary
// Do not delete or modify any of the modules provided

// ****************
// Blocks to design
// ****************

// 3.1a) Rectified linear unit
// out = max(0, in/4)
// 16 bit signed input
// 8 bit unsigned output
module relu(in, out);
    input [15:0] in;
    output [7:0] out;


    // your code here
  wire [15:0] half_in, quarter_in;
  
  shr #(16) shift2(in, half_in);
  shr #(16) shift1(half_in, quarter_in);
  
  wire[15:0] almost_out;
  assign almost_out = (in[15] == 1'b0)? quarter_in:16'b0;
  
  //truncate to get out to be only 8 bits
  assign out[0] = almost_out[0];
  assign out[1] = almost_out[1];
  assign out[2] = almost_out[2];
  assign out[3] = almost_out[3];
  assign out[4] = almost_out[4];
  assign out[5] = almost_out[5];
  assign out[6] = almost_out[6];
  assign out[7] = almost_out[7];
  
endmodule

// 3.1b) Pipelined 5 input ripple-carry adder
// 16 bit signed inputs
// 1 bit input: valid (when the other inputs are useful numbers)
// 16 bit signed output (truncated)
// 1 bit output: ready (when the output is the sum of valid inputs)
module piped_adder(clk, a, b, c, d, e, valid, sum, ready);
    input clk, valid;
    input [15:0] a, b, c, d, e;
    output [15:0] sum;
    output ready;
  
    // your code here
   
  //carry out wires -- all are one bit
  wire  co11, co12, co13,ci21, ci22, ci23, co21, co22, co23,ci31, ci32, ci33, co31, co32,co33,
  		ci41, ci42, ci43, co41, co42, co43;
  
  //input wires -- all are 20 bits
  wire [19:0]  w_in2, w_in3_2, w_in3_1, w_in4_1, w_in4_2, w_in4_3;
  
  //output wires -- all are 4 bits
  wire [3:0] w_out1_1, w_out1_2, w_out1_3, w_out1_4, w_out1_5,
			 w_out2_1, w_out2_2, w_out2_3, w_out2_4,
			 w_out3_1, w_out3_2, w_out3_3,
			 w_out4_1, w_out4_2;
  
  
  adder5carry adder_1(a[3:0], b[3:0], c[3:0], d[3:0], e[3:0], 1'b0, 1'b0, 1'b0, co11, co12, co13, w_out1_1);
  adder5carry adder_2(w_in2[3:0], w_in2[7:4], w_in2[11:8], w_in2[15:12], w_in2[19:16], ci21, ci22, ci23, co21, co22, co23, w_out2_1);
  adder5carry adder_3(w_in3_2[3:0], w_in3_2[7:4], w_in3_2[11:8], w_in3_2[15:12], w_in3_2[19:16],  ci31, ci32, ci33, co31, co32,co33, w_out3_1);
  adder5carry adder_4(w_in4_3[3:0], w_in4_3[7:4], w_in4_3[11:8], w_in4_3[15:12], w_in4_3[19:16], ci41, ci42, ci43, co41, co42, co43, w_out4_1);
  
  // registers between adders
  dreg #(3) adder_1_to_2 (clk, {co11, co12, co13}, {ci21, ci22, ci23});
  dreg #(3) adder_2_to_3 (clk, {co21, co22, co23}, {ci31, ci32, ci33});
  dreg #(3) adder_3_to_4 (clk, {co31, co32, co33}, {ci41, ci42, ci43});
  
  // register on first adder
  dreg #(4) out1_1(clk, w_out1_1, w_out1_2);
  dreg #(4) out1_2(clk, w_out1_2, w_out1_3);
  dreg #(4) out1_3(clk, w_out1_3, w_out1_4);
  dreg #(4) out1_4(clk, w_out1_4, w_out1_5); // sum[3:0]
  
  //register on second adder
  dreg #(20) in2_1(clk, {a[7:4], b[7:4], c[7:4], d[7:4] , e[7:4]}, w_in2);
  dreg #(4) out2_1(clk, w_out2_1, w_out2_2);
  dreg #(4) out2_2(clk, w_out2_2, w_out2_3);
  dreg #(4) out2_3(clk, w_out2_3, w_out2_4); // sum[7:4]
  
  // registers on third adder
  dreg #(20) in3_1(clk, {a[11:8], b[11:8], c[11:8], d[11:8] , e[11:8]}, w_in3_1);
  dreg #(20) in3_2(clk, w_in3_1, w_in3_2); // in3_2 goes into adder
  dreg #(4) out3_1(clk, w_out3_1, w_out3_2);
  dreg #(4) out3_2(clk, w_out3_2, w_out3_3); // sum[11:8]
  
  // registers on fourth adder
  dreg #(20) in4_1(clk, {a[15:12], b[15:12], c[15:12], d[15:12] , e[15:12]}, w_in4_1);
  dreg #(20) in4_2(clk, w_in4_1, w_in4_2);
  dreg #(20) in4_3(clk, w_in4_2, w_in4_3); // win43 goes into adder
  dreg #(4) out4_1(clk, w_out4_1, w_out4_2);
  
  // assign wires to outputs
  // truncate from msb side
  wire [15:0] sum1;
  
  assign sum[0]  = w_out1_5[0];
  assign sum[1]  = w_out1_5[1];
  assign sum[2]  = w_out1_5[2];
  assign sum[3]  = w_out1_5[3];
  assign sum[4]  = w_out2_4[0];
  assign sum[5]  = w_out2_4[1];
  assign sum[6]  = w_out2_4[2];
  assign sum[7]  = w_out2_4[3];
  assign sum[8]  = w_out3_3[0];
  assign sum[9]  = w_out3_3[1];
  assign sum[10] = w_out3_3[2];
  assign sum[11] = w_out3_3[3];
  assign sum[12] = w_out4_2[0];
  assign sum[13] = w_out4_2[1];
  assign sum[14] = w_out4_2[2];
  assign sum[15] = w_out4_2[3];
 

  
  wire val1, val2, val3, val4, val5, val6;
  
  dreg one_clock(clk, valid, val1);
  dreg two_clock(clk, val1, val2);
  dreg three_clock(clk, val2, val3);
  dreg four_clock(clk, val3, ready);

  
endmodule

// 3.1c) Pipelined neuron
// 8 bit signed weights, bias (constant)
// 8 bit unsigned inputs 
// 1 bit input: new (when a set of inputs are available)
// 8 bit unsigned output 
// 1 bit output: ready (when the output is valid)
module neuron(clk, w1, w2, w3, w4, b, x1, x2, x3, x4, new, y, ready);
    input clk;
    input [7:0] w1, w2, w3, w4, b;  // signed 2s complement
    input [7:0] x1, x2, x3, x4;     // unsigned
    input new;
    output [7:0] y;                 // unsigned
    output ready;

    // your code here
  wire [15:0] prod1, prod2, prod3, prod4, sum; 
  wire m1_ready, m2_ready, m3_ready, m4_ready; 
  
  multiply m1(clk, w1, x1, new, prod1, m1_ready);
  multiply m2(clk, w2, x2, new, prod2, m2_ready);
  multiply m3(clk, w3, x3, new, prod3, m3_ready); 
  multiply m4(clk, w4, x4, new, prod4, m4_ready); 
  
  wire all_multiplies_ready, adder_ready, ready_1; 
  assign all_multiplies_ready = m1_ready & m2_ready & m3_ready & m4_ready; 
  

  piped_adder myAdder(clk, prod1, prod2, prod3, prod4, {{8{b[7]}}, b}, all_multiplies_ready, sum, ready_1); 
  dreg delay_adder_ready(clk, ready_1, ready);
  
  relu myRelu(sum,y); 

  
  
  
endmodule






