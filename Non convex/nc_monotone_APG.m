function [x_opt,apg] = nc_monotone_APG(obj,iter)

f = obj.f;
g = obj.g;
gamma = obj.gamma;
grad_f = obj.grad_f;
prox = obj.prox;
x_0 = obj.init_x;
n = size(x_0,1);
if isempty(iter)
    max_iter = 10000;
else
    max_iter = iter;
end
x = zeros(n,max_iter);
y = zeros(n,max_iter);
z = zeros(n,max_iter);
v = zeros(n,max_iter);
t = zeros(1,max_iter);
t(:,2) = 1;
lambda_z = 1;
lambda_v = 1;

for i=2:max_iter-1
    y(:,i) = x(:,i) + (t(i-1)/t(i))*(z(:,i) - x(:,i)) +...
                (t(i-1)-1)/(t(i))*(x(:,i) - x(:,i-1));
    [lambda_z,z(:,i+1)] = line_search_PG(f,grad_f,y(:,i),prox,lambda_z,gamma);
    [lambda_v,v(:,i+1)] = line_search_PG(f,grad_f,x(:,i),prox,lambda_v,gamma);
    
    t(:,i+1) = 0.5*(sqrt(4*t(:,i)^2+1)+1);
    if (f(z(:,i+1)) + g(z(:,i+1))) <= (f(x(:,i+1)) + g(x(:,i+1)))
        x(:,i+1)=z(:,i+1);
    else
        x(:,i+1) = v(:,i+1);
    end
    
    apg.prox_val(i) = f(x(:,i+1)) + g(x(:,i+1));
    if i>2 && abs(apg.prox_val(i) - apg.prox_val(i-1)) < 1e-6
        break;
    end
end
x_opt = x(:,i);
apg.x_prox = x_opt;
apg.p_prox = apg.prox_val(end);
apg.time = toc;
end