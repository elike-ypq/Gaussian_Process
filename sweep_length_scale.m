clear;
N=50;N_test=61;n_sigma2=1e-1;
x = gpml_randn(0.8, N, 1);                 % N training inputs
y = sin(3*x) + 0.1*gpml_randn(0.9, N, 1);  % N noisy training targets
sweep_n=50;
length_scale_dB = linspace(-10,5,sweep_n);
length_scale =10.^(length_scale_dB./10);
ml_dB = zeros(1,sweep_n);
for i=1:sweep_n
    ml_dB(i) = marginal_likelihood_dB(x,y,length_scale(i),n_sigma2);
end
plot(length_scale_dB, ml_dB);
hold on, grid on;