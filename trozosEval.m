
%Apartado 2 ejercicio 1.
%Funcion de biblioteca que recibe la matriz con los coeficientes de los 
%polinomios interpoladores de cada trozo, los nodos, la d, la m, y las abcisas
%donde se quiere evaluar (no tienen por que estar en orden).
%Devuelve los valores de la evaluacion en las abcisas (vector).
function valores = trozosEval(matriz, nodos, d, m, abcisas)
  
  %El vector de nodos debe ser correcto
  if length(nodos) ~= m*d + 1
    error("El vector de nodos debe ser de dimension m*d + 1");
  endif
  m1 = length(abcisas);
  for j=1:m1
    h = d + 1;
    %La abcisa debe estar dentro del intervalo de los nodos.
    if (abcisas(j)<nodos(1) || abcisas(j)>nodos(m*d + 1)) valores(j)=0;
    else 
      for i=1:m
        %Si la abcisa pertenece al intervalo, hacemos la evaluacion.
        if (abcisas(j)<=nodos(h)) 
          valores(j)=polyinterpolador_eval(matriz(i,:), nodos(h-d:h), abcisas(j));
          break;
        endif
        h = h + d;
      endfor
    endif
  endfor
end