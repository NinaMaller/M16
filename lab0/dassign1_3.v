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
G | 11111111001001111111000111
F | 11001111001100011010101010
E | 11111101011111110100110001
D | 01111010011100100010111111
C | 11010011110011101011110010
B | 10010011110000011001101011
A | 10001110000010011010000101
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

//used this link for help on the rom
/*http://www.asic-world.com/examples/verilog/rom_eprom_eeprom.html*/
module rom(address, data, read);
  input[4:0] address;
  output[6:0] data;
  input read;

  reg [6:0] data;
  
  always @(read or address)
    begin
      case (address)
        
      	5'b00000: data = 7'b1110111;
      	5'b00001: data = 7'b1111100;
      	5'b00010: data = 7'b1011000;
      	5'b00011: data = 7'b1011110;
      	5'b00100: data = 7'b1111001;
      	5'b00101: data = 7'b1110001;
      	5'b00110: data = 7'b1101111;
       	5'b00111: data = 7'b1110110;
        
        5'b01000: data = 7'b0000110;
		5'b01001: data = 7'b0011110;
		5'b01010: data = 7'b1111000;
		5'b01011: data = 7'b0111000;
		5'b01100: data = 7'b0010101;
		5'b01101: data = 7'b1010100;
		5'b01110: data = 7'b1011100;
		5'b01111: data = 7'b1110011;
        
        5'b10000: data = 7'b1100111;
        5'b10001: data = 7'b1010000;
        5'b10010: data = 7'b1101101;
        5'b10011: data = 7'b1000110;
        5'b10100: data = 7'b0111110;
        5'b10101: data = 7'b0011100;
        5'b10110: data = 7'b0101010;
        5'b10111: data = 7'b1001001;
        
       5'b11000 : data = 7'b1101110;
       5'b11001 : data = 7'b1011011;
       5'b11010 : data = 7'b1000000;
       5'b11011 : data = 7'b1000000;
       5'b11100 : data = 7'b1000000;
       5'b11101 : data = 7'b1000000;
       5'b11110 : data = 7'b1000000;
       5'b11111 : data = 7'b1000000;
        
      endcase
     end
 endmodule
        
  
// Display driver (procedural verilog)
// IMPORTANT: Do not change module or port names
module display_rom (letter, display);
    input   [4:0] letter;
    output  [6:0] display;
    // your code here
  rom rom(letter, display,1);
  
    // do not use any delays!
endmodule


module MUX_8(a,b,c,d,e,f,g,h,sel,out);
 
  input a,b,c,d,e,f,g,h;
  input [2:0] sel;
  output out;
  reg out;
  //took out or
  always @ (a or b or c or d or e or f or g or h or sel)
    begin
      case(sel)
        3'b000 : out=a;
        3'b001 : out=b;
        3'b010 : out=c;
        3'b011 : out=d;
        3'b100 : out=e;
        3'b101 : out=f;
        3'b110 : out=g;
        3'b111 : out=h;
      endcase
    end
endmodule

module MUX_4(a,b,c,d,sel,out);
  input a,b,c,d;
  input [1:0] sel;
  output  out;
  reg out;
  //took out or
  always @ (a or b or c or d or sel)
    begin
      case(sel)
        2'b00 : out=a;
        2'b01 : out=b;
        2'b10 : out=c;
        2'b11 : out=d;
      endcase
    end
endmodule

module MUXB(sel,out);
  input [4:0] sel;
  output out;
  reg out;
  
  always @ (sel)
    begin
      case(sel)
        //B cases
        5'b00000: out = 1'b1;
      	5'b00001: out = 1'b0;
      	5'b00010: out = 1'b0;
      	5'b00011: out = 1'b1;
      	5'b00100: out = 1'b0;
      	5'b00101: out = 1'b0;
      	5'b00110: out = 1'b1;
       	5'b00111: out = 1'b1;
        
        5'b01000: out = 1'b1;
		5'b01001: out = 1'b1;
		5'b01010: out = 1'b0;
		5'b01011: out = 1'b0;
		5'b01100: out = 1'b0;
		5'b01101: out = 1'b0;
		5'b01110: out = 1'b0;
		5'b01111: out = 1'b1;
        
        5'b10000: out = 1'b1;
        5'b10001: out = 1'b0;
        5'b10010: out = 1'b0;
        5'b10011: out = 1'b1;
        5'b10100: out = 1'b1;
        5'b10101: out = 1'b0;
        5'b10110: out = 1'b1;
        5'b10111: out = 1'b0;
        
       5'b11000 : out = 1'b1;
       5'b11001 : out = 1'b1;
       5'b11010 : out = 1'b0;
       5'b11011 : out = 1'b0;
       5'b11100 : out = 1'b0;
       5'b11101 : out = 1'b0;
       5'b11110 : out = 1'b0;
       5'b11111 : out = 1'b0;
        
     
      endcase
    end
    endmodule

