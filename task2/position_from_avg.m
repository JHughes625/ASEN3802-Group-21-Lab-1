function [x] = position_from_avg(positions_vec)
  nonzero = positions_vec( positions_vec(:, 2) ~= 0, : );
  avg = mean(nonzero(:, 1), Weights=nonzero(:, 2));
  [~, min_idx] = min( abs(avg - positions_vec(:, 1)) );
  x = positions_vec(min_idx, 1);
end
