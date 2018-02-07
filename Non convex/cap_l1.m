function r = cap_l1(x,lambda)
n = length(x);
theta = 0.1*lambda;
r = 0;
for i=1:n
    r = r + lambda*min([abs(x(i));theta]);
end

end