module MUXC(sel, out);
input [4:0] sel;
output out;
reg out;
always @ (sel)
    begin
     case (sel)
       //C cases
      5'b00000 : out = 1'b1;
      5'b00001 : out = 1'b1;
      5'b00010 : out = 1'b0;
      5'b00011 : out = 1'b1;
      5'b00100 : out = 1'b0;
      5'b00101 : out = 1'b0;
      5'b00110 : out = 1'b1;
      5'b00111 : out = 1'b1;
      5'b01000 : out = 1'b1;
      5'b01001 : out = 1'b1;
      5'b01010 : out = 1'b0;
      5'b01011 : out = 1'b0;
      5'b01100 : out = 1'b1;
      5'b01101 : out = 1'b1;
      5'b01110 : out = 1'b1;
      5'b01111 : out = 1'b0;
      5'b10000 : out = 1'b1;
      5'b10001 : out = 1'b0;
      5'b10010 : out = 1'b1;
      5'b10011 : out = 1'b1;
      5'b10100 : out = 1'b1;
      5'b10101 : out = 1'b1;
      5'b10110 : out = 1'b0;
      5'b10111 : out = 1'b0;
      5'b11000 : out = 1'b1;
      5'b11001 : out = 1'b0;
      5'b11010 : out = 1'b0;
      5'b11011 : out = 1'b0;
      5'b11100 : out = 1'b0;
      5'b11101 : out = 1'b0;
      5'b11110 : out = 1'b0;
      5'b11111 : out = 1'b0;
      endcase  
    end
endmodule
          
module MUXD(sel,out);
  input [4:0] sel;
  output out;
  reg out;
  
  always @ (sel)
    begin
      case(sel)
        5'b00000 : out = 1'b0;
       5'b00001 : out = 1'b1;
       5'b00010 : out = 1'b1;
       5'b00011 : out = 1'b1;
       5'b00100 : out = 1'b1;
       5'b00101 : out = 1'b0;
       5'b00110 : out = 1'b1;
       5'b00111 : out = 1'b0;
       5'b01000 : out = 1'b0;
       5'b01001 : out = 1'b1;
       5'b01010 : out = 1'b1;
       5'b01011 : out = 1'b1;
       5'b01100 : out = 1'b0;
       5'b01101 : out = 1'b0;
       5'b01110 : out = 1'b1; 
       5'b01111 : out = 1'b0;
       5'b10000 : out = 1'b0;
       5'b10001 : out = 1'b0;
       5'b10010 : out = 1'b1;
       5'b10011 : out = 1'b0;
       5'b10100 : out = 1'b1;
       5'b10101 : out = 1'b1;
       5'b10110 : out = 1'b1;
       5'b10111 : out = 1'b1;
       5'b11000 : out = 1'b1;
       5'b11001 : out = 1'b1;
       5'b11010 : out = 1'b1;
       5'b11011 : out = 1'b0;
       5'b11100 : out = 1'b0;
       5'b11101 : out = 1'b0;
       5'b11110 : out = 1'b0;
       5'b11111 : out = 1'b0;
        
        
      endcase
    end
endmodule


       module MUXE(sel,out);
  input [4:0] sel;
  output out;
  reg out;
  
  always @ (sel)
    begin
      case(sel)
        //E cases
        5'b00000: out = 1'b1;
      	5'b00001: out = 1'b1;
      	5'b00010: out = 1'b1;
      	5'b00011: out = 1'b1;
      	5'b00100: out = 1'b1;
      	5'b00101: out = 1'b1;
      	5'b00110: out = 1'b0;
       	5'b00111: out = 1'b1;
        
        5'b01000: out = 1'b0;
		5'b01001: out = 1'b1;
		5'b01010: out = 1'b1;
		5'b01011: out = 1'b1;
		5'b01100: out = 1'b1;
		5'b01101: out = 1'b1;
		5'b01110: out = 1'b1;
		5'b01111: out = 1'b1;
        
        5'b10000: out = 1'b0;
        5'b10001: out = 1'b1;
        5'b10010: out = 1'b0;
        5'b10011: out = 1'b0;
        5'b10100: out = 1'b1;
        5'b10101: out = 1'b1;
        5'b10110: out = 1'b0;
        5'b10111: out = 1'b0;
        
       5'b11000 : out = 1'b0;
       5'b11001 : out = 1'b1;
       5'b11010 : out = 1'b0;
       5'b11011 : out = 1'b0;
       5'b11100 : out = 1'b0;
       5'b11101 : out = 1'b0;
       5'b11110 : out = 1'b0;
       5'b11111 : out = 1'b0;
       
     
      endcase
    end
    endmodule   

