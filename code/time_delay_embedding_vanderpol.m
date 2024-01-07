clc;clear;close;clc;

dt = 0.01; %time shifts
t = 0:dt:50;

x0 = [0.1,5];
mu = 1.2;

[t,y]=ode45('rhs_dyn',t,x0,[],mu);

plot(t,y(:,1),t,y(:,2),'Linewidth',[2])

x1=y(:,1);
x2=y(:,2);



 