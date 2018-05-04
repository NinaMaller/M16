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
  
  reg [7:0] v;
  reg [4:0] l;

  always @(in1_value or in2_value or in1_label or in2_label)
    begin 
      if(in1_value > in2_value) //value 1 is greater
        begin
          assign v = in1_value;
          assign l = in1_label;
        end
      else //value 2 is greater
        begin
 	 		assign v = in2_value;
         	assign l = in2_label;
        end
    end
        
  		assign out_value = v;
  		assign out_label = l;
endmodule


// Maximum index (structural verilog)
// IMPORTANT: Do not change module or port names
module maxindex(a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t,u,v,w,x,y,z,out);
    input [7:0] a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t,u,v,w,x,y,z;
    output [4:0] out;
    // your code here
    // do not use any delays!
  
  
  //assign each letter its 8 bit likelyhood value:
  wire [4:0] al,bl,cl,dl,el,fl,gl,hl,il,jl,kl,ll,ml,nl,ol,pl,ql,rl,sl,
 			 tl,ul,vl,wl,xl,yl,zl;
  
  /*
  //assign labels:
     	assign al = 5'b00000;
      	assign bl = 5'b00001;
      	assign cl = 5'b00010;
      	assign dl = 5'b00011;
      	assign el = 5'b00100;
      	assign fl = 5'b00101;
      	assign gl = 5'b00110;
       	assign hl = 5'b00111;
        
        assign il = 5'b01000;
		assign jl = 5'b01001;
		assign kl = 5'b01010;
		assign ll = 5'b01011;
		assign ml = 5'b01100;
		assign nl = 5'b01101;
		assign ol = 5'b01110;
		assign pl = 5'b01111; //15
        
        assign ql = 5'b10000;
        assign rl = 5'b10001;
        assign sl = 5'b10010;
        assign tl = 5'b10011;
        assign ul = 5'b10100;//20
        assign vl = 5'b10101;
        assign wl = 5'b10110;
        assign xl = 5'b10111;
        
       assign  yl = 5'b11000; 
       assign  zl = 5'b11001; //25  

 */
  
  wire [7:0] _1,_3,_5,_7,_9,_11,_13,_15,
 		_17,_19,_21,_23,_25,_27,_29,
  		_31,_33,_35,_37,_39,_41,
  		_43,_45,_47,_49,_51,_53;
  
  wire [4:0] _2,_4,_6,_8,_10,_12,_14,_16,
 		_18,_20,_22,_24,_26,_28,
  		_30,_32,_34,_36,_38,_40,_42,
  		_44,_46,_48,_50,_52,_54;
  
  /*
  
  mam AB(a,al,b,bl,_1,_2);
  mam CD(c,cl,d,dl,_3,_4);
  mam EF(e,el,f,fl,_5,_6);
  mam GH(g,gl,h,hl,_7,_8);
  mam IJ(i,il,j,jl,_9,_10);
  mam KL(k,kl,l,ll,_11,_12);
  mam MN(m,ml,n,nl,_13,_14);
  mam OP(o,ol,p,pl,_15,_16);
  mam QR(q,ql,r,rl,_17,_18);
  mam ST(s,sl,t,tl,_19,_20);
  mam UV(u,ul,v,vl,_21,_22);
  mam WX(w,wl,x,xl,_23,_24);
  mam YZ_1(y,yl,z,zl,_25,_26);
  
  //second row of mams: AD covers A though D
  mam AD(_1,_2,_3,_4,_27,_28);
  mam EH(_5,_6,_7,_8,_29,_30);
  mam IL(_9,_10,_11,_12,_31,_32);
  mam MP(_13,_14,_15,_16,_33,_34);
  mam QT(_17,_18,_19,_20,_35,_36);
  mam UX(_21,_22,_23,_24,_37,_38);
  mam YZ_2(_25,_26,8'b00000000,5'b00000,_39,_40);
  
  //third row of mams:
  mam AH(_27,_28,_29,_30,_41,_42);
  mam IP(_31,_32,_33,_34,_43,_44);
  mam QX(_35,_36,_37,_38,_45,_46);
  mam YZ_3(_39,_40,8'b00000000,5'b00000,_47,_48);
  
  //4th row of mams:
  mam AP(_41,_42,_43,_44,_49,_50);
  mam QZ(_45,_46,_47,_48,_51,_52);
  
  //last one:
  mam AZ(_49,_50,_51,_52,_53,_54);*/
  
  
  mam AB(a,5'b00000,b,5'b00001,_1,_2);
  mam CD(c,5'b00010,d,5'b00011,_3,_4);
  mam EF(e,5'b00100,f,5'b00101,_5,_6);
  mam GH(g,5'b00110,h,5'b00111,_7,_8);
  mam IJ(i,5'b01000,j,5'b01001,_9,_10);
  mam KL(k,5'b01010,l,5'b01011,_11,_12);
  mam MN(m,5'b01100,n,5'b01101,_13,_14);
  mam OP(o,5'b01110,p,5'b01111,_15,_16);
  mam QR(q,5'b10000,r,5'b10001,_17,_18);
  mam ST(s,5'b10010,t,5'b10011,_19,_20);
  mam UV(u,5'b10100,v,5'b10101,_21,_22);
  mam WX(w,5'b10110,x,5'b10111,_23,_24);
  mam YZ_1(y,5'b11000,z,5'b11001,_25,_26);
  
  //second row of mams: AD covers A though D
  mam AD(_1,_2,_3,_4,_27,_28);
  mam EH(_5,_6,_7,_8,_29,_30);
  mam IL(_9,_10,_11,_12,_31,_32);
  mam MP(_13,_14,_15,_16,_33,_34);
  mam QT(_17,_18,_19,_20,_35,_36);
  mam UX(_21,_22,_23,_24,_37,_38);
  mam YZ_2(_25,_26,8'b00000000,5'b00000,_39,_40);
  
  //third row of mams:
  mam AH(_27,_28,_29,_30,_41,_42);
  mam IP(_31,_32,_33,_34,_43,_44);
  mam QX(_35,_36,_37,_38,_45,_46);
  mam YZ_3(_39,_40,8'b00000000,5'b00000,_47,_48);
  
  //4th row of mams:
  mam AP(_41,_42,_43,_44,_49,_50);
  mam QZ(_45,_46,_47,_48,_51,_52);
  
  //last one:
  mam AZ(_49,_50,_51,_52,_53,_54);
  
  
  
   assign out = _54;
  
endmodule










