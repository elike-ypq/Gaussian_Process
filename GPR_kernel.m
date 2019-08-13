function y=GPR_kernel(a,b,L,sigma_n2)
if nargin==2
    L=1;sigma_n2=1e-8;
end
if nargin==3
    sigma_n2=1e-8;
end
sw_1=0;
N1=length(a);
N2=length(b);
if N1==N2
    sw_1=1;
end
sigma_f=1;
M_1=1./L.*eye(N1);
a=M_1*a;
M_2=1./L.*eye(N2);
b=b*M_2;
r2=(a.^2)*ones(1,N2)+ones(N1,1)*(b.^2)-2.*(a*b);
y=sigma_f.^2.*exp(-.5.*r2)+sw_1*sigma_n2*eye(N1,N2);
% y=sigma_f.^2.*exp(-.5.*(a-b)'*M*(a-b));