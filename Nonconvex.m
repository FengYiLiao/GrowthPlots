close all;clc; clear;

%Just a simple weakly convex function

%parameter setting 
width  = 4;     % Width in inches
height = 4;    % Height in inches
alw    = 0.75;    % AxesLineWidth
fsz    = 14;      % Fontsize
lw     = 2;      % LineWidth
msz    = 8;       % MarkerSize

x    = linspace(-5,5,50000);
f    = x.^2 + 6*(sin(x)).^2;
QG   = x.^2;
Grad = abs(2*x + 12*sin(x).*cos(x));
Dist = abs(x);

%subplot(1,2,1);
plot(x,f);
hold on;
plot(x,QG);

% subplot(1,2,2);
% plot(x,Grad);
% hold on;
% plot(x,Dist);

xlabel('$x$','interpreter','latex');
ylabel('$y$','interpreter','latex');
legend('$x^2 + 6\sin^2(x)$','$x^2$','interpreter','latex',Location='north');

set(gcf, 'Position', [300 100  width*100, height*100]); %<- Set size
set(gca, 'FontSize', fsz, 'LineWidth', alw); %<- Set properties

%print("Figure\nonconvex",'-depsc','-tiff');
