function [F0_LBF, F1_LBF, F2_LBF, F3D_LBF, D_LBF, R2] = line_of_best_fit(data, load_cases)
    loading_case = data(:, 1); % load case data (lbf)
    F0 = data(:, 2); % reaction force data (lbf)
    F1 = data(:, 3); % reaction force data (lbf)
    F2 = data(:, 4); % reaction force data (lbf)
    F3D = data(:, 5); % reaction force data (lbf)
    D = data(:, 6); % vertical displacement at midspan (downward is positive) (in)

    [polycoeff_0, S_F0]  = polyfit(loading_case, F0, 1);
    [polycoeff_1, S_F1]  = polyfit(loading_case, F1, 1);
    [polycoeff_2, S_F2]  = polyfit(loading_case, F2, 1);
    [polycoeff_3, S_F3D] = polyfit(loading_case, F3D, 1);
    [polycoeff_4, S_D]   = polyfit(loading_case, D, 1);

    F0_LBF  = polycoeff_0(1)*load_cases + polycoeff_0(2); % F0 line of best fit
    F1_LBF  = polycoeff_1(1)*load_cases + polycoeff_1(2); % F1 line of best fit
    F2_LBF  = polycoeff_2(1)*load_cases + polycoeff_2(2); % F2 line of best fit
    F3D_LBF = polycoeff_3(1)*load_cases + polycoeff_3(2); % F3D line of best fit
    D_LBF   = polycoeff_4(1)*load_cases + polycoeff_4(2); % F3D line of best fit

    R2.F0  = S_F0.rsquared;
    R2.F1  = S_F1.rsquared;
    R2.F2  = S_F2.rsquared;
    R2.F3D = S_F3D.rsquared;
    R2.D   = S_D.rsquared;
end
