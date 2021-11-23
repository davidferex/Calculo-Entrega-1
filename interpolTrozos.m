

#Opto por la opcion de que los nudos sean nodos.
function coefTrozos = interpolTrozos(nodos, m, d, ordenadas)
  i1 = 1;
  i2 = d+1;
  for j=1:m
    coefTrozos(j,:) = interpolNewton(nodos(i1:i2), ordenadas(i1:i2));
    i1 = i2;
    i2 = i2 + d;
  endfor
  
  
end