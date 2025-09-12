% Plots of Linear Regression Line of Best fit For Reaction
% Forces/Displacements vs Applied Loads

clear;
clc;
close all;

data1 = readmatrix('Case1data.csv');
data2 = readmatrix('Case2data.csv');
data3 = readmatrix('Case3data.csv');



function [Load_cases, F0_LBF, F1_LBF, F2_LBF, F3D_LBF, D_LBF] = line_of_best_fit(data)
    loading_case = data(:, 1); % load case data (lbf)
    F0 = data(:, 2); % reaction force data (lbf)
    F1 = data(:, 3); % reaction force data (lbf)
    F2 = data(:, 4); % reaction force data (lbf)
    F3D = data(:, 5); % reaction force data (lbf)
    D = data(:, 6); % vertical displacement at midspan (downward is positive) (in)

    Load_cases = linspace(0, max(loading_case));

    [polycoeff_0] = polyfit(loading_case, F0, 1);
    [polycoeff_1] = polyfit(loading_case, F1, 1);
    [polycoeff_2] = polyfit(loading_case, F2, 1);
    [polycoeff_3] = polyfit(loading_case, F3D, 1);
    [polycoeff_4] = polyfit(loading_case, D, 1);

    F0_LBF = polycoeff_0(1)*Load_cases + polycoeff_0(2); % F0 line of best fit
    F1_LBF = polycoeff_1(1)*Load_cases + polycoeff_1(2); % F1 line of best fit
    F2_LBF = polycoeff_2(1)*Load_cases + polycoeff_2(2); % F2 line of best fit
    F3D_LBF = polycoeff_3(1)*Load_cases + polycoeff_3(2); % F3D line of best fit
    D_LBF = polycoeff_4(1)*Load_cases + polycoeff_4(2); % F3D line of best fit
end


% Load_cases_1 = linspace(0, max(loading_case1));
[Load_cases_1, F0_1, F1_1, F2_1, F3D_1, D_1] = line_of_best_fit(data1);
[Load_cases_2, F0_2, F1_2, F2_2, F3D_2, D_2] = line_of_best_fit(data2);
[Load_cases_3, F0_3, F1_3, F2_3, F3D_3, D_3] = line_of_best_fit(data3);




figure();
hold on;
scatter(data1(:, 1), data1(:, 2),'r');
scatter(data2(:, 1), data2(:, 2), 'g');
scatter(data3(:, 1), data3(:, 2), 'b');
plot(Load_cases_1, F0_1, 'r');
plot(Load_cases_2, F0_2, 'g');
plot(Load_cases_3, F0_3, 'b');
title('Plot of F_0 vs Applied Loading');
xlabel('Applied Loading (lb)');
ylabel('F_0 (lb)');
legend('Case 1 Data', 'Case 2 Data', 'Case 3 Data','Case 1 Line of Best Fit', 'Case 2 Line of Best Fit', 'Case 3 Line of Best Fit', 'Location', 'best');
hold off;


figure();
hold on;
scatter(data1(:, 1), data1(:, 3), 'r');
scatter(data2(:, 1), data2(:, 3), 'g');
scatter(data3(:, 1), data3(:, 3), 'b');
plot(Load_cases_1, F1_1, 'r');
plot(Load_cases_2, F1_2, 'g');
plot(Load_cases_3, F1_3, 'b');
title('Plot of F_1 vs Applied Loading');
xlabel('Applied Loading (lb)');
ylabel('F_1 (lb)');
legend('Case 1 Data', 'Case 2 Data', 'Case 3 Data','Case 1 Line of Best Fit', 'Case 2 Line of Best Fit', 'Case 3 Line of Best Fit', 'Location', 'best');
hold off;


figure(); 
hold on;
scatter(data1(:, 1), data1(:, 4), 'r');
scatter(data2(:, 1), data2(:, 4), 'g');
scatter(data3(:, 1), data3(:, 4), 'b');
plot(Load_cases_1, F2_1, 'r');
plot(Load_cases_2, F2_2, 'g');
plot(Load_cases_3, F2_3, 'b');
title('Plot of F_2 vs Applied Loading');
xlabel('Applied Loading (lb)');
ylabel('F_2 (lb)');
legend('Case 1 Data', 'Case 2 Data', 'Case 3 Data','Case 1 Line of Best Fit', 'Case 2 Line of Best Fit', 'Case 3 Line of Best Fit', 'Location', 'best');
hold off;


figure(); 
hold on;
scatter(data1(:, 1), data1(:, 5), 'r');
scatter(data2(:, 1), data2(:, 5), 'g');
scatter(data3(:, 1), data3(:, 5), 'b');
plot(Load_cases_1, F3D_1, 'r');
plot(Load_cases_2, F3D_2, 'g');
plot(Load_cases_3, F3D_3, 'b');
title('Plot of F_3D vs Applied Loading');
xlabel('Applied Loading (lb)');
ylabel('F_3D (lb)');
legend('Case 1 Data', 'Case 2 Data', 'Case 3 Data','Case 1 Line of Best Fit', 'Case 2 Line of Best Fit', 'Case 3 Line of Best Fit', 'Location', 'best');
hold off;


figure(); 
hold on;
scatter(data1(:, 1), data1(:, 6), 'r');
scatter(data2(:, 1), data2(:, 6), 'g');
scatter(data3(:, 1), data3(:, 6), 'b');
plot(Load_cases_1, D_1, 'r');
plot(Load_cases_2, D_2, 'g');
plot(Load_cases_3, D_3, 'b');
title('Plot of Vertical Displacement vs Applied Loading (Positive is Downward');
xlabel('Applied Loading (lb)');
ylabel('Displacement (in)');
legend('Case 1 Data', 'Case 2 Data', 'Case 3 Data','Case 1 Line of Best Fit', 'Case 2 Line of Best Fit', 'Case 3 Line of Best Fit', 'Location', 'best');
hold off;
