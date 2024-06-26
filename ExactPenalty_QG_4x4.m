clc;clear;close all;

%An SDP that satisfies strict complementarity and locally QG
%The plot wants to show that penalty function satisfies QG
%4 x 4 example

%Plot parameters
res = 0.01;

%Growth coefficients
muq = 0.5;
mup = 0.4;
mue = muq*2;

%Problem data
n   = 4;
rho = 20; %exact penalty parameter
b   = ones(n,1);
C = [1,1,1,0;
     1,1,0,1;
     1,0,1,1;
     0,1,1,1];
c  = reshape(C,[],1);
A1      = zeros(n,n);
A1(1,1) = 1;
A2      = zeros(n,n);
A2(2,2) = 1;


C2 = [1,1,1,0;
     1,1,0,1;
     1,0,2,1;
     0,1,1,2];

y1      = linspace(-3,0);
y2      = y1;
y       = [y1; y2];

[Y1,Y2] = meshgrid(y1,y2);
Y3      = ones(length(y1),length(y1));
Y4      = Y3;
obj     = zeros(length(y1),length(y2));
dist    = zeros(length(y1),length(y2));
grad    = zeros(length(y1),length(y2));
EIGS    = zeros(length(y1),length(y2));
for i =1:length(y1)
    for j =1:length(y2)
        obj(i,j)  = -y1(i)-y2(j)+rho*max([0;eig(-C2+A1*y1(i)+A2*y2(j))])-2;
        dist(i,j) = (y1(i)+1)^2+(y2(j)+1)^2;
        [V,D]     = eig(C2-A1*y1(i)-A2*y2(j));
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
grad2 = grad.^2;
surf(Y1,Y2,dist* muq,'FaceColor','g','EdgeColor',[0 1 0]);
hold on;
surf(Y1,Y2,obj,'FaceColor','y','EdgeColor',[1 1 0]);
hold on;
xlabel('$y_1$','interpreter','latex');
ylabel('$y_2$','interpreter','latex');