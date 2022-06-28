function [L3] = L_3(c,D)
%%
lnw=D(:,42:54);
school(:,:)=D(:,29:41);
experience=D(:,16:28);
experience2=experience(:,:).^2;
sig_w=c(11);
Phi3=c(10);
Phi2=c(9);
Phi1=c(8);
intercept=c(7);
%%
fwage=ones(1661,13);

for i=1:1661
    for t=1:13
        if lnw(i,t)>0
            fwage(i,t)=normpdf((intercept+Phi1*school(i,t)+Phi2*experience(i,t)+Phi3*experience2(i,t)),lnw(i,t),sig_w);
        end
    end
end
%%
L3_ones=ones(1661,1);
 for i=1:1661
     for t=1:13
             L3_ones(i,1)=L3_ones(i,1)'.*fwage(i,t);
     end
 end
L3=0;
for i=1:1661
L3=log(L3_ones(i,1))+L3;
end
L3=-L3;
end