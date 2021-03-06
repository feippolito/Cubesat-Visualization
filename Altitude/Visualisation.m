function Visualisation (q)      
%Cubesat altitude visualisation with quatenion as input

interval = 0.001;               %Interval (seconds)
view(135,45)                    %Starting view
AL = 5;                         %Define graph axis limits

xColor = [ 0 0 0.6];
yColor = [ 0 0.6 0];
zColor = [ 0.6 0 0];            %Axis/Faces Colors
CubeColor = [0.2 0.2 0.2];      %Cube Color

s=5;                            %Scatter size
SI=5;                           %Scatter interval
scatterColorx = xColor;         %Scatter color x axis
scatterColory = yColor;         %Scatter color y axis
scatterColorz = zColor;         %Scatter color z axis

FAL = 5;                        %Fixed axis lenght
CAL = 2;                        %Cube  axis lenght

Xxaxis=[0;CAL];                 
Yxaxis=[0;0];
Zxaxis=[0;0];

Xyaxis=[0;0];
Yyaxis=[0;CAL];                
Zyaxis=[0;0];    

Xzaxis=[0;0];
Yzaxis=[0;0];
Zzaxis=[0;CAL];                 

width  =  1;                    %Cube size
length = 1;
height = 1;

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

X = X*length;
Y = Y*width;
Z = Z*height;

map = [zColor;yColor;xColor;CubeColor];
colormap(map);

hold on
cubo  = fill3(X,Y,Z,C);
xaxis = fill3(Xxaxis,Yxaxis,Zxaxis,'r');
yaxis = fill3(Xyaxis,Yyaxis,Zyaxis,'r');
zaxis = fill3(Xzaxis,Yzaxis,Zzaxis,'r');

fill3([0;FAL],[0;0],[0;0],'k');
fill3([0;0],[0;FAL],[0;0],'k');
fill3([0;0],[0;0],[0;FAL],'k');

scatter3(FAL,0,0,'filled','MarkerEdgeColor','k','MarkerFaceColor',xColor)
scatter3(0,FAL,0,'filled','MarkerEdgeColor','k','MarkerFaceColor',yColor)
scatter3(0,0,FAL,'filled','MarkerEdgeColor','k','MarkerFaceColor',zColor)

Ox=scatter3(Xxaxis(2),Yxaxis(2),Zxaxis(2),'filled','MarkerEdgeColor','k','MarkerFaceColor',xColor);
Oy=scatter3(Xyaxis(2),Yyaxis(2),Zyaxis(2),'filled','MarkerEdgeColor','k','MarkerFaceColor',yColor);
Oz=scatter3(Xzaxis(2),Yzaxis(2),Zzaxis(2),'filled','MarkerEdgeColor','k','MarkerFaceColor',zColor);

title('\fontsize{16}CubeSat')              %Plot title
xlabel('X');
ylabel('Y'); 
zlabel('Z');
axis([-AL AL -AL AL -AL AL]);
grid on
box on

cubo2  =  [reshape(X,1,24); reshape(Y,1,24); reshape(Z,1,24)];
xaxis2 =  [Xxaxis';Yxaxis';Zxaxis'];
yaxis2 =  [Xyaxis';Yyaxis';Zyaxis'];
zaxis2 =  [Xzaxis';Yzaxis';Zzaxis'];

for t=1:size(q,1)

    Q=q(t,:);  
    Q;
    DCM = quat2dcm(Q);
    
    Vx = DCM'*xaxis2;
    Vy = DCM'*yaxis2;
    Vz = DCM'*zaxis2;
    V  = DCM'*cubo2;
        
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
    
    if(rem(t,SI)==0)                    
        scatter3(Xxaxis(2),Yxaxis(2),Zxaxis(2),s,'filled','MarkerFaceColor',scatterColorx,'MarkerEdgeColor','k') %scatter X Axis
        scatter3(Xyaxis(2),Yyaxis(2),Zyaxis(2),s,'filled','MarkerFaceColor',scatterColory,'MarkerEdgeColor','k') %scatter Y Axis
        scatter3(Xzaxis(2),Yzaxis(2),Zzaxis(2),s,'filled','MarkerFaceColor',scatterColorz,'MarkerEdgeColor','k') %scatter Z Axis
    end
    
    drawnow
    pause(interval); 
end