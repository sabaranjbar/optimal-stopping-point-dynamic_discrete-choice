function [L2]=L_2(c,wt1,X,grade)
%% Assigning data to the variables
delta=c(1:6);
intercept=c(7);
sig_w=c(11);
Phi1=c(8);
Phi2=c(9);
Phi3=c(10);
vs=c(12);
Pt1=c(13);
PS=exp(Pt1)/(1+exp(Pt1));
%% init values
sig_s=1;
experience=ones(1661,1);
L4=zeros(1661,1); L5=0;
sig=sqrt(sig_w^2+sig_s^2);
rho=sig_w/sig;
%% Calculating the bivariate joint normal distribution of wage at t+1 and the agent choosing to go to work (d=0)
a1(:,1)=X*delta+vs-Phi1*grade(:,1);
a2(:,1)=X*delta-Phi1*grade(:,1);
e(:,1)=intercept+Phi1*grade(:,1)+Phi2*experience(:,1)+Phi3*experience(:,1).^2-wt1(:,1);
L2_a1(:,1)=1/(sig*sqrt(1-rho^2))*(0.39894228040143)*exp(-(a1(:,1)-rho*sig/sig_w*e(:,1)).^2/(2*sig^2*(1-rho^2)));
L2_a2(:,1)=1/(sig*sqrt(1-rho^2))*(0.39894228040143)*exp(-(a2(:,1)-rho*sig/sig_w*e(:,1)).^2/(2*sig^2*(1-rho^2)));
%% Caculating the Log Likelihood
for i=1:1661
L4(i)=PS*L2_a1(i,1)+(1-PS)*L2_a2(i,1);
end
for i=1:1661
L5=log(L4(i))+L5;
end
L2=-L5;
end