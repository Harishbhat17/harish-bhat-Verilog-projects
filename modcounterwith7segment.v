module seq8bit(input clk,reset,
 output reg [3:0]counter1,counter2,
 output reg [7:0]display,
 output reg [3:0]control);
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

always@(posedge clkdiv)
begin
if(reset)
begin
counter1=4'b1101;
counter2=4'b1110;
end
else
begin
case({counter2,counter1})
237:{counter2,counter1}=43;
43:{counter2,counter1}=217;
217:{counter2,counter1}=223;
223:{counter2,counter1}=220;
220:{counter2,counter1}=183;
183:{counter2,counter1}=119;
119:{counter2,counter1}=51;
51:{counter2,counter1}=45;
45:{counter2,counter1}=216;
216:{counter2,counter1}=237;
default:{counter2,counter1}=237;
endcase
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
