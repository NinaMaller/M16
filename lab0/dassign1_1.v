  // EEM16 - Logic Design
// Design Assignment #1 - Problem #1.1
// dassign1_1.v
// Verilog template

// You may define any additional modules as necessary
// Do not delete or modify any of the modules provided
//
// The modules you will have to design are at the end of the file
// Do not change the module or port names of these stubs

// CMOS gates (declarative Verilog)
// Includes propagation delay t_PD = 1
module inverter(a,y);
    input a;
    output y;

    assign #1 y = ~a;
endmodule

module fa_gate_1(a,b,c,y);
    input a,b,c;
    output y;

    assign #1 y = ~((a&b) | (c&(b|a)));
endmodule

module fa_gate_2(a,b,c,m,y);
    input a,b,c,m;
    output y;

    assign #1 y = ~((a&b&c) | ((a|b|c)&m));
endmodule

// Full adder (structural Verilog)
module fa(a,b,ci,co,s);
    input a,b,ci;
    output s,co;

    wire nco, ns;

    fa_gate_1   fa_gate_1_1(a,b,ci, nco);
    fa_gate_2   fa_gate_2_1(a,b,ci,nco, ns);
    inverter    inverter_1(nco, co); 
    inverter    inverter_2(ns, s);
endmodule

// 5+2 input full adder (structural Verilog)
// IMPORTANT: Do not change module or port names
module fa5 (a,b,c,d,e,ci0,ci1, 
            co1,co0,s);

    input a,b,c,d,e,ci0,ci1;
    output co1, co0, s;
  	
    // your code here
    // do not use any delays!
     wire cout1, cout2, cout3, s1, s2; 
  
 	 fa fa_1(a,b,ci0,cout1,s1);
 	 fa fa_2(c,d,ci1,cout2, s2);
 	 fa fa_3(s1,s2,e,cout3,s);
  fa fa_4(cout2,cout1,cout3,co1,co0);
 	 
endmodule

// 5-input 4-bit ripple-carry adder (structural Verilog)
// IMPORTANT: Do not change module or port names
module adder5 (a,b,c,d,e, sum);
    input [3:0] a,b,c,d,e;
 	output[6:0] sum;
 	wire co1, co2, co3, co4, co5, c06, co7, co8, co9;
    // your code here
    // do not use any delays!
  fa5 first(a[0],b[0],c[0],d[0],e[0],0,0,co2,co1,sum[0]);
  fa5 second(a[1],b[1],c[1], d[1],e[1], 0,co1,co4,co3,sum[1]);
  fa5 third(a[2],b[2],c[2],d[2],e[2],co2,co3,co6,co5,sum[2]);
  fa5 fourth (a[3],b[3],c[3],d[3],e[3],co4,co5,co8,co7,sum[3]);
  fa one(co6,co7,0,co9,sum[4]);
  fa two(co8,co9,0,sum[6],sum[5]);
  
endmodule











