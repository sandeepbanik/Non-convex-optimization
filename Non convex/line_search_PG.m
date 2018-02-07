function [lambda,z] = line_search_PG(f,grad_f,x,prox,lambda,g)

beta = 0.5;
z = prox(x - lambda*grad_f(x),lambda*g);
while f(z) >= f(x) + grad_f(x)'*z + (0.5/lambda)*norm(z,2)^2
    lambda = beta*lambda;
    z = prox(x - lambda*grad_f(x),lambda*g);
end

end