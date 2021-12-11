
%Apartado 2 ejercicio 3.
%Funcion de biblioteca que recibe la matriz con los coeficientes de Lagrange,
%los nodos (realmente no hacen falta) y las ordenadas correspondientes a dichos
%nodos. Devuelve un vector con los coeficientes del polinomio interpolador
%en la forma de Lagrange.
%Importante: se deben proporcionar las ordenadas en el mismo orden que se
%proporcionaron los nodos al hacer la matriz.
function coef = coefPolLagrange(matriz, nodos, ordenadas)
  
  n = length(nodos) - 1;
  coef = 0;
  %Simplemente se multiplica cada fila de la matriz (cada factor) por la 
  %ordenada correspondiente y se va sumando.
  for i=1:n+1
    coef = coef + matriz(i,:).*ordenadas(i);
  endfor
  
  
endfunction