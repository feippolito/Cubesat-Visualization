X = [-1 -1 -1 -1  1 -1;
     -1 -1 -1 -1  1 -1;
      1  1  1 -1  1  1;
      1  1  1 -1  1  1];

Y = [-1 -1  1 -1 -1 -1;
      1  1  1 -1 -1 -1;
      1  1  1  1  1 -1;
     -1 -1  1  1  1 -1];
 
Z = [-1  1 -1 -1 -1 -1;
     -1  1  1  1  1  1;
     -1  1  1  1  1  1;
     -1  1 -1 -1 -1 -1];

SX=X(:,2)
SY=Y(:,2)
SZ=Z(:,2)

surfnorm(SX,SY,SZ)
%{
P1=[SX(1) SY(1) SZ(1)]
P2=[SX(2) SY(2) SZ(2)]
P3=[SX(3) SY(3) SZ(3)]
 
A=P2-P1
B=P3-P1
  
AxB = cross(A,B)
 
%f=AxB(1)*(x-SX(1))+AxB(2)*(y-SY(1))+AxB(3)*(z-SZ(1))
x = 1:100
y = 1:100
z=(-AxB(1)*(x-SX(1))-AxB(2)*(y-SY(1))+AxB(3)*SZ(1))/AxB(3)

plot3(x,y,z)
%}