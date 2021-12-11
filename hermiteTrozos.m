
%Apartado 1 ejercicio 2
%Funcion de biblioteca que recibe los nudos, las ordenadas en dichos puntos,
% y las derivadas en dichos puntos. Devuelve una matriz en la que cada fila
%están los coeficientes de Newton del polinomio interpolador de Hermite de grado 3
%del intervalo [nudos(i), nudos(i+1)]
function coef = hermiteTrozos(nudos, ordenadas, derivadas) 
  %Habra m intervalos
  m = length(nudos) - 1;
  for i=1:m
    %Cogemos los dos nodos por intervalo
    x = nudos(i:i+1);
    %En cada nodo, tomamos su ordenada y su derivada.
    y{1}(1) = ordenadas(i);
    y{1}(2) = derivadas(i);
    y{2}(1) = ordenadas(i+1);
    y{2}(2) = derivadas(i+1);
    %Realmente nodosRep no lo necesitamos
    [coef(i,:), nodosRep] = interpolHermite(x,y);
  endfor

endfunction