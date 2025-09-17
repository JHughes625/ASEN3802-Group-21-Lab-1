% Plots of Linear Regression Line of Best fit For Reaction
% Forces/Displacements vs Applied Loads

clear;
clc;
close all;

data1 = readmatrix('Case1data.csv');
data2 = readmatrix('Case2data.csv');
data3 = readmatrix('Case3data.csv');



function [Load_cases, F0_LBF, F1_LBF, F2_LBF, F3D_LBF, D_LBF, F0_CI_lo, F0_CI_hi, F1_CI_lo, F1_CI_hi, F2_CI_lo, F2_CI_hi, F3_CI_lo, F3_CI_hi, D_CI_lo, D_CI_hi, residual_0, residual_1, residual_2, residual_3, residual_D] = line_of_best_fit(data)
    loading_case = data(:, 1); % load case data (lbf)
    F0 = data(:, 2); % reaction force data (lbf)
    F1 = data(:, 3); % reaction force data (lbf)
    F2 = data(:, 4); % reaction force data (lbf)
    F3D = data(:, 5) - mean(data(10, 5)); % reaction force data (lbf)  % accounts for starting values being negative (offsets all values)
    D = data(:, 6); % vertical displacement at midspan (downward is positive) (in)

    Load_cases = linspace(0, max(loading_case), 110);
    

    [polycoeff_0, S0] = polyfit(loading_case, F0, 1);
    [polycoeff_1, S1] = polyfit(loading_case, F1, 1);
    [polycoeff_2, S2] = polyfit(loading_case, F2, 1);
    [polycoeff_3, S3] = polyfit(loading_case, F3D, 1);
    [polycoeff_4, S4] = polyfit(loading_case, D, 1);

    F0_LBF = polycoeff_0(1)*Load_cases + polycoeff_0(2); % F0 line of best fit
    F1_LBF = polycoeff_1(1)*Load_cases + polycoeff_1(2); % F1 line of best fit
    F2_LBF = polycoeff_2(1)*Load_cases + polycoeff_2(2); % F2 line of best fit
    F3D_LBF = polycoeff_3(1)*Load_cases + polycoeff_3(2); % F3D line of best fit
    D_LBF = polycoeff_4(1)*Load_cases + polycoeff_4(2); % F3D line of best fit

    [y0_data, d0]= polyval(polycoeff_0, Load_cases, S0); % polyval to find standard error sigma
    y0 = polyval(polycoeff_0, loading_case); % polyval to find residuals
    [y1_data, d1]= polyval(polycoeff_1, Load_cases, S1); 
    y1 = polyval(polycoeff_1, loading_case); 
    [y2_data, d2]= polyval(polycoeff_2, Load_cases, S2); 
    y2 = polyval(polycoeff_2, loading_case); 
    [y3_data, d3]= polyval(polycoeff_3, Load_cases, S3); 
    y3 = polyval(polycoeff_3, loading_case); 
    [y4_data, d4]= polyval(polycoeff_4, Load_cases, S4); 
    y4 = polyval(polycoeff_4, loading_case); 

    F0_CI_lo = y0_data - 2*d0; % -2sigma 95% CI
    F0_CI_hi = y0_data + 2*d0; % +2sigma 95% CI
    F1_CI_lo = y1_data - 2*d1; 
    F1_CI_hi = y1_data + 2*d1; 
    F2_CI_lo = y2_data - 2*d2; 
    F2_CI_hi = y2_data + 2*d2; 
    F3_CI_lo = y3_data - 2*d3; 
    F3_CI_hi = y3_data + 2*d3; 
    D_CI_lo = y4_data - 2*d4; 
    D_CI_hi = y4_data + 2*d4; 

    residual_0 = F0 - y0; % residual for F0
    residual_1 = F1 - y1;
    residual_2 = F2 - y2; 
    residual_3 = F3D - y3;
    residual_D = D - y4; 

end


