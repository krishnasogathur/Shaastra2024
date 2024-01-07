% Solve over time interval [0,100] with initial conditions [1,1,1]
% ''f'' is set of differential equations
% ''a'' is array containing x, y, and z variables
% ''t'' is time variable
clc;clear;close;clc;

g = 9.81;
L = 1;
t = 0:0.01:10;
init = [pi/16, 0.1];  % example initial conditions

f = @(t,a) [a(2); - g/L * sin(a(1))];
%[t,a] = ode45(f,t,init);     % Runge-Kutta 4th/5th order ODE solver
%plot(a(:,1),a(:,2))
xlabel('Theta')
ylabel('Angular Velocity')
title('Phase Space Trajectory of Simple Pendulum')

% Initialize animated line
line_handle = animatedline('Marker', 'x');

% Iterate through time and update the plot
for i = 1:length(t)-1
    % Solve the ODE up to the current time
    [t_current, a_current] = ode45(f, [t(i) t(i+1)], init);
    
    % Update the initial conditions for the next iteration
    init = a_current(end, :);
    
    % Add the current point to the animated line
    addpoints(line_handle, init(1), init(2));
    
    % Update the plot
    drawnow;

    pause(0.01);
end