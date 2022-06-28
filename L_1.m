function [L]=L_1(c,X,grade,exper,t,school)
%% initial values
    P1_1=ones(1661,1); P1_tau=ones(1661,1);
    P2_2=ones(1661,1); P2_tau=ones(1661,1); 
    E1_1=ones(1661,1); E2_2=ones(1661,1);
    L=0; L1=zeros(1661,1);
    Pt1=c(13);
    PS=exp(Pt1)/(1+exp(Pt1));
%% Prob. of making the choice to go to school for the last time
    for i=1:1661
        [P1,P2,E1,E2]=Pr_t_tilde(c,X(i,:),grade(i,1),exper(i,:),t(i,1));
        P1_tau(i)=P1;
        P2_tau(i)=P2;
        E1_1(i)=E1;
        E2_2(i)=E2;
    end
     
%% Prob. of making the choice to go to school for t<t_tilde
    for i=1:1661
        if t(i)>1
            [P1,P2]=Pr_t(c,X(i,:),school(i,:),exper(i,:),t(i),E1_1(i),E2_2(i),grade(i));
            P1_1(i)=P1;
            P2_2(i)=P2;
        end
    end
%% Estimating the log Likelihood
    for i=1:1661
    L1(i,1)=PS*(P1_1(i,1)*P1_tau(i,1))+(1-PS)*P2_2(i,1)*P2_tau(i,1);
    end
    for i=1:1661
        L=log(L1(i,1))+L;
    end
    L=-L;
end