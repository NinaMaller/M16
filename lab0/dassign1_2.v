// EEM16 - Logic Design
// Design Assignment #1 - Problem #1.2
// dassign1_2.v
// Verilog template

// You may define any additional modules as necessary
// Do not change the module or port names of these stubs

// Max/argmax (declarative verilog)
// IMPORTANT: Do not change module or port names
module mam (in1_value, in1_label, in2_value, in2_label, out_value, out_label);
    input   [7:0] in1_value, in2_value;
    input   [4:0] in1_label, in2_label;
    output  [7:0] out_value;
    output  [4:0] out_label;
    // your code here
    // do not use any delays!
  	reg sel; //select input?
  
  
  //1 if in1 is bigger, 0 if in2 is bigger or equal
 /* always @ (sel or in1_value or in2_value)
    begin 
      if(in1_value[0] > in2_value[0])
        select == 1; //the first is bigger
      if(in1_value[1] > in2_value[1])
        select == 1; //the first is bigger
      if(in1_value[2] > in2_value[2])
        select == 1; //the first is bigger
      if(in1_value[3] > in2_value[3])
        select == 1; //the first is bigger
      if(in1_value[4] > in2_value[4])
        select == 1; //the first is bigger
      if(in1_value[5] > in2_value[5])
        select == 1; //the first is bigger
      if(in1_value[6] > in2_value[6])
        select == 1; //the first is bigger
      if(in1_value[6] > in2_value[6])
        select = 1; //the first is bigger
      	out_label = in1
      else
        select == 0;
    end*/
  
  always @ (sel or in1_value or in2_value)
    begin 
      if(in1_value >= in2_value) //value 1 is greater or equal
        out_value = in1_value;
      	out_label = in1_label;
      else //value 2 is greater
        out_value = in2_value;
      	out_label = out2_label;
    end
        
  
     

  
endmodule

// Maximum index (structural verilog)
// IMPORTANT: Do not change module or port names
module maxindex(a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t,u,v,w,x,y,z,out);
    input [7:0] a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t,u,v,w,x,y,z;
    output [4:0] out;
    // your code here
    // do not use any delays!
  
  
  
endmodule










