//here you can impliment to fpga nad claock division concept is used
`timescale 1ns / 1ps
module mod10count(input clk,reset,
 output reg [3:0]counter1,counter2,
 output reg [7:0]display, q,
 output reg [3:0]control);
wire [9:0]m;
reg clkdiv,clkms,flag;
integer temp1,temp2;
initial
begin
temp1=0;
temp2=0;
counter1=0;
counter2=4'b0000;
clkdiv=1'b0;
flag=0;
clkms=0;
end
always@(posedge clk)
begin
temp1=temp1+1;
temp2=temp2+1;
if(temp1==2000000)
begin
clkdiv=~clkdiv;
temp1=0;
end
if(temp2==200)
begin
clkms=~clkms;
temp2=0;
end
end
assign m[0]=q[7]&q[6]&q[5]&(~q[4])&q[3]&q[2]&(~q[1])&(q[0]);
assign m[1]=(~q[7])&(~q[6])&q[5]&(~q[4])&q[3]&(~q[2])&q[1]&q[0];
assign m[2]=q[7]&q[6]&(~q[5])&(q[4])&q[3]&(~q[2])&(~q[1])&q[0];
assign m[3]=q[7]&q[6]&(~q[5])&(q[4])&q[3]&q[2]&q[1]&q[0];
assign m[4]=q[7]&q[6]&(~q[5])&(q[4])&q[3]&q[2]&(~q[1])&(~q[0]);
assign m[5]=q[7]&(~q[6])&q[5]&(q[4])&(~q[3])&q[2]&q[1]&q[0];
assign m[6]=(~q[7])&q[6]&q[5]&(q[4])&(~q[3])&q[2]&q[1]&q[0];
assign m[7]=(~q[7])&(~q[6])&q[5]&(q[4])&(~q[3])&(~q[2])&q[1]&q[0];
assign m[8]=(~q[7])&(~q[6])&q[5]&(~q[4])&q[3]&q[2]&(~q[1])&q[0];
assign m[9]=q[7]&q[6]&~q[5]&(q[4])&q[3]&(~q[2])&(~q[1])&(~q[0]);

always@(posedge clkdiv)
begin
if(reset)
begin
q<=8'b11101101;
end
else
begin

q[7]<=m[1]|m[2]|m[3]|m[4]|m[8]|m[9];
q[6]<=m[1]|m[2]|m[3]|m[5]|m[8]|m[9];
q[5]<=m[0]|m[4]|m[5]|m[6]|m[7]|m[9];
q[4]<=m[1]|m[2]|m[3]|m[4]|m[5]|m[6]|m[8];
q[3]<=m[0]|m[1]|m[2]|m[3]|m[7]|m[8]|m[9];
q[2]<=m[2]|m[3]|m[4]|m[5]|m[7]|m[9];
q[1]<=m[0]|m[2]|m[4]|m[5]|m[6];
q[0]<=m[0]|m[1]|m[2]|m[4]|m[5]|m[6]|m[7]|m[9];
counter1<={q[3],q[2],q[1],q[0]};
counter2<={q[7],q[6],q[5],q[4]};
end
end

always@(posedge clkms)
begin

if (flag==1'b0)
begin
control=4'b0111;

case(counter2)
0:display=8'b11111100;
1:display=8'b01100000;
2:display=8'b11011010;
3:display=8'b11110010;
4:display=8'b01100110;
5:display=8'b10110110;
6:display=8'b10111110;
7:display=8'b11100000;
8:display=8'b11111110;
9:display=8'b11110110;
10:display=8'b11101110;
11:display=8'b00111110;
12:display=8'b10011100;
13:display=8'b01111010;
14:display=8'b10011110;
15:display=8'b10001110;
endcase
flag=1'b1;
end

else
   begin
control=4'b1011;

case(counter1)
0:display=8'b11111100;
1:display=8'b01100000;
2:display=8'b11011010;
3:display=8'b11110010;
4:display=8'b01100110;
5:display=8'b10110110;
6:display=8'b10111110;
7:display=8'b11100000;
8:display=8'b11111110;
9:display=8'b11110110;
10:display=8'b11101110;
11:display=8'b00111110;
12:display=8'b10011100;
13:display=8'b01111010;
14:display=8'b10011110;
15:display=8'b10001110;
endcase
flag=1'b0;
end
end
endmodule 
