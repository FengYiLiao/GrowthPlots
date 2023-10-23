clc;clear;close all;

%A very simple example illustrating PL, EB, and QG

x   = -2:0.01:2;%linspace(-2,2);
idx = find(~x);
f   = abs(x);
q   = x.*x;
sq  = sqrt(q);
plot(x,f,'color','b');
hold on
plot(x,q,'color','r');
g      = ones(1,length(x));
g(idx) = 0;

plot(x(1:idx-1),g(1:idx-1),'color',[0.4940 0.1840 0.5560]);
plot(x(idx+1:end),g(idx+1:end),'color',[0.4940 0.1840 0.5560]);
plot(0,0,'.','MarkerSize',20,'color',[0.4940 0.1840 0.5560]);
%plot(x,sq);
xlabel('$x$','interpreter','latex');
%ylabel('$$','interpreter','latex');
legend('$f(x)-f^\star~\mathrm{or}~\mathrm{dist}(x,S)$',...
       '$\mathrm{dist}^2(x,S)$','$\mathrm{dist}(0,\partial f(x))$','interpreter','latex','fontsize',16);
