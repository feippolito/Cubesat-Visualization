Xxaxis=[0;3]
Yxaxis=[0;0]
Zxaxis=[0;0]

Xyaxis=[0;0]
Yyaxis=[0;3]
Zyaxis=[0;0]

Xzaxis=[0;0]
Yzaxis=[0;0]
Zzaxis=[0;3]

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

C = [1 ; 10 ; 5 ; 1 ; 8.5 ;1];

hold on
cubo  =  fill3(X,Y,Z,C);
xaxis = fill3(Xxaxis,Yxaxis,Zxaxis,'r','FaceAlpha',0.5);
yaxis = fill3(Xyaxis,Yyaxis,Zyaxis,'r','FaceAlpha',0.5);
zaxis = fill3(Xzaxis,Yzaxis,Zzaxis,'r','FaceAlpha',0.5);

Fixedxaxis = fill3([0;3],[0;0],[0;0],'k');
Fixedyaxis = fill3([0;0],[0;3],[0;0],'k');
Fixedzaxis = fill3([0;0],[0;0],[0;3],'k');

OFx=scatter3(3,0,0,'filled','MarkerEdgeColor','k','MarkerFaceColor',[1 0.5 0])
OFy=scatter3(0,3,0,'filled','MarkerEdgeColor','k','MarkerFaceColor',[0 1 1])
OFz=scatter3(0,0,3,'filled','MarkerEdgeColor','k','MarkerFaceColor',[1 1 0 ])

view(45,45)
xlabel('X');
ylabel('Y'); 
zlabel('Z');
axis([-5 5 -5 5 -5 5])
title('\fontsize{16}X Orange - Y Teal - Z Yellow')
grid on
box on

cubo2  =  [reshape(X,1,24); reshape(Y,1,24); reshape(Z,1,24)]
xaxis2 =  [Xxaxis';Yxaxis';Zxaxis']
yaxis2 =  [Xyaxis';Yyaxis';Zyaxis']
zaxis2 =  [Xzaxis';Yzaxis';Zzaxis']


for t=0:0.01:1000

    q1=cos(t);
    q2=sin(t+pi/2);
    q3=(cos(t))^2;
    q4=(sin(t+3*pi/2));
  
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
    
    
    
    drawnow 
    
    t
    
    pause(0.01); 

end

%}