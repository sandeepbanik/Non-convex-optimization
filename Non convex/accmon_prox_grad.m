function [x,apg] = accmon_prox_grad(obj,iter)
f = obj.f;
g = obj.g;
gamma = obj.gamma;
grad_f = obj.grad_f;
prox = obj.prox;
x = obj.init_x;
lambda = 1;
x_prev = x;
t_pr = 1;
t = 1;
z = x;
F = @(x)(f(x) + g(x));
if isempty(iter)
    max_iter = 10000;
else
    max_iter = iter;
end

for i=1:max_iter
    y = x + ((t_pr-1)/t)*(z - x) + ((t_pr-1)/t)*(x - x_prev);
    [lambda,z] = line_search_PG(f,grad_f,y,prox,lambda,gamma);
    t_pr = t;
    t = (sqrt(4*(t)^2+1) + 1)/2;
    x_prev = x;
    if F(z) <= F(x)
        x = z;
    end
    apg.prox_val(i) = f(x) + g(x);
    if i>1 && abs(apg.prox_val(i) - apg.prox_val(i-1)) < 1e-6
        break;
    end
end
apg.x_prox = x;
apg.p_prox = apg.prox_val(end);
end