% Load_cases_1 = linspace(0, max(loading_case1));
[Load_cases_1, F0_1, F1_1, F2_1, F3D_1, D_1, F0_CI1_lo, F0_CI1_hi, F1_CI1_lo, F1_CI1_hi, F2_CI1_lo, F2_CI1_hi, F3_CI1_lo, F3_CI1_hi, D_CI1_lo, D_CI1_hi, residual1_0, residual1_1, residual1_2, residual1_3, residual1_D] = line_of_best_fit(data1);
[Load_cases_2, F0_2, F1_2, F2_2, F3D_2, D_2, F0_CI2_lo, F0_CI2_hi, F1_CI2_lo, F1_CI2_hi, F2_CI2_lo, F2_CI2_hi, F3_CI2_lo, F3_CI2_hi, D_CI2_lo, D_CI2_hi, residual2_0, residual2_1, residual2_2, residual2_3, residual2_D] = line_of_best_fit(data2);
[Load_cases_3, F0_3, F1_3, F2_3, F3D_3, D_3, F0_CI3_lo, F0_CI3_hi, F1_CI3_lo, F1_CI3_hi, F2_CI3_lo, F2_CI3_hi, F3_CI3_lo, F3_CI3_hi, D_CI3_lo, D_CI3_hi, residual3_0, residual3_1, residual3_2, residual3_3, residual3_D] = line_of_best_fit(data3);




figure();  % F_0
hold on;
scatter(data1(:, 1), data1(:, 2),'r');
scatter(data2(:, 1), data2(:, 2), 'g');
scatter(data3(:, 1), data3(:, 2), 'b');
plot(Load_cases_1, F0_1, 'r', 'LineWidth',2);
plot(Load_cases_2, F0_2, 'g', 'LineWidth',2);
plot(Load_cases_3, F0_3, 'b', 'LineWidth',2);
plot(Load_cases_1, F0_CI1_hi, 'k--');
plot(Load_cases_1, F0_CI1_lo, 'k--');
plot(Load_cases_2, F0_CI2_hi, 'k--');
plot(Load_cases_2, F0_CI2_lo, 'k--');
plot(Load_cases_3, F0_CI3_hi, 'k--');
plot(Load_cases_3, F0_CI3_lo, 'k--');
title('Plot of F_0 vs Applied Loading');
xlabel('Applied Loading (lb)');
ylabel('F_0 (lb)');
legend('Case 1 Data', 'Case 2 Data', 'Case 3 Data','Case 1 Line of Best Fit', 'Case 2 Line of Best Fit', 'Case 3 Line of Best Fit', '95% Confidence Interval (+\- 2 \sigma)', 'Location', 'best');
hold off;

% figure; hold on; grid on;
% scatter(data1(:,1), residual1_0, 25, 'r');   % Case 1: 110 pts
% scatter(data2(:,1), residual2_0, 25, 'g');   % Case 2: 110 pts
% scatter(data3(:,1), residual3_0, 25, 'b');   % Case 3: 70 pts
% title('Residuals for F_0 vs Applied Loading');
% xlabel('Applied Loading (lb)');
% ylabel('Residuals (lb)');
% hold off;




figure();  % F_1
hold on;
scatter(data1(:, 1), data1(:, 3),'r');
scatter(data2(:, 1), data2(:, 3), 'g');
scatter(data3(:, 1), data3(:, 3), 'b');
plot(Load_cases_1, F1_1, 'r', 'LineWidth',2);
plot(Load_cases_2, F1_2, 'g', 'LineWidth',2);
plot(Load_cases_3, F1_3, 'b', 'LineWidth',2);
plot(Load_cases_1, F1_CI1_hi, 'k--');
plot(Load_cases_1, F1_CI1_lo, 'k--');
plot(Load_cases_2, F1_CI2_hi, 'k--');
plot(Load_cases_2, F1_CI2_lo, 'k--');
plot(Load_cases_3, F1_CI3_hi, 'k--');
plot(Load_cases_3, F1_CI3_lo, 'k--');
title('Plot of F_1 vs Applied Loading');
xlabel('Applied Loading (lb)');
ylabel('F_1 (lb)');
legend('Case 1 Data', 'Case 2 Data', 'Case 3 Data','Case 1 Line of Best Fit', 'Case 2 Line of Best Fit', 'Case 3 Line of Best Fit', '95% Confidence Interval (+\- 2 \sigma)', 'Location', 'best');
hold off;

