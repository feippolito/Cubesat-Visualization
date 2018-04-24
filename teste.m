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

C = [1 ; 10 ; 1 ; 1 ; 1 ;1];

cubo  =  fill3(X,Y,Z,C);
cubo2 =  [reshape(X,1,24); reshape(Y,1,24); reshape(Z,1,24)]
hold on
xlabel('X');
ylabel('Y'); 
zlabel('Z');
axis([-5 5 -5 5 -5 5])
grid on
box on


for t=0:0.01:1000
        
    q1=cos(t);
    q2=sin(t+pi/2);
    q3=(cos(t))^2;
    q4=0.5;
    
    q=[q1 q2 q3 q4]; %quartenion
   
    DCM = quat2dcm(q);
    V = DCM'*cubo2;

    X=reshape(V(1,:),4,6);
    Y=reshape(V(2,:),4,6);
    Z=reshape(V(3,:),4,6);
    
    set(cubo,'XData',X);
    set(cubo,'YData',Y);
    set(cubo,'ZData',Z);
    set(cubo,'FaceVertexCData',C);
    
    drawnow 
    
    t
    pause(0.001);    
end
