function [x,h] = prox_grad(obj,iter)

f = obj.f;
g = obj.g;
gamma = obj.gamma;
grad_f = obj.grad_f;
prox = obj.prox;
x = obj.init_x;
if isempty(iter)
    max_iter = 10000;
else
    max_iter = iter;
end
lambda = 1;

for i=1:max_iter
    [lambda,x] = line_search_PG(f,grad_f,x,prox,lambda,gamma);
    h.prox_val(i) = f(x) + g(x);
    if i>1 && abs(h.prox_val(i) - h.prox_val(i-1)) < 1e-6
        break;
    end
end
h.x_prox = x;
h.p_prox = h.prox_val(end);
h.time = toc;
end
