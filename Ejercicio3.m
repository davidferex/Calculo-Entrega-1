
%Apartados 3 y 4 del ejercicio 3.
%Experimentamos con la funcion f(x) = sen(x)
clc
clear all
close all
addpath('../Biblioteca')
output_precision(16)

f = @(x) sin(x);

%Apartado 3, vemos la diferencia entre polinomio de Lagrange y de Newton 
%con 3, 5 y 15 nodos.
numero = [3,5,15]
titulos = {'Diferencia entre pol. Lagrange y de Newton con 3 nodos',
'Diferencia entre pol. Lagrange y de Newton con 5 nodos',
'Diferencia entre pol. Lagrange y de Newton con 15 nodos'};

for i=1:3
  nodos = linspace(0, 2*pi, numero(i));
  ordenadas = f(nodos);

  factores = factLagrange(nodos);
  coef = coefPolLagrange(factores, nodos, ordenadas);

  newton = interpolNewton(nodos, ordenadas);

  malla = linspace(0, 2*pi, 100);
  resultado = polyval(coef, malla);
  resultadoNewton = polyinterpolador_eval(newton, nodos, malla);

  %Dibujo la diferencia entre ambos polinomios.
  diferencia = resultado - resultadoNewton;
  figure(i)
  plot(malla, diferencia)
  title(titulos(i))
  
  %Obtengo el polinomio de Newton en forma estandar para compararlo.
  coef2 = polyinterpolador(newton, nodos);
  
  printf("La diferencia de coeficientes con %d nodos es:\n", numero(i))
  difCoef = coef - coef2
endfor
%Vemos que las diferencias son pequeñas, pero que van aumentando conforme
%aumenta el numero de nodos.
%Un aspecto que quiero comentar es que he visto que si hago algunas operaciones
%juntas (llamar a factLagrange dentro de los argumentos de coefPolLagrange p.e)
%en lugar de hacerla, guardarla en una variable y luego usar el dato, o
%si en vez de evaluar ambos polinomios, evaluo el polinomio de la resta de
%coeficientes, se obtienen graficas diferentes. El orden de los numeros es el 
%mismo, pero si que se obtienen "formas" diferentes en las graficas. Entiendo que
%es por usar numeros tan bajos, hacer restas, el numero de operaciones o incluso
%el orden o algo puede afectar bastante.

%Ahora el apartado 4, con numero grande de nodos (lo hago con 50, p.e).
%Hacemos lo mismo que antes:
nodos = linspace(0, 2*pi, 50);
ordenadas = f(nodos);

factores = factLagrange(nodos);
coef = coefPolLagrange(factores, nodos, ordenadas);

newton = interpolNewton(nodos, ordenadas);

malla = linspace(0, 2*pi, 100);
resultado = polyval(coef, malla);
resultadoNewton = polyinterpolador_eval(newton, nodos, malla);

diferencia = resultado - resultadoNewton;
figure(4)
plot(malla, diferencia)
  
coef2 = polyinterpolador(newton, nodos);

display("La diferencia con 50 nodos es:\n")
difCoef = coef - coef2
%Vemos que ahora la diferencia es enorme, el polinomio de Lagrange es mucho más grande.
%yo creo que el problema viene al poner muchos nodos, por lo que los nodos 
%estan mas cerca entre si. 
%Hacemos restas entre numeros cercanos y, además, esos números pequeños 
%(las restas) se multiplican por más números pequeños.
%Y encima luego divides por eso. Creo que aquí se provoca que salga tan enorme la
%diferencia.

rmpath('../Biblioteca')