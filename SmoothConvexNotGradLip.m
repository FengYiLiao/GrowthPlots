close all; clc; clear;

%An example of smooth and convex funciton but not gradient Lipschitz
%This example shows that the equivalency between EB, PL, and QG still hold

%parameter setting 
width  = 8;     % Width in inches
height = 4;    % Height in inches
alw    = 0.75;    % AxesLineWidth
fsz    = 18;      % Fontsize
lw     = 2;      % LineWidth
msz    = 8;       % MarkerSize


start = 2;
x = linspace(-start,start,10000);

%function value
Interval_1 = x<=-1;
f(Interval_1) = 0.5*x(Interval_1).^4 + 0.5;

Interval_2 = (x>-1) & (x<1);
f(Interval_2) = x(Interval_2).^2;

Interval_3 = x>=1;
f(Interval_3) = 0.5*x(Interval_3).^4 + 0.5;

subplot(1,2,1);
plot(x,f);

hold on

%QG
QG = x.^2;
plot(x,QG);


xlabel('$x$','interpreter','latex');
ylabel('$y$','interpreter','latex');
set(gcf, 'Position', [300 100  width*100, height*100]); %<- Set size
set(gca, 'FontSize', fsz, 'LineWidth', alw); %<- Set properties

legend('$y=f(x)$','$y =  \mathrm{Dist}^2(x,S)$','interpreter','latex','location','north','FontSize',14,'NumColumns',1);

subplot(1,2,2);
%PL
Grad(Interval_1) = abs(0.5*4*x(Interval_1).^3);
Grad(Interval_2) = abs(2*x(Interval_2));
Grad(Interval_3) = abs(0.5*4*x(Interval_3).^3);
plot(x,Grad,'color','#EDB120');

hold on
%EB
Dist = abs(x);
plot(x,Dist,'color','#7E2F8E');
xlabel('$x$','interpreter','latex');
ylabel('$y$','interpreter','latex');

set(gcf, 'Position', [300 100  width*100, height*100]); %<- Set size
set(gca, 'FontSize', fsz, 'LineWidth', alw); %<- Set properties



legend('$y = |\nabla f(x)| $','$y = \mathrm{Dist}(x,S)$','interpreter','latex','location','north','FontSize',14,'NumColumns',1);
ylim([0,6]);
xlim([-start,start]);

print("Example-nonLip",'-depsc','-tiff');