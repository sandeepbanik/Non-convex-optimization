% Test non-convex APG
    clear;
    close all;
    clc;
    addpath('Non convex');
%% Parameters
    m = 100;                                    % Data dimension
    n = 500;                                    % Feature dimension
    x0 = sprandn(n,1,0.05);                     % Generate sparse vector
    A = rand(m,n);                              % A matrix (weight matrix)
    A = A*spdiags(1./sqrt(sum(A.^2))',0,n,n);   % Make the norm of the column = 1
    v = sqrt(0.001)*randn(m,1);                 % Generate noise
    b = A*x0 + v;                               % Measurement vector
    init_x = zeros(n,1);                        % Initialization

%% Lasso 
    f = @(x)(0.5*norm(A*x-b,2)^2);                  % Convex function
    gamma_max = norm(A'*b,'inf');                   % Regularization weight
    gamma = 0.1*gamma_max;                          % Scaling 
    g = @(x)(gamma*norm(x,1));                      % Non-convex function

    grad_f =@(x)(A'*(A*x-b));                       % Gradient of the convex function
    prox = @(x,lambda)(prox_op(x,lambda));          % Proximal operator

    prob = non_convex(f,g,gamma,grad_f,prox,init_x); % Setting the class parameters

%% Solving
% Proximal gradient method
    [x_PG,PG] = prob.PG(1000);
% Accelerated proximal gradient
    [x_APG,APG] = prob.APG(1000);
% Monotonic accelerated proximal gradient
    [x_APG_MON,APG_MON] = prob.APG_MON(1000);
% Monotonic accelerated non convex proximal gradient
    [x_nc_APG,nc_APG] = prob.nc_mon_APG(1000);
% Non monotonic accelerated non convex proximal gradient
    [x_nc_nAPG,nc_nAPG] = prob.nc_nmon_APG(1000);
% Matlab optimization
% tic;
% fun = @(x)(mat_fun(A,b,gamma,x));
% [x,fval] = fminunc(fun,init_x);
% mt_time = toc;

%% Plotting
t = max([length(PG.prox_val);length(APG.prox_val);length(APG_MON.prox_val);length(nc_APG.prox_val);length(nc_nAPG.prox_val)]);
figure;
plot(PG.prox_val,'b');
hold on;
plot(APG.prox_val,'r');
plot(APG_MON.prox_val,'g');
plot(nc_APG.prox_val(2:end),'c');
plot(nc_nAPG.prox_val(2:end),'m');
legend('Prox gradient','Accelerated','Monotonic Accelerated','Non convex monotonic prox','Non convex non monotonic prox');
axis tight;
