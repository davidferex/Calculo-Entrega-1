%Apartado 1 ejercicio 3.
%Funcion de biblioteca que recibe un vector con los nodos y devuelve los coeficientes
%de los polinomios denominados factores de Lagrange. Devuelve una matriz,
%en cada fila con los coeficientes correspondientes a cada nodo.
function matriz = factLagrange(nodos)
  
  n = length(nodos) -1;
  
  %Para cada nodo hacemos un bucle de productos de polinomios.
  for i=1:n+1
    %Hay que usar una variable auxiliar para no tener problemas con dimensiones,etc.
    auxiliar = 1;
    for j=1:n+1
      %Se debe evitar el caso de que sea el mismo nodo.
      if j ~= i
        pol(1) = 1/(nodos(i)-nodos(j));
        pol(2) = -nodos(j)/(nodos(i)-nodos(j));
        auxiliar = conv(auxiliar, pol);
      endif
    endfor
    matriz(i,:) = auxiliar;
    
  endfor
  
 endfunction