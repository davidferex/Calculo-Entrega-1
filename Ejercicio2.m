
%Apartados 3, 4 y 5 del ejercicio 2.
clc
clear all
close all
addpath('../Biblioteca')
output_precision(16)

%Apartado 3, comprobaciones con la funcion de Runge.
f = @(x) 1./(1 + x.^2);
derivada = @(x) (-2*x)./(1+x.^2).^2;
derivada2 = @(x) (-2 +6*x.^2)./(1+x.^2).^3;

nodos = linspace(-5,5, 20);
ordenadas = f(nodos);
derivadas = derivada(nodos);

%Sacamos el polinomio de hermite a trozos y evaluamos en una malla
coefNewton = hermiteTrozos(nodos, ordenadas, derivadas);
malla = linspace(-5, 5, 200);
resultado = hermiteTrozosEval(coefNewton, nodos, malla);
error = abs(resultado - f(malla));

%Dibujamos la funcion y el polinomio interpolador a trozos.
plot(malla, f(malla))
title('Ejemplo de Runge y su interpolacion de Hermite a trozos juntos')
hold on
plot(malla, resultado, 'color', 'r')
%Vemos como ambas graficas no se pueden distinguir casi, solo en el 0 se puede 
%ver cierta diferencia entre ambas.

%Dibujamos el error.
figure(2)
plot(malla, error)
title('Valor absoluto del error entre la funcion del ejemplo de Runge y su interpolacion de Hermite a trozos')
%Como era de esperar y como se comento, la mayor diferencia esta en el 0, aunque
%sigue siendo un error pequeño.

%Apartado 4, hacemos comparaciones con los splines con las mismas divisiones
figure(3)
[b,c,d] = splineSujeto(nodos, ordenadas, derivadas(1), derivadas(length(derivadas)));
resultadoSpline = splineEval(nodos, ordenadas, b,c,d, malla);
errorSpline = abs(resultadoSpline - f(malla));

%Dibujamos el polinomio interpolador de hermite a trozos y el spline, junto a la 
%funcion, para poder comparar adecuadamente.
plot(malla, resultado)
title('Polinomio interpolador de Hermite a trozos, spline y ejemplo de Runge')
hold on 
plot(malla, resultadoSpline, 'color', 'r')
hold on
plot(malla, f(malla), 'color', 'g')
%Vemos como, de nuevo, solo se pueden distinguir en el 0. El spline se queda un 
%por debajo, el polinomio de hermite a trozos aproxima mejor la funcion.
%No obstante, ninguno sufre el fenomeno de Runge que vimos en practicas.

%Dibujamos el error de la interpolacion a trozos y el del spline
%Prefiero comparar el error visualmente, es mas sencillo que ver los numeros...
figure(4)
plot(malla, error)
title('Errores del interpolador a trozos de Hermite y el spline juntos')
hold on
plot(malla, errorSpline, 'color', 'r')
%Como era de esperar, la grafica roja, el error del spline, es mayor que el del
%polinomio de hermite a trozos.
%Es curioso observar como la graficas son iguales en forma, solo que el error del spline
%esta como amplificado.

%Apartado 5, calculamos la segunda derivada a trozos.
for i=1:(length(nodos) - 1)
  nodosRep(1) = nodos(i);
  nodosRep(2) = nodos(i);
  nodosRep(3) = nodos(i+1);
  nodosRep(4) = nodos(i+1);
  coef = polyinterpolador(coefNewton(i,:), nodosRep);
  der = polyder(coef);
  der2(i,:) = polyder(der);
endfor

%Dibujamos las segundas derivadas (cada trozo)
figure(5)
for i=1:(length(nodos) - 1)
  malla = linspace(nodos(i), nodos(i+1), 10);
  resultadoDer2 = polyval(der2(i, :), malla);
  plot(malla, resultadoDer2)
  hold on 
endfor
title('Segunda derivada (a trozos) de la interpolacion de hermite a trozos')
%Vemos como, efectivamente, la segunda derivada calculada de esta forma no es 
%continua, hay saltos entre cada intervalo. Cada intervalo es una recta, pues 
%la segunda derivada de cada polinomio en cada intervalo (grado 3) es un polinomio
%de grado 1. Se puede modificar el numero de nodos al principio del codigo en el
%linspace para ver como varia esta segunda derivada...



rmpath('../Biblioteca')