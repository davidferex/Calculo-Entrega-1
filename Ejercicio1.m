
%Apartados 3, 4 y 5 del ejercicio 1.
%Se harán pruebas y comparaciones con distintas funciones (Apartado 3). Lo que 
%pide el apartado 4 se hará al mismo tiempo, se mezclará con el apartado 3.
%He intentado ir metiendo pause en distintos puntos del codigo para que 
%no saliese todo de golpe, pero he visto que a veces genera comportamientos 
%raros con el programa, por lo menos en mi ordenador, por lo que he decidido no
%poner pauses. Recomiendo leer bien el codigo primero para tener claro que 
% se dibuja en cada grafica y demas.
clc
clear all
close all
addpath('../Biblioteca')
output_precision(16)

%Primer ejemplo de prueba
%Pruebo con m=15 y d=4, pero hay más opciones con m=5,10,15 y d=2,4.
%Simplemente dejo escrita esta prueba. Para los demás casos, basta con cambiar
%los valores de m y d...
f = @(x) sin(x);
d = 4;
m = 15;

%Interpolacion a trozos:
nodos = linspace(0, pi, m*d + 1);
ordenadas = f(nodos);
coefTrozos = interpolTrozos(nodos, m, d, ordenadas);
malla = linspace(0, pi, 200);
valor = trozosEval(coefTrozos, nodos, d, m, malla);
%Vemos la diferencia entre la interpolacion a trozos y el seno.
display('Error entre sin(x) y la interpolacion a trozos:')
error = abs(valor - sin(malla))

%Interpolacion "normal" en 15 nodos.
nodos = linspace(0, pi, 15);
ordenadas = f(nodos);
coefNewton = interpolNewton(nodos, ordenadas);
valor2 = polyinterpolador_eval(coefNewton, nodos, malla);
%Vemos la diferencia entre la interpolacion y el seno
display('Error entre sin(x) y la interpolacion de Newton:')
error2 = abs(valor2 - sin(malla))

%Dibujamos la funcion, el pol. interpol. a trozos, y el pol.interpol. "normal"
plot(malla, valor)
title('Sen(x), interpolacion de Newton e interpolacion a trozos juntos')
hold on
plot(malla, valor2, 'color', 'r')
hold on 
plot(malla, sin(malla), 'color', 'g')
%Vemos como no se pueden distinguir entre si las graficas. Por tanto, ambas 
%son buenas interpolaciones.


%Dibujamos la diferencia entra ambas interpolaciones, como pide el apartado 4.
diferencia = abs(valor - valor2);
figure(2)
plot(malla, diferencia)
title('Valor absoluto de la diferencia entre interpolacion de Newton y a trozos (sen(x))')
%Se observa como las diferencias son muy pequeñas. 
%Un dato interesante que he comprobado usando los errores entre las interpolaciones
%y la funcion seno (calculados pero se muestran por la ventana de comandos...)
%es que el error es menor con la interpolacion normal que a trozos. Esto seguramente 
%ocurra debido a que las derivadas del seno estan uniformemente acotadas, por lo que 
%sus polinomios interpoladores convergen uniformemente.

%Segundo ejemplo de prueba.
%Hago las pruebas con los mismos valores de m y d, aunque se pueden cambiar...
f = @(x) 1./(1 + x.^2);
nodos = linspace(-5, 5, m*d+1);
ordenadas = f(nodos);
coefTrozos = interpolTrozos(nodos, m, d, ordenadas);
malla = linspace(-5, 5, 200);
valor = trozosEval(coefTrozos, nodos, d, m, malla);
%Vemos la diferencia entre la interpolacion a trozos y la funcion
display('Error entre el ejemplo de Runge y la interpolacion a trozos:')
error = abs(valor - f(malla))

%Esto es para calcular la derivada, apartado 5.
i1 = 1;
i2 = d+1;
for i=1:m
  %Pasamos a la forma normal cada polinomio interpolador y lo derivamos.
  coef(i, :) = polyinterpolador(coefTrozos(i,:), nodos(i1:i2));
  der(i,:) = polyder(coef(i,:));
  i1 = i2;
  i2 = i2 + d;
