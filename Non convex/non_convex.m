classdef non_convex
   properties
        f
        g
        gamma
        grad_f
        prox
        init_x
   end
   methods
       % Constructor 
       function n_c = non_convex(f,g,gamma,grad_f,prox,init_x)
           if nargin > 1
              n_c.f = f;                % Objective function
              n_c.g = g;                % Non-convex function
              n_c.gamma = gamma;        % Regularizer weight
              n_c.grad_f = grad_f;      % Convex function gradient
              n_c.prox = prox;          % Proximal opertaor
              n_c.init_x = init_x;      % Initialization
           end
       end
       % Proximal gradient
       function [x_opt,h] = PG(obj,iter)
           tic;
           [x_opt,h] = prox_grad(obj,iter);
       end
       % Accelerated proximal gradient
       function [x_opt,h] = APG(obj,iter)
           tic;
           [x_opt,h] = acc_prox_grad(obj,iter);
       end
       % Monotonic accelerated proximal gradient
       function [x_opt,h] = APG_MON(obj,iter)
           tic;
          [x_opt,h] = accmon_prox_grad(obj,iter); 
       end
       % Monotonic accelerated non convex proxial gradient descent
       function [x_opt,h] = nc_mon_APG(obj,iter)
           tic;
          [x_opt,h] = nc_monotone_APG(obj,iter); 
       end
       % Non Monotonic accelerated non convex proxial gradient descent
       function [x_opt,h] = nc_nmon_APG(obj,iter)
           tic;
          [x_opt,h] = nc_non_monotone_APG(obj,iter); 
       end
   end
end