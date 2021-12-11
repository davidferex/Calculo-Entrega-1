
%Apartado 1 ejercicio 1
%Opto por la opcion de que los nudos sean nodos.
%Funcion de biblioteca que recibe m*d + 1 nodos, la m, la d y las ordenadas
%correspondientes, y devuelve una matriz, donde cada fila son los coeficientes
%del polinomio interpolador de Newton de cada trozo.
function coefTrozos = interpolTrozos(nodos, m, d, ordenadas)
  %El vector de nodos debe ser correcto
  if length(nodos) ~= m*d + 1
    error("El vector de nodos debe ser de dimension m*d + 1");
  endif
  i1 = 1;
  i2 = d+1;
  %Empezamos en 1 y d+1, y en el bucle vamos actualizando correctamente.
  for j=1:m
    %Interpolamos en cada uno de los trozos
    coefTrozos(j,:) = interpolNewton(nodos(i1:i2), ordenadas(i1:i2));
    i1 = i2;
    i2 = i2 + d;
  endfor
  
  
end