endfor

figure(5)
i1 = 1;
i2 = d +1;
%Dibujamos la derivada dibujando cada trozo.
for i=1:m
  malla = linspace(nodos(i1), nodos(i2), 20);
  plot(malla, polyval(der(i,:), malla));
  hold on
  i1 = i2;
  i2 = i2 + d;
endfor
title('Derivada del ejemplo de runge interpolado por trozos')
%Fijandose bien y haciendo un poco de zoom si es necesario se comprueba que no 
%es continua, hay saltos entre algunos trozos.


%Lo siguiente vuelve a ser de los apartados 3 y 4
%Hacemos la interpolacion "normal" en 15 nodos.
nodos = linspace(-5, 5, 15);
ordenadas = f(nodos);
coefNewton = interpolNewton(nodos, ordenadas);
malla = linspace(-5, 5, 200);
valor2 = polyinterpolador_eval(coefNewton, nodos, malla);
%Vemos la diferencia entre la interpolacion normal y la funcion
display('Error entre el ejemplo de Runge y la interpolacion de Newton:')
error2 = abs(valor2 - f(malla))


%Dibujamos la funcion, el pol. interpol. a trozos, y el pol.interpol. "normal"
figure(3)
plot(malla, valor)
title('Ejemplo de Runge, interpolacion de Newton y a trozos juntos')
hold on
plot(malla, valor2, 'color', 'r')
hold on 
plot(malla, f(malla), 'color', 'g')
%Vemos como ahora la interpolacion de Newton se va en los extremos (fenómeno de Runge)
%pero que no se puede distinguir entre la interpolacion a trozos y la funcion.
%En este caso si mejora usar la interpolacion a trozos.


%Dibujamos la diferencia entra ambas interpolaciones, como pide el apartado 4.
diferencia = abs(valor - valor2);
figure(4)
plot(malla, diferencia)
title('Valor absoluto de la diferencia entre las dos interpolaciones para el ejemplo de Runge')


%ultimo ejemplo:
f = @(x) x.^(5/2);

nodos = linspace(0, 1, m*d+1);
%Queremos los nodos más cerca entre sí cerca del 0 que cerca del 1.
nodos = nodos.^2;
ordenadas = f(nodos);
coefTrozos = interpolTrozos(nodos, m, d, ordenadas);
malla = linspace(0, 1, 200);
valor = trozosEval(coefTrozos, nodos, d, m, malla);
%Vemos la diferencia entre la interpolacion a trozos y la funcion
display('Error entre x^5/2 y la interpolacion a trozos:')
error = abs(valor - f(malla))

%Hacemos la interpolacion "normal" en 15 nodos.
nodos = linspace(0, 1, 15);
nodos = nodos.^2;
ordenadas = f(nodos);
coefNewton = interpolNewton(nodos, ordenadas);
malla = linspace(0, 1, 200);
valor2 = polyinterpolador_eval(coefNewton, nodos, malla);
%Vemos la diferencia entre la interpolacion normal y la funcion
display('Error entre x^5/2 y la interpolacion de Newton:')
error2 = abs(valor2 - f(malla))

%Dibujamos la funcion, el pol. interpol. a trozos, y el pol.interpol. "normal"
figure(6)
plot(malla, valor)
title('x^5/2, interpolacion de Newton y a trozos juntos')
hold on
plot(malla, valor2, 'color', 'r')
hold on 
plot(malla, f(malla), 'color', 'g')
%Se observa como la interpolacion a trozos se comporta mucho mejor, sobre todo 
%cerca del 1, que la interpolacion usual de Newton. Tambien, en la ventana de 
%comandos, vemos que las diferencias con la funcion son mucho mayores con la 
%interpolacion de Newton.


%Dibujamos la diferencia entra ambas interpolaciones, como pide el apartado 4.
diferencia = abs(valor - valor2);
figure(7)
plot(malla, diferencia)
title('Valor absoluto de la diferencia entre las dos interpolaciones para x^5/2')


rmpath('../Biblioteca')