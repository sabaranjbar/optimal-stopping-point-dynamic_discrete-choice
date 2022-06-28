function [P1,P2]=Pr_t(c,X,school,exper,t,E1,E2,grade)
    delta=c(1:6);
    Phi1=c(8);
    sig_w=c(11);
    vs=c(12);   
    sig=sqrt(1+sig_w^2);
%%
    if t==2
        a1=-X*delta-vs-E1+Phi1*(school(1,t-1)-1)+EVW(c,(school(1,t-1)-1),1,exper,t-1);
        P1=normcdf(-a1/sig,0,1);
        a2=-X*delta-E2+Phi1*(school(1,t-1)-1)+EVW(c,(school(1,t-1)-1),1,exper,t-1);
        P2=normcdf(-a2/sig,0,1);
    else
        a1=-X*delta-vs-E1+Phi1*(school(1,t-2))+EVW(c,(school(1,t-2)),1,exper,t-1);
        P1=normcdf(-a1/sig,0,1);
        a2=-X*delta-E2+Phi1*(school(1,t-2))+EVW(c,(school(1,t-2)),1,exper,t-1);
        P2=normcdf(-a2/sig,0,1);
    end
%%
    if t>2
        k=0;
        P11=P1;
        P22=P2;
        for i=(t-2):-1:1
            k=k+1;
            E1=EV(c,X,grade,exper,k,t,P11,0);
            a1=Phi1*(school(1,i)-1)+EVW(c,school(1,i)-1,1,exper,i)-E1-vs-X*delta;
            P11=normcdf(-a1,0,sig);
            P1=P11*P1;
            E2=EV(c,X,grade,exper,k,t,P22,1);
            a2=Phi1*(school(1,i)-1)+EVW(c,school(1,i)-1,1,exper,i)-E2-X*delta;
            P22=normcdf(-a2,0,sig);
            P2=P22*P2;
        end
    end
end