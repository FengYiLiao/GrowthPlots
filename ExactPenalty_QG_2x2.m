clc;clear;close all;

%An SDP that satisfies strict complementarity and locally QG
%The plot wants to show f(y) - f* satisfies QG
%2 x 2 example
%unique dual solution y* = [0,0]
%This plot also shows the 

%Growth coefficients
muq = 0.5;
mup = 0.4;
mue = muq*2;

%Problem data
n   = 2;
rho = 4; %exact penalty parameter
b   = ones(n,1);
C = [1,-1;
     -1,1];
c  = reshape(C,[],1);
A1      = zeros(n,n);
A1(1,1) = 1;
A2      = zeros(n,n);
A2(2,2) = 1;


ystar   = [0;0];

dy      = 1; %interval
y1      = linspace(ystar(1) - dy,ystar(1)+dy);
y2      = y1;

[Y1,Y2] = meshgrid(y1,y2);
obj     = zeros(length(y1),length(y2));
dist    = zeros(length(y1),length(y2));
grad    = zeros(length(y1),length(y2));
EIGS    = zeros(length(y1),length(y2));
for i =1:length(y1)
    for j =1:length(y2)
        obj(i,j)  = -b(1)*y1(i)-b(2)*y2(j)+rho*max([0;eig(-C+A1*y1(i)+A2*y2(j))]) + b.'*ystar;
        dist(i,j) = sqrt((y1(i)-ystar(1))^2+(y2(j)-ystar(2))^2);
        [V,D]     = eig(C-A1*y1(i)-A2*y2(j));
        EIGS(i,j) = min(diag(D));
        if EIGS(i,j) >= 0
            grad(i,j) = 2;
        elseif EIGS(i,j) < 0
            %check the multiplicity
            repeat = sum(D == EIGS(i,j),'all');
            if repeat>1
                disp('wait');
            end
            [d,ind] = sort(diag(D));
            Vs = V(:,ind);
            v = Vs(:,1);
            grad(i,j) = norm((-b-rho*v.^2));
        end
    end
end


surf(Y1,Y2,obj,'EdgeColor', 'none','FaceColor','#4DBEEE','FaceAlpha',0.5);

grid on
hold on

surf(Y1,Y2,0.3*dist.^2,'EdgeColor', 'none','FaceColor','#EDB120','FaceAlpha',0.7);

%optimal solution 
plot3(0,0,0,'-o','Color','none','MarkerSize',5,'MarkerFaceColor','#D95319');%#D9FFFF

%Draw the boundary where eig = 0
d1 = linspace(-dy,0);
d2 = d1./(d1-1);
obj3 = zeros(length(d1),1);
for i = 1:length(d1)
    obj3(i) = -b(1)*d1(i)-b(2)*d2(i)+rho*max([0;eig(-C+A1*d1(i)+A2*d2(i))]) + b.'*ystar;
end
plot3(d1,d2,obj3,'Color','#000000','LineWidth', 2);


d2 = linspace(-dy,0);
d1 = d2./(d2-1);
obj3 = zeros(length(d1),1);
for i = 1:length(d1)
    obj3(i) = -b(1)*d1(i)-b(2)*d2(i)+rho*max([0;eig(-C+A1*d1(i)+A2*d2(i))]) + b.'*ystar;
end
plot3(d1,d2,obj3,'Color','#000000','LineWidth', 2);

grad2 = grad.^2;



view([47 30]);



% p.Marker = "o";

%hold on;

xlabel('$y_1$','interpreter','latex');
ylabel('$y_2$','interpreter','latex');
%zlabel('$f(y)$','interpreter','latex');

width  = 4;     % Width in inches
height = 4;    % Height in inches
set(gcf, 'Position', [300 100  width*100, height*100]); %<- Set size
set(gca, 'FontSize', 11); %<- Set properties
legend('$f(y)$','$0.3 \cdot\mathrm{Dist}^2(y,S)$','interpreter','latex','Location','none','Position',[0.05,0.87,0.37,0.1],'Box','off','FontSize', 11);
%print(gcf,'ExactPenalty_QG.eps','-depsc2','-r300');



%Sectional view
figure();
%Draw the boundary where eig = 0
d1 = linspace(-dy,0);
d2 = d1./(d1-1);
obj3 = zeros(length(d1),1);
for i = 1:length(d1)
    obj3(i) = -b(1)*d1(i)-b(2)*d2(i)+rho*max([0;eig(-C+A1*d1(i)+A2*d2(i))]) + b.'*ystar;
end
plot(d1,obj3,'Color','#000000','LineWidth', 2);


hold on
d2 = linspace(-dy,0);
d1 = d2./(d2-1);
obj3 = zeros(length(d1),1);
for i = 1:length(d1)
    obj3(i) = -b(1)*d1(i)-b(2)*d2(i)+rho*max([0;eig(-C+A1*d1(i)+A2*d2(i))]) + b.'*ystar;
end
plot(d1,obj3,'Color','#000000','LineWidth', 2);
xlabel('$y_1$','interpreter','latex');
plot3(0,0,0,'-o','Color','none','MarkerSize',5,'MarkerFaceColor','#D95319');%#D9FFFF