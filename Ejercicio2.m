clc
clear all
close all
addpath('../Biblioteca')
output_precision(16)

f = @(x) 1./(1 + x.^2);
derivada = @(x) (-2*x)./(1+x.^2).^2;
derivada2 = @(x) (-2 +6*x.^2)./(1+x.^2).^3;

nodos = linspace(-5,5, 20);
ordenadas = f(nodos);
derivadas = derivada(nodos);

coefNewton = hermiteTrozos(nodos, ordenadas, derivadas);
malla = linspace(-5, 5, 200);
resultado = hermiteTrozosEval(coefNewton, nodos, malla);
error = abs(resultado - f(malla));

plot(malla, f(malla))
hold on
plot(malla, resultado)

figure(2)
plot(malla, error)

figure(3)
[b,c,d] = splineSujeto(nodos, ordenadas, derivadas(1), derivadas(length(derivadas)));
resultadoSpline = splineEval(nodos, ordenadas, b,c,d, malla);
errorSpline = abs(resultadoSpline - f(malla));
plot(malla, resultado)
hold on 
plot(malla, resultadoSpline)

figure(4)
plot(malla, error);
hold on
plot(malla, errorSpline);


for i=1:(length(nodos) - 1)
  nodosRep(1) = nodos(i);
  nodosRep(2) = nodos(i);
  nodosRep(3) = nodos(i+1);
  nodosRep(4) = nodos(i+1);
  coef = polyinterpolador(coefNewton(i,:), nodosRep);
  der = polyder(coef);
  der2(i,:) = polyder(der);
endfor

figure(5)
for i=1:(length(nodos) - 1)
  malla = linspace(nodos(i), nodos(i+1), 10);
  resultadoDer2 = polyval(der2(i, :), malla);
  plot(malla, resultadoDer2)
  hold on 
endfor


rmpath('../Biblioteca')