function [P1,P2,E1,E2]=Pr_t_tilde(c,X,grade,exper,t)
    delta=c(1:6,1);
    sig_w=c(11);
    sig=sqrt(1+sig_w^2);
    Phi1=c(8);
    vs=c(12);
    %%
    a1=-X*delta-vs-EVW(c,grade,0,exper,t)+Phi1*(grade-1)+EVW(c,(grade-1),1,exper,t);
    P1=normcdf(-a1,0,sig);
    E1=P1*(X*delta+vs+EVW(c,grade,0,exper,t)+1/sig*normpdf(-a1/sig,0,1)/(1-normcdf(-a1/sig,0,1)))+(1-P1)*(Phi1*(grade-1)+EVW(c,(grade-1),1,exper,t)+sig_w^2/sig*normpdf(a1/sig,0,1)/(1-normcdf(a1/sig,0,1)));
    a2=-X*delta-EVW(c,grade,0,exper,t)+Phi1*(grade-1)+EVW(c,(grade-1),1,exper,t);
    P2=normcdf(-a2,0,sig);
    E2=P2*(X*delta+EVW(c,grade,0,exper,t)+1/sig*normpdf(-a2/sig,0,1)/(1-normcdf(-a2/sig,0,1)))+(1-P2)*(Phi1*(grade-1)+EVW(c,(grade-1),1,exper,t)+sig_w^2/sig*normpdf(a2/sig,0,1)/(1-normcdf(a2/sig,0,1)));
end