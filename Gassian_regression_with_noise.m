N=20;
x=linspace(0,10,N)';
y=sin(x)+ exp(-3).*randn(N,1);
% plot(x,y);
K=GPR_kernel(x,x');
Ky=K+exp(-3).*eye(N);
L=chol(Ky,'lower');
% f_prior=L*randn(N,5);
% figure
% plot(x,f_prior,'LineWidth',1.5);

N_test=79;
x_test=linspace(-1,11,N_test)';
alpha=L'\(L\y);
K_test=GPR_kernel(x_test,x');
f_posterior=K_test*alpha;
v = L\K_test';
K_test_test=GPR_kernel(x_test,x_test');
var_f = K_test_test - v'*v;
f_posterior_var=K_test*alpha+var_f*randn(N_test,5);
f_posterior_var_range=K_test*alpha+var_f*ones(N_test,1)*[2 -2];
figure
fill([x_test; flip(x_test,1)], [f_posterior_var_range(:,1);flip(f_posterior_var_range(:,2),1)], [7 7 7]/8);
hold on; grid on
plot(x,y,'*',x_test,f_posterior,'.-',x_test,f_posterior_var,'--','LineWidth',1.5);