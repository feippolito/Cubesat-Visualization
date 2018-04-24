interval = 5;
AL = 10;
view(135,45);                    %Starting view

xColor = [ 0 0 0.6];
yColor = [ 0 0.6 0];
zColor = [ 0.6 0 0];            %Axis/Faces Colors
CubeColor = [0.2 0.2 0.2];      %Cube Color
map = [zColor;yColor;xColor;CubeColor];
colormap(map);

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

R=5;
R=  R*[1 1 1 1 1 1;
       1 1 1 1 1 1;
       1 1 1 1 1 1;
       1 1 1 1 1 1];
X=X+R;
Y=Y+R;
hold on
cubo  = fill3(X,Y,Z,C);
title('\fontsize{16}')              %Plot title
xlabel('X');
ylabel('Y'); 
zlabel('Z');
axis([-AL AL -AL AL -AL AL]);
grid on
box on

cubo2  =  [reshape(X,1,24); reshape(Y,1,24); reshape(Z,1,24)];

for t=1:size(q,1)
    set(cubo,'XData',X);
    set(cubo,'YData',Y);
    set(cubo,'ZData',Z);
    set(cubo,'FaceVertexCData',C);
    
    drawnow
    pause(interval); 
end