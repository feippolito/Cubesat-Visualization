function RTVisualisation(block,~)
%Cubesat altitude visualisation with quatenion as input

Q=[block.OutputPort(1).Data.signal1...
    block.OutputPort(1).Data.signal2...
    block.OutputPort(1).Data.signal3...
    block.OutputPort(1).Data.signal4];  %Get data from nonvirtual Bus - Simulink



AL = 5;                         %Define graph axis limits
xColor = [ 0 0 0.6];
yColor = [ 0 0.6 0];
zColor = [ 0.6 0 0];            %Axis/Faces Colors
CubeColor = [0.2 0.2 0.2];      %Cube Color

s=5;                            %Scatter size
SI=0.1;                         %Scatter interval
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

X = X*length;
Y = Y*width;
Z = Z*height;

cubeXYZ  =  [reshape(X,1,24); reshape(Y,1,24); reshape(Z,1,24)];

C = [10 ; 2 ; 4 ; 10 ; 6 ;10];

map = [zColor;yColor;xColor;CubeColor];
colormap(map);

xaxis2 =  [Xxaxis';Yxaxis';Zxaxis'];
yaxis2 =  [Xyaxis';Yyaxis';Zyaxis'];
zaxis2 =  [Xzaxis';Yzaxis';Zzaxis'];

DCM = quat2dcm(Q);

Vx = DCM'*xaxis2;
Vy = DCM'*yaxis2;
Vz = DCM'*zaxis2;
V  = DCM'*cubeXYZ;

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

if(block.currentTime==0)  %First iteration
    clf('reset')
    
    hold on
    view(135,45)                    %Starting view
    
    fill3(X,Y,Z,C,'Tag','cube'); 

    fill3(Xxaxis,Yxaxis,Zxaxis,'r','Tag','xaxis');
    fill3(Xyaxis,Yyaxis,Zyaxis,'r','Tag','yaxis');
    fill3(Xzaxis,Yzaxis,Zzaxis,'r','Tag','zaxis');
    
    scatter3(Xxaxis(2),Yxaxis(2),Zxaxis(2),'filled','MarkerEdgeColor','k','MarkerFaceColor',xColor,'Tag','Ox');
    scatter3(Xyaxis(2),Yyaxis(2),Zyaxis(2),'filled','MarkerEdgeColor','k','MarkerFaceColor',yColor,'Tag','Oy');
    scatter3(Xzaxis(2),Yzaxis(2),Zzaxis(2),'filled','MarkerEdgeColor','k','MarkerFaceColor',zColor,'Tag','Oz');
    
    fill3([0;FAL],[0;0],[0;0],'k');
    fill3([0;0],[0;FAL],[0;0],'k');
    fill3([0;0],[0;0],[0;FAL],'k');
    
    scatter3(FAL,0,0,'filled','MarkerEdgeColor','k','MarkerFaceColor',xColor)
    scatter3(0,FAL,0,'filled','MarkerEdgeColor','k','MarkerFaceColor',yColor)
    scatter3(0,0,FAL,'filled','MarkerEdgeColor','k','MarkerFaceColor',zColor)
    
    title('\fontsize{16}CubeSat')              %Plot title
    xlabel('X');
    ylabel('Y');
    zlabel('Z');
    axis([-AL AL -AL AL -AL AL]);
    grid on
    box on
    
else
    cube = findobj('Tag','cube');
    
    xaxis = findobj('Tag','xaxis');
    yaxis = findobj('Tag','yaxis');
    zaxis = findobj('Tag','zaxis');
    
    Ox = findobj('Tag','Ox');
    Oy = findobj('Tag','Oy');
    Oz = findobj('Tag','Oz');
    
    hold on
    
    set(xaxis,'XData',Xxaxis);
    set(xaxis,'YData',Yxaxis);
    set(xaxis,'ZData',Zxaxis);
    
    set(yaxis,'XData',Xyaxis);
    set(yaxis,'YData',Yyaxis);
    set(yaxis,'ZData',Zyaxis);
    
    set(zaxis,'XData',Xzaxis);
    set(zaxis,'YData',Yzaxis);
    set(zaxis,'ZData',Zzaxis);
    
    set(cube,'XData',X);
    set(cube,'YData',Y);
    set(cube,'ZData',Z);
    set(cube,'FaceVertexCData',C);
    
    set(Ox,'XData',Xxaxis(2));
    set(Ox,'YData',Yxaxis(2));
    set(Ox,'ZData',Zxaxis(2));
    
    set(Oy,'XData',Xyaxis(2));
    set(Oy,'YData',Yyaxis(2));
    set(Oy,'ZData',Zyaxis(2));
    
    set(Oz,'XData',Xzaxis(2));
    set(Oz,'YData',Yzaxis(2));
    set(Oz,'ZData',Zzaxis(2));
    
    if(rem(block.currentTime,SI)==0)
        scatter3(Xxaxis(2),Yxaxis(2),Zxaxis(2),s,'filled','MarkerFaceColor',scatterColorx,'MarkerEdgeColor','k') %scatter X Axis
        scatter3(Xyaxis(2),Yyaxis(2),Zyaxis(2),s,'filled','MarkerFaceColor',scatterColory,'MarkerEdgeColor','k') %scatter Y Axis
        scatter3(Xzaxis(2),Yzaxis(2),Zzaxis(2),s,'filled','MarkerFaceColor',scatterColorz,'MarkerEdgeColor','k') %scatter Z Axis
    end
    
    drawnow
end