clear;
N=20;N_test=61;
x = gpml_randn(0.8, N, 1);                 % N training inputs
y = sin(3*x) + 0.1*gpml_randn(0.9, N, 1);  % N noisy training targets
sweep_n=100;
n_sigma2_dB = linspace(-40,20,sweep_n);
n_sigma2 = 10.^(n_sigma2_dB./10);
length_scale_dB = linspace(-20,10,sweep_n);
length_scale =10.^(length_scale_dB./10);
ml_dB = zeros(sweep_n,sweep_n);
for i=1:sweep_n
    for j=1:sweep_n
        ml_dB(i,j) = marginal_likelihood_dB(x,y,length_scale(i),n_sigma2(j));
    end
end