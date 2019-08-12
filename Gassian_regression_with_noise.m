N=20;N_test=61;sigma_n2=0.1;LL=1;
x = gpml_randn(0.8, N, 1);                 % 20 training inputs
y = sin(3*x) + 0.1*gpml_randn(0.9, N, 1);  % 20 noisy training targets
x_test = linspace(-3, 3, N_test)';                  % 61 test inputs 
% plot(x,y);
K=GPR_kernel(x,x',LL,sigma_n2);
Ky=K;
L=chol(Ky,'lower');
% f_prior=L*randn(N,5);
% figure
% plot(x,f_prior,'LineWidth',1.5);

alpha=L'\(L\y);
K_test=GPR_kernel(x_test,x',LL,sigma_n2);
f_posterior=K_test*alpha;
v = L\K_test';
K_test_test=GPR_kernel(x_test,x_test',LL,sigma_n2);
var_f = K_test_test - v'*v;
L_var_f=chol(var_f,'lower');
f_posterior_var=K_test*alpha+L_var_f*randn(N_test,3);
f_posterior_var_range=K_test*alpha+L_var_f*ones(N_test,1)*[2 -2];
% figure
fill([x_test; flip(x_test,1)], [f_posterior_var_range(:,1);flip(f_posterior_var_range(:,2),1)], [7 7 7]/7.5);
hold on; grid on
plot(x,y,'o',x_test,f_posterior,'.-',x_test,f_posterior_var,'--','LineWidth',1.5);