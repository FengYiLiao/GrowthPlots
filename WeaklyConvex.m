close all;clc; clear;


start = 2.5;
x = linspace(-start,start,10000);
A = x>=-1;
B = x<=1;
C = A & B;
D = x>=1;
E = x<=-1;
% E = x>=0;
% F = D & E;
y = zeros(1,length(x));
%y = 0.5*x.^2;
% y(A) = (x(A)).^2+0.5;
% y(B) = (x(B)).^2+0.5;
% y(F) = (x(F)).^2;
y(C) = -(x(C)).^2+1;
y(D) = 2*(x(D)-1).^2;
y(E) = 2*(x(E)+1).^2;
%y(F) = -(x(F)-1).^2+1;
%y
plot(x,y)
hold on
z = y + 1*x.^2;
plot(x,z);

s = zeros(1,length(x));
F1 = x<=0;
F2 = x>=0;
s(F1) = 1.5*(x(F1)+1).^2;
s(F2) = 1.5*(x(F2)-1).^2;
plot(x,s);
ylim([0,5])