% 
% figure; hold on; grid on;
% scatter(data1(:,1), residual1_1, 25, 'r');  
% scatter(data2(:,1), residual2_1, 25, 'g');  
% scatter(data3(:,1), residual3_1, 25, 'b');   
% title('Residuals for F_1 vs Applied Loading');
% xlabel('Applied Loading (lb)');
% ylabel('Residuals (lb)');
% hold off;




figure();  % F_2
hold on;
scatter(data1(:, 1), data1(:, 4),'r');
scatter(data2(:, 1), data2(:, 4), 'g');
scatter(data3(:, 1), data3(:, 4), 'b');
plot(Load_cases_1, F2_1, 'r', 'LineWidth',2);
plot(Load_cases_2, F2_2, 'g', 'LineWidth',2);
plot(Load_cases_3, F2_3, 'b', 'LineWidth',2);
plot(Load_cases_1, F2_CI1_hi, 'k--');
plot(Load_cases_1, F2_CI1_lo, 'k--');
plot(Load_cases_2, F2_CI2_hi, 'k--');
plot(Load_cases_2, F2_CI2_lo, 'k--');
plot(Load_cases_3, F2_CI3_hi, 'k--');
plot(Load_cases_3, F2_CI3_lo, 'k--');
title('Plot of F_2 vs Applied Loading');
xlabel('Applied Loading (lb)');
ylabel('F_2 (lb)');
legend('Case 1 Data', 'Case 2 Data', 'Case 3 Data','Case 1 Line of Best Fit', 'Case 2 Line of Best Fit', 'Case 3 Line of Best Fit', '95% Confidence Interval (+\- 2 \sigma)', 'Location', 'best');
hold off;

% figure; hold on; grid on;
% scatter(data1(:,1), residual1_2, 25, 'r');  
% scatter(data2(:,1), residual2_2, 25, 'g');  
% scatter(data3(:,1), residual3_2, 25, 'b');   
% title('Residuals for F_2 vs Applied Loading');
% xlabel('Applied Loading (lb)');
% ylabel('Residuals (lb)');
% hold off;



figure();  % F_3D
hold on;
scatter(data1(:, 1), data1(:, 5) - mean(data1(10, 5)),'r'); 
scatter(data2(:, 1), data2(:, 5) - mean(data2(10, 5)), 'g');
scatter(data3(:, 1), data3(:, 5) - mean(data3(10, 5)), 'b');
plot(Load_cases_1, F3D_1, 'r', 'LineWidth',2);
plot(Load_cases_2, F3D_2, 'g', 'LineWidth',2);
plot(Load_cases_3, F3D_3, 'b', 'LineWidth',2);
plot(Load_cases_1, F3_CI1_hi, 'k--');
plot(Load_cases_1, F3_CI1_lo, 'k--');
plot(Load_cases_2, F3_CI2_hi, 'k--');
plot(Load_cases_2, F3_CI2_lo, 'k--');
plot(Load_cases_3, F3_CI3_hi, 'k--');
plot(Load_cases_3, F3_CI3_lo, 'k--');
title('Plot of F_3D vs Applied Loading');
xlabel('Applied Loading (lb)');
ylabel('F_3D (lb)');
legend('Case 1 Data', 'Case 2 Data', 'Case 3 Data','Case 1 Line of Best Fit', 'Case 2 Line of Best Fit', 'Case 3 Line of Best Fit', '95% Confidence Interval (+\- 2 \sigma)', 'Location', 'best');
hold off;

% figure; hold on; grid on;
% scatter(data1(:,1), residual1_3, 25, 'r');  
% scatter(data2(:,1), residual2_3, 25, 'g');  
% scatter(data3(:,1), residual3_3, 25, 'b');   
% title('Residuals for F_3D vs Applied Loading');
% xlabel('Applied Loading (lb)');
% ylabel('Residuals (lb)');
% hold off;




