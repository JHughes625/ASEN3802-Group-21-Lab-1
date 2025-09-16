function [a_guess] = arbitrary(P, displacement_y)
  L = 4; % m
  E = 6.95*10^10; % Pa
  I = 2.475*10^-6; % m^4
  EI = E*I;

  a_guess = 0;
  closest_displacement_difference = Inf;
  for a = 0 : 0.25 : L
    if (a < L / 2)
      y = abs( ( (P * a^3 / 12) - (P * a * L^2 / 16) ) / EI );
    else
      y = abs( ( (P * L^3) - (5 * P * a * L^2) - (8 * P * a^3) + (12 * P * a^2 * L) ) / (48 * EI) );
    end

    if ( abs(y - displacement_y) < closest_displacement_difference )
      closest_displacement_difference = abs(y - displacement_y);
      a_guess = a;
    end
  end

end
