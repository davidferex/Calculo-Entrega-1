
function coef = hermiteTrozos(nudos, ordenadas, derivadas) 
  m = length(nudos) - 1;
  for i=1:m
    x = nudos(i:i+1);
    y{1}(1) = ordenadas(i);
    y{1}(2) = derivadas(i);
    y{2}(1) = ordenadas(i+1);
    y{2}(2) = derivadas(i+1);
    [coef(i,:), nodosRep] = interpolHermite(x,y);
  endfor

endfunction