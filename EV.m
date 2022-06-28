function [E]=EV(c,X,grade,exper,k,t,P,i)
   delta=c(1:6,1);
   sig_w=c(11);
   sig=sqrt(sig_w^2+1);
   Phi1=c(8);
   vs=c(12);   
   %%
   if i==0
   b=EVW(c,(grade-k-1),1,exper,t);
   d=EVW(c,grade-k,0,exper,t);
   a1=Phi1*(grade-k-1)+b-X*delta-vs-d;
   E=P*(X*delta+vs+EVW(c,grade-k,0,exper,t)+1/sig*normpdf(-a1/sig,0,1)/(1-normcdf(-a1/sig,0,1)))+(1-P)*(Phi1*(grade-k-1)+EVW(c,(grade-k-1),1,exper,t)+sig_w^2/sig*normpdf(a1/sig,0,1)/(1-normcdf(a1/sig,0,1)));
   elseif i==1
   b=EVW(c,(grade-k-1),1,exper,t);
   d=EVW(c,grade-k,0,exper,t);
   a2=Phi1*(grade-k-1)+b-X*delta-d;
   E=P*(X*delta+EVW(c,grade-k,0,exper,t)+1/sig*normpdf(-a2/sig,0,1)/(1-normcdf(-a2/sig,0,1)))+(1-P)*(Phi1*(grade-k-1)+EVW(c,(grade-k-1),1,exper,t)+sig_w^2/sig*normpdf(a2/sig,0,1)/(1-normcdf(a2/sig,0,1)));
   end
end