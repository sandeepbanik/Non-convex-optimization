function x = soft_th_capped_l1(beta,lambda)
n = length(beta);
x = zeros(n,1);
for i=1:n
   if beta(i) > lambda
       x(i) = beta(i) - lambda;
   elseif (-lambda<=beta(i)) && (beta(i)<=lambda)
       x(i) = 0;
   elseif beta(i) < -lambda
       x(i) = beta(i) + lambda;
   end
end
end