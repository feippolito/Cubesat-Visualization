width = 0.5;
length = 0.5;
height = 0.5;

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


cubli_graph = fill3(X,Y,Z,'c');
hold on
surface_graph = fill3([-1 1 1 -1],[-1 -1 1 1],[0 0 0 0],'k','FaceAlpha',0.5);
title('\fontsize{16}Cubli')
xlabel('X');
ylabel('Y'); 
zlabel('Z');
axis([-1 1 -1 1 -1 1])
grid on
box on

cubli = [reshape(X,1,24); reshape(Y,1,24); reshape(Z,1,24)];

for i = 1:size(t,1)
    
    % Euler angles
    
    R = quat2dcm([x(i,1) x(i,2) x(i,3) x(i,4)]); 
    V = R'*cubli;
    
    % Plot
    
    X=reshape(V(1,:),4,6);
    Y=reshape(V(2,:),4,6);
    Z=reshape(V(3,:),4,6);
    
    set(cubli_graph,'XData',X);
    set(cubli_graph,'YData',Y);
    set(cubli_graph,'ZData',Z);
  
    
  
   
    drawnow
  
end

