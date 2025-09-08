clear;
clc;
close all;

P = 222.4; % N
L = 4; % m
E = 6.95*10^10; % Pa
I = 2.475*10^-6; % m^4
a = 2;
EI = E*I;

x1 = linspace(0, a);
x2 = linspace(a, L);


c_1 = -(P*L*a)/(3*E*I) + (P*a^2)/(2*E*I) - (P*a^3)/(6*E*I*L);
c_3 = (-1*P*L*a)/(3*EI) - P*(a^3)/(6*EI*L);
c_4 = P*(a^3)/(6*EI);

y_1 = (10^3)*((1-(a/L))*(P*(x1.^3)/(6*EI))+c_1.*x1);  % mm 
y_2 = (10^3)*((a*P/(EI))*((0.5*x2.^2)-(1/(6*L))*(x2.^3))+c_3.*x2+c_4);         

% y_1 = @(x) (10^3)*((1-(a/L))*(P*(x^3)/(6*EI))+c_1*x);
% y_2 = @(x) (10^3)*((a*P/(EI))*((0.5*x^2)-(1/(6*L))*(x^3))+c_3*x+c_4);         

figure();
hold on;
plot(x1, y_1,'r', 'LineWidth', 2);
plot(x2, y_2,'b', 'LineWidth', 2);
xlim([0 L]);
ylim([-1.8 0.1]);
xlabel('Position along Beam (m)');
ylabel('Deflection (mm)');
title('Plot of Position vs Deflection Part 1.3');


