clc;clear;close all;
x1 = linspace(-1,1);
x2 = x1;
[X1,X2] = meshgrid(x1,x2);
g0 = X1; 
X1(X1<=0) = 0;
obj = X1;
surf(g0,X2,obj,'FaceColor','r','EdgeColor','none')
xlim([-1,1])