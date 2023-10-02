clc;clear;close all;
res = 0.01;
n = 4;
rho =20;
b = ones(n,1);
muq = 0.5;
mup = 0.4;
mue = muq*2;
C = [1,1,1,0;
     1,1,0,1;
     1,0,1,1;
     0,1,1,1];
c  = reshape(C,[],1);
C2 = [1,1,1,0;
     1,1,0,1;
     1,0,2,1;
     0,1,1,2];
At = zeros(n,n^2);
for i = 1:n
   At(i,(i-1)*n+1) = 1;
end
y1      = linspace(-3,-1);
y2      = y1;
y =[y1;
    y2;
    ];
A1 = zeros(n,n);
A1(1,1) = 1;
A2 = zeros(n,n);
A2(2,2) = 1;
[Y1,Y2] = meshgrid(y1,y2);
Y3 = ones(length(y1),length(y1));
Y4 = Y3;
obj  = zeros(length(y1),length(y2));
dist = zeros(length(y1),length(y2));
grad = zeros(length(y1),length(y2));
grad2 = zeros(length(y1),length(y2));
EIGS = zeros(length(y1),length(y2));
for i =1:length(y1)
    for j =1:length(y2)
        obj(i,j)  = -y1(i)-y2(j)+rho*max([0;eig(-C2+A1*y1(i)+A2*y2(j))])-2;
        dist(i,j) = (y1(i)+1)^2+(y2(j)+1)^2;
        [V,D]     = eig(C2-A1*y1(i)-A2*y2(j));
        EIGS(i,j) = min(diag(D));
        if EIGS(i,j) >= 0
            grad(i,j) = 2;
        elseif EIGS(i,j) < 0
            %S = sdpvar(1);
            repeat = sum(D == EIGS(i,j),'all');
            if repeat>1
                disp('wait');
            end
            [d,ind] = sort(diag(D));
            Ds = D(ind,ind);
            Vs = V(:,ind);
            v = Vs(:,1);
            grad(i,j) = norm((-b-rho*v.^2));
        end
    end
end
grad2 = grad.^2;
sdist = sqrt(dist);
%dist = dist * muq;
surf(Y1,Y2,dist* muq,'FaceColor','g','EdgeColor',[0 1 0]);
hold on;
%colormap([1,1,0.5])
surf(Y1,Y2,obj,'FaceColor','y','EdgeColor',[1 1 0]);
%surf(Y1,Y2,sdist,'FaceColor','b','FaceAlpha',1);
%hold on;
%surf(Y1,Y2,grad,'FaceColor','b','FaceAlpha',1);
hold on;
%surf(Y1,Y2,grad2*0.5,'FaceColor','r','FaceAlpha',1);
%surf(Y1,Y2,sdist*mue,'FaceColor',[0.4940 0.1840 0.5560],'FaceAlpha',1);
xlabel('$y_1$','interpreter','latex');
ylabel('$y_2$','interpreter','latex');
% zlabel('$f(y)$','interpreter','latex')
%F = -(Y1+Y2+Y3+Y4)+rho*max([0,eig(C-Y1-Y2-Y3-Y4)]);