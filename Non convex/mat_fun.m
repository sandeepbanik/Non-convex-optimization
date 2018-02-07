function [f,g] = mat_fun(A,b,gamma,x)
f = 0.5*norm(A*x-b,2)^2 + gamma*norm(x,1);
% f = 0.5*norm(A*x-b,2)^2 + cap_l1(x,gamma);

if nargout >1
    g = A'*(A*x-b);
end
end