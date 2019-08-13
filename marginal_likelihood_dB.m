function ml_dB = marginal_likelihood_dB(x,y,length_scale,n_sigma2)
K=GPR_kernel(x,x',length_scale,n_sigma2);
L=chol(K,'lower');
alpha=L'\(L\y);
ml_dB = -1./2.*y'*alpha - sum(log(diag(L)))-length(x)./2.*log(2*pi);