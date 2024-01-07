% Solve over time interval [0,100] with initial conditions [1,1,1]
% ''f'' is set of differential equations
% ''a'' is array containing x, y, and z variables
% ''t'' is time variable
clc;clear;close;clc
sigma = 10;
beta = 8/3;
rho = 28;

init = [1,5,9]; 
dt = 0.01;
t = 0:dt:20;

f = @(t,a) [-sigma*a(1) + sigma*a(2); rho*a(1) - a(2) - a(1)*a(3); -beta*a(3) + a(1)*a(2)];
[t,a] = ode45(f,t,init);     % Runge-Kutta 4th/5th order ODE solver
figure(1) 
plot3(init(1), init(2), init(3), 'Marker', 'x');  % Initial point


% Initialize animated line
line_handle = animatedline('Marker', 'x');

% Iterate through time and update the plot
%for i = 1:length(t)-1
%    % Solve the ODE up to the current time
%    [t_current, a_current] = ode45(f, [t(i) t(i+1)], init);    
%    % Update the initial conditions for the next iteration
%    init = a_current(end, :);  
%    % Add the current point to the animated line
%    addpoints(line_handle, init(1),init(2),init(3));
%    % Update the plot
%    drawnow;
%    pause(0.001);
%end


%trial at delay embedding

x = a(:,1);
delay = 0.08;
a_delayed = [x(1:1000),x(1+delay/dt:1000 + delay/dt), x(1+2*delay/dt:1000 + 2*delay/dt)];

figure(1)
subplot(2,2,1),plot3(a_delayed(:,1),a_delayed(:,2),a_delayed(:,3))
subplot(2,2,2),plot3(a(:,1),a(:,2),a(:,3))