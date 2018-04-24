P1 = [1,-1,3];
P2 = [2,3,4];
P3 = [-5,6,7];

normal = cross(P1-P2, P1-P3)

syms x y z
P = [x,y,z]
planefunction = dot(normal, P-P1)

zplane = solve(planefunction, z)

x=1:10
y=1:10
z=subs(zplane)

ezmesh(zplane, [2, 8, 2, 8]), hold off
