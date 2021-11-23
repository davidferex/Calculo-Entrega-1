
%Nodos es la lista de nodos SIN REPETIR, ya me encargo yo de duplicarlos.
function resultado = hermiteTrozosEval(matriz, nodos, malla)
  m1 = length(malla);
  m = length(nodos) - 1;
  for j=1:m1
    if (malla(j)<nodos(1) || malla(j)>nodos(m + 1)) resultado(j)=0;
    else 
      for i=1:m
        if (malla(j)<=nodos(i+1)) 
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