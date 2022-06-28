function [E]=EVW(c,school,e,exper,t)
    intercept=c(7);
    Phi1=c(8);
    Phi2=c(9);
    Phi3=c(10);
    E=0;
   for i=t+1:40
    E=(0.95^(i-t-1))*(intercept+Phi1*school+Phi2*(e+exper(1,i))+Phi3*(e+exper(1,i))^2)+E;
   end
end