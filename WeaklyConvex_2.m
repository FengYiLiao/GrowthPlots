close all; clc; clear;

%An example of a nonconvex but weakly convex funciton
%This example shows that the equivalency between EB, PL, and QG still hold


%parameter setting 
width  = 8;     % Width in inches
height = 4;    % Height in inches
alw    = 0.75;    % AxesLineWidth
fsz    = 14;      % Fontsize
lw     = 2;      % LineWidth
msz    = 8;       % MarkerSize


start = 1.5;
x = linspace(-start,0,10000);

Interval_1 =  x<=-1;
Interval_2 =  (x>-1)&(x<-1/2);
Interval_3 =  x>=-1/2;

%function value
f(Interval_1) = 3*(x(Interval_1)+1).^2;
f(Interval_2) = -(x(Interval_2)).^2+1;
f(Interval_3) = 3*(x(Interval_3)+1).^2;


subplot(1,2,1)
plot(x,f)
hold on

%QG
QG = 2.5*(x+1).^2;
plot(x,QG);



%2 weakly convex
g = f + 1*x.^2;
plot(x,g,'color','#77AC30');
ylim([0,3]);
xlim([-start,0]);
xlabel('$x$','interpreter','latex');
ylabel('$y$','interpreter','latex');

legend('$f(x)$','$ 2.5 \cdot \mathrm{Dist}^2(x,S)$','$f(x) + x^2$'...
       ,'interpreter','latex','location','north','FontSize',14,'NumColumns',1);
set(gcf, 'Position', [300 100  width*100, height*100]); %<- Set size
set(gca, 'FontSize', fsz, 'LineWidth', alw); %<- Set properties




subplot(1,2,2)
hold on
%Grad
Grad_1(Interval_1) = abs(3*2*(x(Interval_1)+1));
plot(x(Interval_1),Grad_1,'color','#EDB120');
Grad_2 = abs(2*(x(Interval_2)));
plot(x(Interval_2),Grad_2,'color','#EDB120');
Grad_3= abs(3*2*(x(Interval_3)+1));
plot(x(Interval_3),Grad_3,'color','#EDB120');
plot(-1,0,'o','MarkerSize',6,'color','#EDB120');
plot(-0.5,3,'o','MarkerSize',6,'color','#EDB120');

%Dist 
Dist = abs(x+1);
plot(x,Dist,'color','#7E2F8E');  
%xlim([-start,0]);
ylim([0,6]);
box on

xlabel('$x$','interpreter','latex');
ylabel('$y$','interpreter','latex');
legend('$ \mathrm{Dist}(0,\partial f(x))$','','','','','$\mathrm{Dist}(x,S)$',...
    'interpreter','latex','location','north','FontSize',14,'NumColumns',1);


set(gca, 'FontSize', fsz, 'LineWidth', alw); %<- Set properties

% pos = get(gcf, 'Position');
% set(gcf, 'Position', [300 100  width*100, height*100]); %<- Set size
% set(gca, 'FontSize', fsz, 'LineWidth', alw); %<- Set properties
% 
% xlabel('$x$','interpreter','latex');
% ylabel('$y$','interpreter','latex');
% legend('$f(x)$','$ 2.5 \cdot \mathrm{Dist}^2(x,S)$','$ \mathrm{Dist}(0,\partial f(x))$','','','','','$\mathrm{Dist}(x,S)$','$f(x) + x^2$','interpreter','latex','location','northoutside','FontSize',20,'NumColumns',3);
% % ylim([0,6]);
% % xlim([-2,0.5]);
% 
%print("Example-weaklyconvex-Equivalence",'-depsc','-tiff');
% %subplot(1,2,2);



