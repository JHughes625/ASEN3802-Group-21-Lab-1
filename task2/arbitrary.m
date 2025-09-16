function [a] = arbitrary(P, displacement_y)
  L = 4; % m
  E = 6.95*10^10; % Pa
  I = 2.475*10^-6; % m^4
  EI = E*I;

  a = 0;
  closest_displacement_difference = Inf;
  for i = 0 : 0.25 : L
    if (i < L / 2)
      y = abs( (1 / EI) * ( ((5 / 48) * (P * i * L^2)) - (i^3 * L / 12) - (P * i * L^2 / 6) + (P * i^3 / 6) ) );
    else
      y = abs( (1 / EI) * ( (L^3 * P * (1 - i / L)) - (P * i^3 / 6) + (P * i^2 * L / 4) - (P * i * L^2 / 12) ) );
    end

    if ( abs(y - displacement_y) < closest_displacement_difference )
      closest_displacement_difference = abs(y - displacement_y);
      a = i;
    end
  end

end
