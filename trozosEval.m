

function valores = trozosEval(matriz, nodos, d, m, abcisas)
  
  m1 = length(abcisas);
  for j=1:m1
     h = d + 1;
    if (abcisas(j)<nodos(1) || abcisas(j)>nodos(m*d + 1)) valores(j)=0;
    else 
      for i=1:m
        if (abcisas(j)<=nodos(h)) 
          valores(j)=polyinterpolador_eval(matriz(i,:), nodos(h-d:h), abcisas(j));
          break;
        endif
        h = h + d;
      endfor
    endif
  endfor
end