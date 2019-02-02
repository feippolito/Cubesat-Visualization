xColor = [ 0 0 0.8];
yColor = [ 0 0.8 0];
zColor = [ 0.8 0 0];
OtherColor = [0.2 0.2 0.2]
scatterColor = zColor

map = [zColor,
       yColor,
       xColor,
       OtherColor];

colormap(map)

Xxaxis=[0;3]    %Cube X Axis
Yxaxis=[0;0]
Zxaxis=[0;0]

Xyaxis=[0;0]
Yyaxis=[0;3]    %Cube Y Axis
Zyaxis=[0;0]    

Xzaxis=[0;0]
Yzaxis=[0;0]
Zzaxis=[0;3]    %Cube Z Axis

AL = 5   %Define Axis limits

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

C = [10 ; 2 ; 4 ; 10 ; 6 ;10];


hold on
cubo  = fill3(X,Y,Z,C);
xaxis = fill3(Xxaxis,Yxaxis,Zxaxis,'r','FaceAlpha',0.5);
yaxis = fill3(Xyaxis,Yyaxis,Zyaxis,'r','FaceAlpha',0.5);
zaxis = fill3(Xzaxis,Yzaxis,Zzaxis,'r','FaceAlpha',0.5);

Fixedxaxis = fill3([0;3],[0;0],[0;0],'k');
Fixedyaxis = fill3([0;0],[0;3],[0;0],'k');
Fixedzaxis = fill3([0;0],[0;0],[0;3],'k');

OFx=scatter3(3,0,0,'filled','MarkerEdgeColor','k','MarkerFaceColor',xColor)
OFy=scatter3(0,3,0,'filled','MarkerEdgeColor','k','MarkerFaceColor',yColor)
OFz=scatter3(0,0,3,'filled','MarkerEdgeColor','k','MarkerFaceColor',zColor)

Ox=scatter3(Xxaxis(2),Yxaxis(2),Zxaxis(2),'filled','MarkerEdgeColor','k','MarkerFaceColor',xColor)
Oy=scatter3(Xyaxis(2),Yyaxis(2),Zyaxis(2),'filled','MarkerEdgeColor','k','MarkerFaceColor',yColor)
Oz=scatter3(Xzaxis(2),Yzaxis(2),Zzaxis(2),'filled','MarkerEdgeColor','k','MarkerFaceColor',zColor)

view(45,45)
xlabel('X');
ylabel('Y'); 
zlabel('Z');
axis([-AL AL -AL AL -AL AL])
title('\fontsize{16}')
grid on
box on

cubo2  =  [reshape(X,1,24); reshape(Y,1,24); reshape(Z,1,24)]
xaxis2 =  [Xxaxis';Yxaxis';Zxaxis']
yaxis2 =  [Xyaxis';Yyaxis';Zyaxis']
zaxis2 =  [Xzaxis';Yzaxis';Zzaxis']

for t=0:0.1:1000

    q1=cos(0.2*t);
    q2=0.2*cos(t);
    q3=(cos(0.2*t+pi));
    q4=(cos(0.25*t));   
    
    q=[q1 q2 q3 q4];
        
    DCM = quat2dcm(q);
    Vx = DCM'*xaxis2;
    Vy = DCM'*yaxis2;
    Vz = DCM'*zaxis2;
    V = DCM'*cubo2;
        
    Xxaxis=reshape(Vx(1,:),1,2);
    Yxaxis=reshape(Vx(2,:),1,2);
    Zxaxis=reshape(Vx(3,:),1,2);
        
    Xyaxis=reshape(Vy(1,:),1,2);
    Yyaxis=reshape(Vy(2,:),1,2);
    Zyaxis=reshape(Vy(3,:),1,2);
    
    Xzaxis=reshape(Vz(1,:),1,2);
    Yzaxis=reshape(Vz(2,:),1,2);
    Zzaxis=reshape(Vz(3,:),1,2);
    
    X=reshape(V(1,:),4,6);
    Y=reshape(V(2,:),4,6);
    Z=reshape(V(3,:),4,6);
    
    set(xaxis,'XData',Xxaxis);
    set(xaxis,'YData',Yxaxis);
    set(xaxis,'ZData',Zxaxis);
    
    set(yaxis,'XData',Xyaxis);
    set(yaxis,'YData',Yyaxis);
    set(yaxis,'ZData',Zyaxis);
    
    set(zaxis,'XData',Xzaxis);
    set(zaxis,'YData',Yzaxis);
    set(zaxis,'ZData',Zzaxis);
    
    set(cubo,'XData',X);
    set(cubo,'YData',Y);
    set(cubo,'ZData',Z);
    set(cubo,'FaceVertexCData',C);
    
    set(Ox,'XData',Xxaxis(2));
    set(Ox,'YData',Yxaxis(2));
    set(Ox,'ZData',Zxaxis(2));
    
    set(Oy,'XData',Xyaxis(2));
    set(Oy,'YData',Yyaxis(2));
    set(Oy,'ZData',Zyaxis(2));
    
    set(Oz,'XData',Xzaxis(2));
    set(Oz,'YData',Yzaxis(2));
    set(Oz,'ZData',Zzaxis(2));
    
    if (mod(t,0.1) == 0)
        %scatter3(Xzaxis(2),Yzaxis(2),Zzaxis(2),'filled','MarkerEdgeColor','k','MarkerFaceColor',scatterColor)
    end
    drawnow 
    pause(0.0001); 

end

%}