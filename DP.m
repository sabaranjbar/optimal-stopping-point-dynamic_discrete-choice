%% Reading the data
clc; clear;
data1 = matrixread ('C:\Users\sabar\Documents\MATLAB\econ683.xlsx');
data2 = matrixread ('C:\Users\sabar\Documents\MATLAB\X.xlsx');
%% assigning the data to the variables
D=data1(:,:);
W=data1(:,42:54);
intercept=ones(1661,1);
medu=data2(2:1662,1);
faminc=data2(2:1662,2);
nuclear=data2(2:1662,3);
rural=data2(2:1662,4);
nofsib=data2(2:1662,6);
X=[intercept medu faminc nuclear rural nofsib];
school=data1(:,29:41);
%% Calculating t (The last period the agent makes a decision)
t=zeros(1661,1);
for i=1:1661
    k=1;
    j=2;
    while school(i,j)~=school(i,j-1) && school(i,j)~=0
        k=k+1;
        if j~=13 
        j=j+1;
        else
          break; 
        end
    end
    t(i,1)=k;
end
%% Creating highest grade achieved
grade=zeros(1661,1);
for i=1:1661
    grade(i,1)=school(i,t(i,1));
end
%% Creating the experience
exper=zeros(1661,50);
for i=1:1661
    k=0;
    for j=t(i,1)+1:50
    k=k+1;
    exper(i,j)=k;
    end
end
%% Creating The Wages at t+1
wt1=zeros(1661,1);
for i=1:1661
    if t(i,1)+2<=13
    wt1(i,1)=W(i,t(i,1)+1);
    end
end
%% Using fminunc() to calculate minimum of minus the maximum likelihood
param_init=[3 0 0 0 0 0 1.5 0.06 0 0 1 0.5 0]';
options = optimoptions('fminunc','display','iter','MaxIterations',10000,'MaxFunEvals',10000);
[c,fval,E,output,grad,hessian]=fminunc(@(param) logLikelihood(param,X,grade,exper,t,school,D,wt1),param_init,options);
%% Calculating the Variance, standard deviation and t-values
sigma2 = inv(hessian)/1661;
std_beta=diag(sqrt(sigma2));
t_value=c./std_beta;