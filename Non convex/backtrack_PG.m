function t = backtrack_PG(prox,grad_f,f,x)
beta = 0.5;
t = 1;
G = @(x)((x-prox(x-t*grad_f(x),t))/t);

while f(x - t*G(x)) > f(x) - t*grad_f(x)'*G(x) + 0.5*t*norm(G(x))^2
   t = beta*t; 
end

end