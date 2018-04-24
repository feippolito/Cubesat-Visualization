Xxaxis=[0;3]
Yxaxis=[0;0]
Zxaxis=[0;0]

Xyaxis=[0;0]
Yyaxis=[0;3]
Zyaxis=[0;0]

Xzaxis=[0;0]
Yzaxis=[0;0]
Zzaxis=[0;3]

hold on
xaxis = fill3(Xxaxis,Yxaxis,Zxaxis,'k','FaceAlpha',0.5);
yaxis = fill3(Xyaxis,Yyaxis,Zyaxis,'k','FaceAlpha',0.5);
zaxis = fill3(Xzaxis,Yzaxis,Zzaxis,'k','FaceAlpha',0.5);
xlabel('X');
ylabel('Y'); 
zlabel('Z');
axis([-5 5 -5 5 -5 5])
grid on
box on

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
        
    Xxaxis=reshape(Vx(1,:),1,2);
    Yxaxis=reshape(Vx(2,:),1,2);
    Zxaxis=reshape(Vx(3,:),1,2);
    
    Xyaxis=reshape(Vy(1,:),1,2);
    Yyaxis=reshape(Vy(2,:),1,2);
    Zyaxis=reshape(Vy(3,:),1,2);
    
    Xzaxis=reshape(Vz(1,:),1,2);
    Yzaxis=reshape(Vz(2,:),1,2);
    Zzaxis=reshape(Vz(3,:),1,2);
    
    set(xaxis,'XData',Xxaxis);
    set(xaxis,'YData',Yxaxis);
    set(xaxis,'ZData',Zxaxis);
    
    set(yaxis,'XData',Xyaxis);
    set(yaxis,'YData',Yyaxis);
    set(yaxis,'ZData',Zyaxis);
    
    set(zaxis,'XData',Xzaxis);
    set(zaxis,'YData',Yzaxis);
    set(zaxis,'ZData',Zzaxis);
    
    drawnow 
    
    t
    
    pause(0.001); 

end
