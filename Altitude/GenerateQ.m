function q = GenerateQ

t=0;
q = angle2quat(t,2*t,0)
for t=0.01:0.01:(2*pi)
    
    a = angle2quat(t,2*t,0)
    q = [q;a];
end

    
