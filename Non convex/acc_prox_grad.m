function [x,apg] = acc_prox_grad(obj,iter)

f = obj.f;
g = obj.g;
gamma = obj.gamma;
grad_f = obj.grad_f;
prox = obj.prox;
x = obj.init_x;
lambda = 1;
x_prev = x;
if isempty(iter)
    max_iter = 10000;
else
    max_iter = iter;
end

for i=1:max_iter
    y = x + (i/(i+3))*(x - x_prev);
    [lambda,z] = line_search_PG(f,grad_f,y,prox,lambda,gamma);
    x_prev = x;
    x = z;
    apg.prox_val(i) = f(x) + g(x);
    if i>1 && abs(apg.prox_val(i) - apg.prox_val(i-1)) < 1e-6
        break;
    end
end
apg.x_prox = x;
apg.p_prox = apg.prox_val(end);
apg.time = toc;
end