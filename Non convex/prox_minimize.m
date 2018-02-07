function prox = prox_minimize(obj)
opts1=  optimset('display','off');
g = obj.g;
prox = @(x,t)fminunc(@(z)((1/(2*t))*norm(x-z)^2 + g(z)),zeros(size(x)),opts1);

end