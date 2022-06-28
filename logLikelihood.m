function [F]=logLikelihood(c,X,grade,exper,t,school,D,wt1)
L1=L_1(c,X,grade,exper,t,school);
L2=L_2(c,wt1,X,grade);
L3=L_3(c,D);
F=L1+L2+L3;
end