figure();  % D
hold on;
scatter(data1(:, 1), data1(:, 6),'r');
scatter(data2(:, 1), data2(:, 6), 'g');
scatter(data3(:, 1), data3(:, 6), 'b');
plot(Load_cases_1, D_1, 'r', 'LineWidth',2);
plot(Load_cases_2, D_2, 'g', 'LineWidth',2);
plot(Load_cases_3, D_3, 'b', 'LineWidth',2);
plot(Load_cases_1, D_CI1_hi, 'k--');
plot(Load_cases_1, D_CI1_lo, 'k--');
plot(Load_cases_2, D_CI2_hi, 'k--');
plot(Load_cases_2, D_CI2_lo, 'k--');
plot(Load_cases_3, D_CI3_hi, 'k--');
plot(Load_cases_3, D_CI3_lo, 'k--');
title('Plot of Displacement vs Applied Loading');
xlabel('Applied Loading (lb)');
ylabel('Displacement (in)');
legend('Case 1 Data', 'Case 2 Data', 'Case 3 Data','Case 1 Line of Best Fit', 'Case 2 Line of Best Fit', 'Case 3 Line of Best Fit', '95% Confidence Interval (+\- 2 \sigma)', 'Location', 'best');
hold off;

% figure; hold on; grid on;
% scatter(data1(:,1), residual1_D, 25, 'r');  
% scatter(data2(:,1), residual2_D, 25, 'g');  
% scatter(data3(:,1), residual3_D, 25, 'b');   
% title('Residuals for Displacement vs Applied Loading');
% xlabel('Applied Loading (lb)');
% ylabel('Residuals (in)');
% hold off;





figure('Name','Residuals vs Applied Loads (all cases)');

% F0 residuals
subplot(5,1,1); hold on; grid on;
scatter(data1(:,1), residual1_0, 25, 'r', 'filled');
scatter(data2(:,1), residual2_0, 25, 'g', 'filled');
scatter(data3(:,1), residual3_0, 25, 'b', 'filled');
yline(0,'k--','LineWidth',1);
title('F_0 Residuals vs Load');
ylabel('lb');
legend('Case 1','Case 2','Case 3','Location','best'); % keep legend once

% F1 residuals
subplot(5,1,2); hold on; grid on;
scatter(data1(:,1), residual1_1, 25, 'r', 'filled');
scatter(data2(:,1), residual2_1, 25, 'g', 'filled');
scatter(data3(:,1), residual3_1, 25, 'b', 'filled');
yline(0,'k--','LineWidth',1);
title('F_1 Residuals vs Load');
ylabel('lb');

% F2 residuals
subplot(5,1,3); hold on; grid on;
scatter(data1(:,1), residual1_2, 25, 'r', 'filled');
scatter(data2(:,1), residual2_2, 25, 'g', 'filled');
scatter(data3(:,1), residual3_2, 25, 'b', 'filled');
yline(0,'k--','LineWidth',1);
title('F_2 Residuals vs Load');
ylabel('lb');

% F3D residuals
subplot(5,1,4); hold on; grid on;
scatter(data1(:,1), residual1_3, 25, 'r', 'filled');
scatter(data2(:,1), residual2_3, 25, 'g', 'filled');
scatter(data3(:,1), residual3_3, 25, 'b', 'filled');
yline(0,'k--','LineWidth',1);
title('F_{3D} Residuals vs Load');
ylabel('lb');

% D residuals
subplot(5,1,5); hold on; grid on;
scatter(data1(:,1), residual1_D, 25, 'r', 'filled');
scatter(data2(:,1), residual2_D, 25, 'g', 'filled');
scatter(data3(:,1), residual3_D, 25, 'b', 'filled');
yline(0,'k--','LineWidth',1);
title('Displacement Residuals vs Load');
ylabel('in');
xlabel('Applied Load (lb)');