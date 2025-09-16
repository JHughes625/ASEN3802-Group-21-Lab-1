% Plots of Linear Regression Line of Best fit For Reaction
% Forces/Displacements vs Applied Loads

clear;
clc;
close all;

PLOT_DATA = 1;
data_center = readmatrix('data/center.csv');
data_arbitrary = readmatrix('data/arbitrary.csv');
data_symmetric = readmatrix('data/symmetric.csv');

% add offsets to F3D to make them positive
data_center(:, 5) = data_center(:, 5) - mean(data_center(10, 5));
data_arbitrary(:, 5) = data_arbitrary(:, 5) - mean(data_arbitrary(10, 5));
data_symmetric(:, 5) = data_symmetric(:, 5) - mean(data_symmetric(10, 5));

load_cases = 0:0.01:60;
[F0_center, F1_center, F2_center, F3D_center, D_center, R2_center] = line_of_best_fit(data_center, load_cases);
[F0_arbitrary, F1_arbitrary, F2_arbitrary, F3D_arbitrary, D_arbitrary, R2_arbitrary] = line_of_best_fit(data_arbitrary, load_cases);
[F0_symmetric, F1_symmetric, F2_symmetric, F3D_symmetric, D_symmetric, R2_symmetric] = line_of_best_fit(data_symmetric, load_cases);

L = 4;
truss_positions = (0 : 0.25 : L)';
in_to_m = 0.0254;
lbs_to_N = 4.44822;

position_arbitrary_map = [truss_positions, zeros(length(truss_positions), 1)];
midspan_deflection_arbitrary = [(0:10:50)', zeros(6, 1)];
for i = 0 : 10 : 50
  deflection = interp1(load_cases, D_arbitrary, i) * in_to_m;
  [a, midspan_deflection_arbitrary(i / 10 + 1, 2)] = arbitrary(lbs_to_N * i, deflection);  
  idx = find(position_arbitrary_map(:, 1) == a, 1);
  position_arbitrary_map(idx, 2) = position_arbitrary_map(idx, 2) + 1;
end

max_count_arbitrary = max(position_arbitrary_map(:, 2));
position_arbitrary_from_counts = position_arbitrary_map( position_arbitrary_map(:, 2) == max_count_arbitrary, 1);
position_arbitrary_from_avg = position_from_avg(position_arbitrary_map);


if PLOT_DATA == 1
  figure();
  hold on;
  scatter(data_center(:, 1), data_center(:, 2),'r');
  scatter(data_arbitrary(:, 1), data_arbitrary(:, 2), 'g');
  scatter(data_symmetric(:, 1), data_symmetric(:, 2), 'b');
  plot(load_cases, F0_center, 'r');
  plot(load_cases, F0_arbitrary, 'g');
  plot(load_cases, F0_symmetric, 'b');
  title('First Left Load Cell Reading for Each Case');
  xlabel('Applied Loading (lb)');
  ylabel('F_0 (lb)');
  legend('Case 1 Data', 'Case 2 Data', 'Case 3 Data','Case 1 Line of Best Fit', 'Case 2 Line of Best Fit', 'Case 3 Line of Best Fit', 'Location', 'best');
  hold off;


  figure();
  hold on;
  scatter(data_center(:, 1), data_center(:, 3), 'r');
  scatter(data_arbitrary(:, 1), data_arbitrary(:, 3), 'g');
  scatter(data_symmetric(:, 1), data_symmetric(:, 3), 'b');
  plot(load_cases, F1_center, 'r');
  plot(load_cases, F1_arbitrary, 'g');
  plot(load_cases, F1_symmetric, 'b');
  title('Second Left Load Cell Reading for Each Case');
  xlabel('Applied Loading (lb)');
  ylabel('F_center (lb)');
  legend('Case 1 Data', 'Case 2 Data', 'Case 3 Data','Case 1 Line of Best Fit', 'Case 2 Line of Best Fit', 'Case 3 Line of Best Fit', 'Location', 'best');
  hold off;


  figure(); 
  hold on;
  scatter(data_center(:, 1), data_center(:, 4), 'r');
  scatter(data_arbitrary(:, 1), data_arbitrary(:, 4), 'g');
  scatter(data_symmetric(:, 1), data_symmetric(:, 4), 'b');
  plot(load_cases, F2_center, 'r');
  plot(load_cases, F2_arbitrary, 'g');
  plot(load_cases, F2_symmetric, 'b');
  title('Right Load Cell Reading for Each Case');
  xlabel('Applied Loading (lb)');
  ylabel('F_arbitrary (lb)');
  legend('Case 1 Data', 'Case 2 Data', 'Case 3 Data','Case 1 Line of Best Fit', 'Case 2 Line of Best Fit', 'Case 3 Line of Best Fit', 'Location', 'best');
  hold off;


  figure(); 
  hold on;
  scatter(data_center(:, 1), data_center(:, 5), 'r');
  scatter(data_arbitrary(:, 1), data_arbitrary(:, 5), 'g');
  scatter(data_symmetric(:, 1), data_symmetric(:, 5), 'b');
  plot(load_cases, F3D_center, 'r');
  plot(load_cases, F3D_arbitrary, 'g');
  plot(load_cases, F3D_symmetric, 'b');
  title('Adjusted Center Load Cell Reading for Each Case');
  xlabel('Applied Loading (lb)');
  ylabel('F_{3D} (lb)');
  legend('Case 1 Data', 'Case 2 Data', 'Case 3 Data','Case 1 Line of Best Fit', 'Case 2 Line of Best Fit', 'Case 3 Line of Best Fit', 'Location', 'best');
  hold off;


  figure(); 
  hold on;
  scatter(data_center(:, 1), data_center(:, 6), 'r');
  scatter(data_arbitrary(:, 1), data_arbitrary(:, 6), 'g');
  scatter(data_symmetric(:, 1), data_symmetric(:, 6), 'b');
  plot(load_cases, D_center, 'r');
  plot(load_cases, D_arbitrary, 'g');
  plot(load_cases, D_symmetric, 'b');
  title('Midspan Vertical Displacement for Each Case (Positive is Downward)');
  xlabel('Applied Loading (lb)');
  ylabel('Displacement (in)');
  legend('Case 1 Data', 'Case 2 Data', 'Case 3 Data','Case 1 Line of Best Fit', 'Case 2 Line of Best Fit', 'Case 3 Line of Best Fit', 'Location', 'best');
  hold off;
end
