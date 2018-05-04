// EEM16 - Logic Design
// Design Assignment #2 - Problem #2.1
// dassign2_1.v
// Verilog template

// You may define any additional modules as necessary
// Do not delete or modify any of the modules provided
//
// The modules you will have to design are at the end of the file
// Do not change the module or port names of these stubs

// ***************
// Building blocks
// ***************

// D-register (flipflop).  Width set via parameter.
// Includes propagation delay t_PD = 3
module dreg(clk, d, q);
    parameter width = 1;
    input clk;
    input [width-1:0] d;
    output [width-1:0] q;
    reg [width-1:0] q;

    always @(posedge clk) begin
        q <= #3 d;
    end
endmodule

// 2-1 Mux.  Width set via parameter.
// Includes propagation delay t_PD = 3
module mux2(a, b, sel, y);
    parameter width = 1;
    input [width-1:0] a, b;
    input sel;
    output [width-1:0] y;

    assign #3 y = sel ? b : a;
endmodule

// Left-shifter
// No propagation delay, it's just wires really
module shl(a, y);
    parameter width = 1;
    input [width-1:0] a;
    output [width-1:0] y;

    assign y = {a[width-2:0], 1'b0};
endmodule

// Right-shifter
// more wires 
module shr(a, y);
    parameter width = 1;
    input [width-1:0] a;
    output [width-1:0] y;

    assign y = {1'b0, a[width-1:1]};
endmodule

// 16-bit adder (declarative Verilog)
// Includes propagation delay t_PD = 3n = 48
module adder16(a, b, sum);
    input [15:0] a, b;
    output [15:0] sum;

    assign #48 sum = a+b;
endmodule

// ****************
// Blocks to design
// ****************

// Lowest order partial product of two inputs 
// Use declarative verilog only
// IMPORTANT: Do not change module or port names
module partial_product (a, b, pp);

    // your code here
    // Include a propagation delay of #1
    // assign #1 pp = ... ;
  
  input [15:0] a; // 16 bits
  input b;  // 1 bit
  output [15:0] pp; //output must be a reg
  

  
//  mux2 #(16) ppmux( 16'b0, a, b[0], result);
  assign #1 pp[0] = a[0] & b;
  assign #1 pp[1] = a[1] & b;
  assign #1 pp[2] = a[2] & b;
  assign #1 pp[3] = a[3] & b;
  assign #1 pp[4] = a[4] & b;
  assign #1 pp[5] = a[5] & b;
  assign #1 pp[6] = a[6] & b;
  assign #1 pp[7] = a[7] & b;
  assign #1 pp[8] = a[8] & b;
  assign #1 pp[9] = a[9] & b;
  assign #1 pp[10] = a[10] & b;
  assign #1 pp[11] = a[11] & b;
  assign #1 pp[12] = a[12] & b;
  assign #1 pp[13] = a[13] & b;
  assign #1 pp[14] = a[14] & b;
  assign #1 pp[15] = a[15] & b;
 
  
endmodule

// Determine if multiplication is complete
// Use declarative verilog only
// IMPORTANT: Do not change module or port names
module is_done (a, b, done);

    // your code here
    // Include a propagation delay of #4
    // assign #4 done = ... ;
  input [15:0] a;
  input [7:0] b;
  output done;
  
 // reg done;
  wire check;
  
  assign check = b[0] | b[1] | b[2] | b[3] | b[4] | b[5] | b[6] | b[7]; //check = 0 when all inputs are 0
  
  assign #4 done = !check; // 1 when done, 0 otherwise
  

endmodule

// 8 bit unsigned multiply 
// Use structural verilog only
// IMPORTANT: Do not change module or port names
module multiply (clk, ain, bin, reset, prod, ready);
    input clk;
    input [7:0] ain, bin;
    input reset;
    output [15:0] prod;
    output ready;

    // your code here
    // do not use any delays!
  wire [15:0] a;
  
  
  //make a new a that is 16 bits
  assign a[15]=1'b0;
  assign a[14]=1'b0;
  assign a[13]=1'b0;
  assign a[12]=1'b0;
  assign a[11]=1'b0;
  assign a[10]=1'b0;
  assign a[9]=1'b0;
  assign a[8]=1'b0;
  assign a[7]=ain[7];
  assign a[6]=ain[6];
  assign a[5]=ain[5];
  assign a[4]=ain[4];
  assign a[3]=ain[3];
  assign a[2]=ain[2];
  assign a[1]=ain[1];
  assign a[0]=ain[0];
  
  wire [7:0] bout, b_reg_to_shift, b_reg_to_mux, bdelay;
  wire bzero;
  
 // assign b_reg_to_mux = 8'b0;
  
  //start when reset = 1 so we load new values to a and b registers
  mux2 #(8) loadB(b_reg_to_mux, bin, reset, bout);
  dreg #(8) delay_b(clk, bout, bdelay); 
  is_done check(a,bdelay,ready); 
  dreg #(8) breg (clk, bout, b_reg_to_shift);
  assign bzero = b_reg_to_shift[0]; // remember the value that will be shifter out
  shr #(8) bshift (b_reg_to_shift, b_reg_to_mux);
  
  wire [15:0] a_mux_to_reg, shifted_a, a_shift_to_mux;
  
  mux2 #(16) loadA( a_shift_to_mux, a, reset, a_mux_to_reg);
  dreg #(16) areg(clk, a_mux_to_reg, shifted_a);
  shl #(16) ashift(shifted_a, a_shift_to_mux);
  
  wire[15:0] pp;
  //declare 16 ends
  
  partial_product calculate(shifted_a, bzero, pp);
  
  wire [15:0] pp_mux_to_reg, mux_to_adder, product_mux_to_reg;
  
  mux2 #(16) pp_mux( pp, 16'b0, reset, pp_mux_to_reg);
  dreg #(16) ppreg(clk, pp_mux_to_reg, mux_to_adder);
  
  
  wire [15:0] product, product_reg_to_adder;
  //product defined as an output
  adder16 add(mux_to_adder, product_reg_to_adder , product);
  assign prod = product;
  mux2 #(16) rst_mux( product, 16'b0, reset, product_mux_to_reg);
  dreg #(16) productreg(clk, product_mux_to_reg, product_reg_to_adder);
  
 
    
endmodule

// Clock generation.  Period set via parameter:
//   clock changes every half_period ticks
//   full clock period = 2*half_period
// Replace half_period parameter with desired value
module clock_gen(clk);
  // adder plus mux for combinational logic
    parameter half_period = 30; // REPLACE half_period HERE
    output clk;
    reg    clk;

    initial clk = 0;
    always #half_period clk = ~clk;
endmodule
