// Code your design here
// EEM16 - Logic Design
// Design Assignment #1 - Problem #1.3
// dassign1_3.v
// Verilog template

// You may define any additional modules as necessary
// Do not change the module or port names of the given stubs

/* Arrays for convenience

  | abcdefghijklmnopqrstuvwxyz  <-- letter
_|__________________________
G | 11111111 00100111 11110001 11
F | 11001111 00110001 10101010 10
E | 11111101 01111111 01001100 01
D | 01111010 01110010 00101111 11
C | 11010011 11001110 10111100 10
B | 10010011 11000001 10011010 11
A | 10001110 00001001 10100001 01
^-- display segment
~

  | GFEDCBA <-- display segment
_|_______
a | 1110111
b | 1111100
c | 1011000
d | 1011110
e | 1111001
f | 1110001
g | 1101111
h | 1110110
i | 0000110
j | 0011110
k | 1111000
l | 0111000
m | 0010101
n | 1010100
o | 1011100
p | 1110011
q | 1100111
r | 1010000
s | 1101101
t | 1000110
u | 0111110
v | 0011100
w | 0101010
x | 1001001
y | 1101110
z | 1011011
^-- letter
*/


// Display driver (procedural verilog)
// IMPORTANT: Do not change module or port names
module display_rom (letter, display);
    input   [4:0] letter;
    output  [6:0] display;
 	 reg [6:0] display;
    // your code here
  
  always @(*)
    begin
      case (letter)
        5'b00000: assign display = 7'b1110111;
      	5'b00001: assign display = 7'b1111100;
      	5'b00010: assign display = 7'b1011000;
      	5'b00011: assign display = 7'b1011110;
      	5'b00100: assign display = 7'b1111001;
      	5'b00101: assign display = 7'b1110001;
      	5'b00110: assign display = 7'b1101111;
       	5'b00111: assign display = 7'b1110110;
        
        5'b01000: assign display = 7'b0000110;
		5'b01001: assign display = 7'b0011110;
		5'b01010: assign display = 7'b1111000;
		5'b01011: assign display = 7'b0111000;
		5'b01100: assign display = 7'b0010101;
		5'b01101: assign display = 7'b1010100;
		5'b01110: assign display = 7'b1011100;
		5'b01111: assign display = 7'b1110011;
        
        5'b10000: assign display = 7'b1100111;
        5'b10001: assign display = 7'b1010000;
        5'b10010: assign display = 7'b1101101;
        5'b10011: assign display = 7'b1000110;
        5'b10100: assign display = 7'b0111110;
        5'b10101: assign display = 7'b0011100;
        5'b10110: assign display = 7'b0101010;
        5'b10111: assign display = 7'b1001001;
        
       5'b11000 : assign display = 7'b1101110;
       5'b11001 : assign display = 7'b1011011;
        
        default : assign display = 7'b1000000; //dash
   
      endcase
     end

    // do not use any delays!
endmodule






//1.3b

//define an 8 bit input MUX
module MUX_8(a,b,c,d,e,f,g,h,sel,out);
 
  input a,b,c,d,e,f,g,h;
  input [2:0] sel; // compare first 3 bits 
  output out;
  
  reg out; //to use case statement

  always @ (*)
    begin
      case(sel)
        3'b000: out=a;
        3'b001: out=b;
        3'b010: out=c;
        3'b011: out=d;
        3'b100: out=e;
        3'b101: out=f;
        3'b110: out=g;
        3'b111: out=h;
        default: out = 0; //NEEDED?
        //default : assign display = 7'b1000000; //dash
   
      endcase
    end
endmodule

//define a 4 bit input MUX
module MUX_4(a,b,c,d,sel,out);
  input a,b,c,d;
  input [1:0] sel; // compare last 2 bits
  output  out;
  
  reg out; // to use in case statement

  always @ (*)
    begin
      case(sel)
        2'b00: out=a;
        2'b01: out=b;
        2'b10: out=c;
        2'b11: out=d;
      endcase
    end
endmodule


module MUX_A (sel, out);
  input [4:0] sel; // 5 bits to represent selected value
  output out; // 0 or 1 (on or off)
//reg out;
wire _1, _2, _3, _4;

  MUX_8 first(1'b1,1'b0,1'b0,1'b0,1'b1,1'b1,1'b1,1'b0,sel[2:0],_1);
  MUX_8 second(1'b0,1'b0,1'b0,1'b0,1'b1,1'b0,1'b0,1'b1,sel[2:0],_2);
  MUX_8 third(1'b1,1'b0,1'b1,1'b0,1'b0,1'b0,1'b0,1'b1,sel[2:0],_3);
  MUX_8 fourth(1'b0,1'b1,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,sel[2:0],_4);
  MUX_4 last(_1,_2,_3,_4,sel[4:3],out);

endmodule



module MUX_B (sel, out);
  input [4:0] sel; // 5 bits to represent selected value
  output out; // 0 or 1 (on or off)