module MUXF(sel,out);
  input [4:0] sel;
  output out;
  reg out;
  
  always @ (sel)
    begin
      case(sel)
        //F cases
        5'b00000: out = 1'b1;
      	5'b00001: out = 1'b1;
      	5'b00010: out = 1'b0;
      	5'b00011: out = 1'b0;
      	5'b00100: out = 1'b1;
      	5'b00101: out = 1'b1;
      	5'b00110: out = 1'b1;
       	5'b00111: out = 1'b1;
        
        5'b01000: out = 1'b0;
		5'b01001: out = 1'b0;
		5'b01010: out = 1'b1;
		5'b01011: out = 1'b1;
		5'b01100: out = 1'b0;
		5'b01101: out = 1'b0;
		5'b01110: out = 1'b0;
		5'b01111: out = 1'b1;
        
        5'b10000: out = 1'b1;
        5'b10001: out = 1'b0;
        5'b10010: out = 1'b1;
        5'b10011: out = 1'b0;
        5'b10100: out = 1'b1;
        5'b10101: out = 1'b0;
        5'b10110: out = 1'b1;
        5'b10111: out = 1'b0;
        
       5'b11000 : out = 1'b1;
       5'b11001 : out = 1'b0;
       5'b11010 : out = 1'b0;
       5'b11011 : out = 1'b0;
       5'b11100 : out = 1'b0;
       5'b11101 : out = 1'b0;
       5'b11110 : out = 1'b0;
       5'b11111 : out = 1'b0;
       
     
      endcase
    end
    endmodule   

//G | 11111111001001111111000111

module MUXG (sel, out);

input [4:0] sel;
output out;
//reg out;
wire m1, m2, m3, m4;

  MUX_8 mux8_g1(1'b1,1'b1,1'b0,1'b0,1'b1,1'b0,1'b1,1'b1,sel[4:2],m1);
  MUX_8 mux8_g2(1'b1,1'b1,1'b0,1'b1,1'b1,1'b0,1'b1,1'b1,sel[4:2],m2);
  MUX_8 mux8_g3(1'b1,1'b1,1'b1,1'b1,1'b1,1'b0,1'b1,1'b1,sel[4:2],m3);
  MUX_8 mux8_g4(1'b1,1'b1,1'b0,1'b1,1'b1,1'b1,1'b1,1'b1,sel[4:2],m4);
  MUX_4 mux4_g1(m1,m2,m3,m4,sel[1:0],out);

endmodule

module MUXA (sel, out);
input [4:0] sel;
output out;
//reg out;
wire m1, m2, m3, m4;

  MUX_8 mux8_a1(1'b1,1'b1,1'b0,1'b1,1'b1,1'b0,1'b0,1'b0,sel[4:2],m1);
  MUX_8 mux8_a2(1'b0,1'b1,1'b0,1'b0,1'b0,1'b0,1'b1,1'b0,sel[4:2],m2);
  MUX_8 mux8_a3(1'b0,1'b1,1'b0,1'b0,1'b1,1'b0,1'b0,1'b0,sel[4:2],m3);
  MUX_8 mux8_a4(1'b0,1'b0,1'b0,1'b1,1'b0,1'b1,1'b0,1'b0,sel[4:2],m4);
MUX_4 mux4_a1(m1,m2,m3,m4,sel[1:0],out);

endmodule



// Display driver (declarative verilog)
// IMPORTANT: Do not change module or port names
module display_mux (letter, g,f,e,d,c,b,a);
    input   [4:0] letter;
    output  g,f,e,d,c,b,a;
    // your code here
  wire g,f,e,d,c,b,a;
 
MUXA aa(letter, a);
MUXB bb(letter, b);
MUXC cc(letter, c);
MUXD dd(letter, d);
MUXE ee(letter, e);
MUXF ff(letter, f);
MUXG gg(letter, g);
  
  
    // do not use any delays!
endmodule