
%Apartado 2 ejercicio 2
%Funcion de biblioteca que recibe la matriz con los coeficientes de los 
%polinomios interpoladores de cada trozo, los nodos (o nudos, es lo mismo) y la
%malla donde se quiere evaluar el polinomio interpolador a trozos. Devuele un
%vector con las evaluaciones en los puntos de la malla.
%Nodos es la lista de nodos SIN REPETIR, ya me encargo yo de duplicarlos.
function resultado = hermiteTrozosEval(matriz, nodos, malla)
  m1 = length(malla);
  m = length(nodos) - 1;
  for j=1:m1
    %Hay que comprobar que el punto está en el intervalo de los nodos.
    if (malla(j)<nodos(1) || malla(j)>nodos(m + 1)) resultado(j)=0;
    else 
      %Buscamos el intervalo en el que está el punto de la malla
      for i=1:m
        if (malla(j)<=nodos(i+1)) 
          %Hay que tener los nodos duplicados correctamente para llamar a la 
          %funcion evaluadora.
          nodosRep(1) = nodos(i);
          nodosRep(2) = nodosRep(1);
          nodosRep(3) = nodos(i+1);
          nodosRep(4) = nodosRep(3);
          resultado(j)=polyinterpolador_eval(matriz(i,:), nodosRep, malla(j));
          break;
        endif
      endfor
    endif
  endfor
  
endfunction