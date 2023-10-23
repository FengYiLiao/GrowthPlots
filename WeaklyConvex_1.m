close all;clc; clear;

%Just a simple weakly convex function

start        = 2.5;
x            = linspace(-start,start,10000);
Interval1    = (x>=-1) & (x<=1);
Interval2    = x>=1;
Interval3    = x<=-1;

%Weakly convex function
f            = zeros(1,length(x));
f(Interval1) = -(x(Interval1)).^2+1;
f(Interval2) = 2*(x(Interval2)-1).^2;
f(Interval3) = 2*(x(Interval3)+1).^2;

plot(x,f)
hold on

%f + x^2 becomes convex
g = f + 1*x.^2;
plot(x,g);


%Distance square to the solution set
Dist2     = zeros(1,length(x));
I1        = x<=0;
I2        = x>=0;
Dist2(I1) = 1.5*(x(I1)+1).^2;
Dist2(I2) = 1.5*(x(I2)-1).^2;
plot(x,Dist2);
ylim([0,5]);