//reg out;
  wire _5, _6, _7, _8;

  MUX_8 first(1'b1,1'b0,1'b0,1'b1,1'b0,1'b0,1'b1,1'b1,sel[2:0],_5);
  MUX_8 second(1'b1,1'b1,1'b0,1'b0,1'b0,1'b0,1'b0,1'b1,sel[2:0],_6);
  MUX_8 third(1'b1,1'b0,1'b0,1'b1,1'b1,1'b0,1'b1,1'b0,sel[2:0],_7);
  MUX_8 fourth(1'b1,1'b1,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,sel[2:0],_8);
  MUX_4 last(_5,_6,_7,_8,sel[4:3],out);

endmodule


module MUX_C (sel, out);
  input [4:0] sel; // 5 bits to represent selected value
  output out; // 0 or 1 (on or off)
//reg out;
  wire _9, _10, _11, _12;

  MUX_8 first(1'b1,1'b1,1'b0,1'b1,1'b0,1'b0,1'b1,1'b1,sel[2:0],_9);
  MUX_8 second(1'b1,1'b1,1'b0,1'b0,1'b1,1'b1,1'b1,1'b0,sel[2:0],_10);
  MUX_8 third(1'b1,1'b0,1'b1,1'b1,1'b1,1'b1,1'b0,1'b0,sel[2:0],_11);
  MUX_8 fourth(1'b1,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,sel[2:0],_12);
  MUX_4 last(_9,_10,_11,_12,sel[4:3],out);

endmodule


module MUX_D (sel, out);
  input [4:0] sel; // 5 bits to represent selected value
  output out; // 0 or 1 (on or off)
//reg out;
  wire _13, _14, _15, _16;

  MUX_8 first(1'b0,1'b1,1'b1,1'b1,1'b1,1'b0,1'b1,1'b0,sel[2:0],_13);
  MUX_8 second(1'b0,1'b1,1'b1,1'b1,1'b0,1'b0,1'b1,1'b0,sel[2:0],_14);
  MUX_8 third(1'b0,1'b0,1'b1,1'b0,1'b1,1'b1,1'b1,1'b1,sel[2:0],_15);
  MUX_8 fourth(1'b1,1'b1,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,sel[2:0],_16);
  MUX_4 last(_13,_14,_15,_16,sel[4:3],out);

endmodule



module MUX_E (sel, out);
  input [4:0] sel; // 5 bits to represent selected value
  output out; // 0 or 1 (on or off)
//reg out;
  wire _17, _18, _19, _20;

  MUX_8 first(1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b0,1'b1,sel[2:0],_17);
  MUX_8 second(1'b0,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,sel[2:0],_18);
  MUX_8 third(1'b0,1'b1,1'b0,1'b0,1'b1,1'b1,1'b0,1'b0,sel[2:0],_19);
  MUX_8 fourth(1'b0,1'b1,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,sel[2:0],_20);
  MUX_4 last(_17,_18,_19,_20,sel[4:3],out);

endmodule


module MUX_F (sel, out);
  input [4:0] sel; // 5 bits to represent selected value
  output out; // 0 or 1 (on or off)
//reg out;
  wire _21, _22, _23, _24;

  MUX_8 first(1'b1,1'b1,1'b0,1'b0,1'b1,1'b1,1'b1,1'b1,sel[2:0],_21);
  MUX_8 second(1'b0,1'b0,1'b1,1'b1,1'b0,1'b0,1'b0,1'b1,sel[2:0],_22);
  MUX_8 third(1'b1,1'b0,1'b1,1'b0,1'b1,1'b0,1'b1,1'b0,sel[2:0],_23);
  MUX_8 fourth(1'b1,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,sel[2:0],_24);
  MUX_4 last(_21,_22,_23,_24,sel[4:3],out);

endmodule

module MUX_G (sel, out);
  input [4:0] sel; // 5 bits to represent selected value
  output out; // 0 or 1 (on or off)
//reg out;
  wire _25, _26, _27, _28;

  MUX_8 first(1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,sel[2:0],_25);
  MUX_8 second(1'b0,1'b0,1'b1,1'b0,1'b0,1'b1,1'b1,1'b1,sel[2:0],_26);
  MUX_8 third(1'b1,1'b1,1'b1,1'b1,1'b0,1'b0,1'b0,1'b1,sel[2:0],_27);
  MUX_8 fourth(1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,sel[2:0],_28);
  MUX_4 last(_25,_26,_27,_28,sel[4:3],out);

endmodule


// Display driver (declarative verilog)
// IMPORTANT: Do not change module or port names
module display_mux (letter, g,f,e,d,c,b,a);
    input   [4:0] letter;
    output  g,f,e,d,c,b,a;
    // your code here
 // wire g,f,e,d,c,b,a;
  MUX_G gm(letter, g);
  MUX_F fm(letter, f);
  MUX_E em(letter, e);
  MUX_D dm(letter, d);
  MUX_C cm(letter, c);
  MUX_B bm(letter, b);
  MUX_A am(letter, a);


  
  
    // do not use any delays!
endmodule