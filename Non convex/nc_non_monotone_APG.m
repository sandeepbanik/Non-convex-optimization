function [x_opt,apg] = nc_non_monotone_APG(obj,iter)

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
eta = 0.5;
del = 0.5;
lambda_z = 1;
lambda_v = 1;
c1 = zeros(1,max_iter);
c1(:,2) = f(x(:,2)) + g(x(:,2));
q = zeros(1,max_iter);
q(:,2) = 1;
F = @(x)(f(x) + g(x));

for i=2:max_iter-1
    y(:,i) = x(:,i) + (t(i-1)/t(i))*(z(:,i) - x(:,i)) +...
                (t(i-1)-1)/(t(i))*(x(:,i) - x(:,i-1));
    [lambda_z,z(:,i+1)] = line_search_PG(f,grad_f,y(:,i),prox,lambda_z,gamma);
    
    if F(z(:,i+1)) <= c1(:,i) - del*norm(z(:,i+1)-y(:,i))
        x(:,i+1) = z(:,i+1);
    else
        [lambda_v,v(:,i+1)] = line_search_PG(f,grad_f,x(:,i),prox,lambda_v,gamma);
        if (f(z(:,i+1)) + g(z(:,i+1))) <= (f(x(:,i+1)) + g(x(:,i+1)))
            x(:,i+1)=z(:,i+1);
        else
            x(:,i+1) = v(:,i+1);
        end
    end
    t(:,i+1) = 0.5*(sqrt(4*t(:,i)^2+1)+1);
    q(:,i+1) = eta*q(:,i) + 1;
    c1(:,i+1) = (eta*q(:,i)*c1(:,i) + F(x(:,i+1)))/q(:,i+1);
    apg.prox_val(i) = f(x(:,i+1)) + g(x(:,i+1));
    if i>2 && abs(apg.prox_val(i) - apg.prox_val(i-1)) < 1e-6
        break;
    end
end
x_opt = x(:,end);
apg.x_prox = x_opt;
apg.p_prox = apg.prox_val(end);

end