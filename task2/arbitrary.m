function [a] = arbitrary(P, displacement_y)
  L = 4; % m
  E = 6.95*10^10; % Pa
  I = 2.475*10^-6; % m^4
  EI = E*I;
  TOLERANCE = 1.01;

  for a = 0 : 0.25 : L
    y_1 = (1 / EI) * ( (L^3 * P * (1 - a / L)) - (P * a^3 / 6) + (P * a^2 * L / 4) - (P * a * L^2 / 12) );
    y_2 = (1 / EI) * ( ((5 / 48) * (P * a * L^2)) - (a^3 * L / 12) - (P * a * L^2 / 6) + (P * a^3 / 6) );

    if (displacement_y - TOLERANCE <= y_1 && y_1 <= displacement_y + TOLERANCE) || ...
       (displacement_y - TOLERANCE <= y_2 && y_2 <= displacement_y + TOLERANCE)
      return;
    end
  end

end
