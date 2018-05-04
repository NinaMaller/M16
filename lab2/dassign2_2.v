// EEM16 - Logic Design
// Design Assignment #2 - Problem #2.2
// dassign2_2.v
// Verilog template

// You may define any additional modules as necessary
// Do not delete or modify any of the modules provided
//
// The modules you will have to design are at the end of the file
// Do not change the module or port names of these stubs

// Include constants file defining THRESHOLD, CMDs, STATEs

`include "constants2_2.vh"

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

// 4-1 Mux.  Width set via parameter.
// Includes propagation delay t_PD = 3
module mux4(a, b, c, d, sel, y);
    parameter width = 1;
    input [width-1:0] a, b, c, d;
    input [1:0] sel;
    output [width-1:0] y;
    reg [width-1:0] y;

    always @(*) begin
        case (sel)
            2'b00:    y <= #3 a;
            2'b01:    y <= #3 b;
            2'b10:    y <= #3 c;
            default:  y <= #3 d;
        endcase
    end
endmodule

// ****************
// Blocks to design
// ****************

// Evaluates incoming pulses/gaps 
// Use any combination of declarative or structural verilog
// IMPORTANT: Do not change module or port names
module pulse_width(clk, in, pwidth, long, type, new);
    parameter width = 8;
    input clk, in;
    output [width-1:0] pwidth;
    output long, type, new;



    // your code here
    // do not use any delays!
  wire [width-1:0] mux_to_reg, reg_to_counter; // 8 bit wires // [7:0]
  wire prev_in; // 1 bit wire
  
  dreg #(8) get_prev(clk, in, prev_in);
   assign new = (in == prev_in)?0:1; // or 1'b0?
  
  //  assign new = (equal == 1)? 1:0; // if prev values are not equal, pulse the flag indicating that there is new width
  assign type = (prev_in == 0 & new == 1)? 0:1; // which type prev in had to indicate if pulse or gap
  
  mux2 #(8) check_continuity(pwidth, 0, new, mux_to_reg);
  dreg #(8) wait_reg(clk, mux_to_reg, reg_to_counter);
   assign pwidth = reg_to_counter + 1; // or 1'b1?
  
  assign long = (pwidth > `THRESHOLD & new == 1)? 1:0; //1 for long, 0 for short
  
  
  
  //assign long = (new == 0)? 0:long;

 // assign type = (new == 0)? 0:type;
  
  

endmodule

// Four valued shift-register
// Use any combination of declarative or structural verilog
//    or procedural verilog, provided it obeys rules for combinational logic
// IMPORTANT: Do not change module or port names
module shift4(clk, in, cmd, out3, out2, out1, out0);
    parameter width = 1;
    input clk;
    input [width-1:0] in;
    input [`CMD_WIDTH-1:0] cmd;
    output [width-1:0] out3, out2, out1, out0;

    // your code here
    // do not use any delays!
  
  //we need 4 8-bit dregs and 4 muxes
//  dreg #(8) dreg_1, dreg_2, dreg_3, dreg_4;
//  mux4 mux_1, mux_2, mux_3, mux_4;
  wire [width-1:0] mux_1_to_reg, mux_2_to_reg, mux_3_to_reg, mux_4_to_reg; // [7:0]
    
  
  //connect all muxes
  mux4 #(width) mux_1(8'b0, in, out0, in, cmd, mux_1_to_reg); // 8 for all of them
  mux4 #(width) mux_2(8'b0, out0, out1, out1, cmd, mux_2_to_reg);
  mux4 #(width) mux_3(8'b0, out1, out2, out2, cmd, mux_3_to_reg);
  mux4 #(width) mux_4(8'b0, out2, out3, out3, cmd, mux_4_to_reg);
  
  //conect all registers
  dreg #(width) dreg_1(clk, mux_1_to_reg, out0);
  dreg #(width) dreg_2(clk, mux_2_to_reg, out1);
  dreg #(width) dreg_3(clk, mux_3_to_reg, out2);
  dreg #(width) dreg_4(clk, mux_4_to_reg, out3);
  

endmodule

// Control FSM for shift register
// Use any combination of declarative or structural verilog
//    or procedural verilog, provided it obeys rules for combinational logic
// IMPORTANT: Do not change module or port names
module control_fsm(clk, long, type, cmd, done);
    input clk, long, type;
    output [`CMD_WIDTH-1:0] cmd;
    output done;

    // your code here
    // do not use any delays!
  
  reg  cmd;
  reg done;
 
  
//  assign done = (long == 1 & type == 0)?1:0;
  
  always @(type or long) begin
    if(long == 1 && type == 0) begin
      cmd = `CMD_CLEAR;
      done = 1;
    end
    if(long == 0 && type == 0) begin
      cmd = `CMD_HOLD;
      done = 0;
    end
    else begin
      cmd = `CMD_LOAD;
      done = 0;
    end
    
  end


endmodule

// Input de-serializer
// Use structural verilog only
// IMPORTANT: Do not change module or port names
module deserializer(clk, in, out3, out2, out1, out0, done);
    parameter width = 8;
    input clk, in;
    output [width-1:0] out3, out2, out1, out0;
    output done;

    // your code here
    // do not use any delays!
  
  	
 // pulse_width(clk, in, pwidth, long, type, new)
  //shift4(clk, in, cmd, out3, out2, out1, out0);
  //control_fsm(clk, long, type, cmd, done);
  
  wire long, type, new;
  wire [width-1:0] pwidth; // [7:0]
  wire [`CMD_WIDTH-1:0] cmd; // [1:0]
  
  
  pulse_width width_measure(clk, in, pwidth, long, type, new);
  shift4 shifter(clk, pwidth, cmd, out3, out2, out1, out0); // put #(8) gives more errors
  control_fsm fsm(clk, long, type, cmd, done);
  
  

endmodule





