clc
clear all
close all
addpath('../Biblioteca')
output_precision(16)

f = @(x) sin(x);
d = 4;
m = 15;

nodos = linspace(0, pi, m*d + 1);
ordenadas = f(nodos);
coefTrozos = interpolTrozos(nodos, m, d, ordenadas);
malla = linspace(0, pi, 200);
valor = trozosEval(coefTrozos, nodos, d, m, malla);
error = abs(valor - sin(malla));


nodos = linspace(0, pi, 15);
ordenadas = f(nodos);
coefNewton = interpolNewton(nodos, ordenadas);
valor2 = polyinterpolador_eval(coefNewton, nodos, malla);
error2 = abs(valor2 - sin(malla));


plot(malla, valor)
hold on
plot(malla, valor2, 'color', 'r')
hold on 
plot(malla, sin(malla), 'color', 'g')


f = @(x) 1./(1 + x.^2);
nodos = linspace(-5, 5, m*d+1);
ordenadas = f(nodos);
coefTrozos = interpolTrozos(nodos, m, d, ordenadas);
malla = linspace(-5, 5, 200);
valor = trozosEval(coefTrozos, nodos, d, m, malla);
error = abs(valor - f(malla));
i1 = 1;
i2 = d+1;
for i=1:m
  coef(i, :) = polyinterpolador(coefTrozos(i,:), nodos(i1:i2));
  der(i,:) = polyder(coef(i,:));
  i1 = i2;
  i2 = i2 + d;
endfor

figure(3)
i1 = 1;
i2 = d +1;
for i=1:m
  malla = linspace(nodos(i1), nodos(i2), 20);
  plot(malla, polyval(der(i,:), malla));
  hold on
  i1 = i2;
  i2 = i2 + d;
endfor


nodos = linspace(-5, 5, 20);
ordenadas = f(nodos);
coefNewton = interpolNewton(nodos, ordenadas);
malla = linspace(-5, 5, 200);
valor2 = polyinterpolador_eval(coefNewton, nodos, malla);
error2 = abs(valor2 - f(malla));

figure(2)
plot(malla, valor)
hold on
plot(malla, valor2, 'color', 'r')
hold on 
plot(malla, f(malla), 'color', 'g')



rmpath('../Biblioteca')