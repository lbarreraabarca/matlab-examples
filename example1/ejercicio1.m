%Ejercicio 1
clear all;

%Se solicitan los datos para la primera funcion
func=' f(x) : ';
[f, f_inf, f_sup, itmax ]=getData( func );

[it, values ]=biseccion2(f, f_inf, f_sup, itmax );

plot(it, values )

function [f, f_inf, f_sup, itmax ] = getData( func )
    %Variables genericas de texto
    ingrese='Ingrese ';
    lim_inf= ' limite inferior de ';
    lim_sup= ' limite superior de ';
    itmax_txt= ' itmax : ';

    %Texto para solicitar ingresar la funcion 
    texto_func=strcat(ingrese, func);

    f=input(texto_func, 's');
    
    %Texto para solicitar el limite inferior
    texto_inf=strcat(ingrese , lim_inf);
    texto_inf=strcat(texto_inf , func);

    %Texto para solicitar el limite superior
    texto_sup=strcat(ingrese , lim_sup);
    texto_sup=strcat(texto_sup , func);
        
    %Texto para solicitar cantidad de iteraciones
    texto_itmax=strcat(ingrese, itmax_txt);
        
    %Se asigna la entrada por teclado del limite inferior
    f_inf=input(texto_inf);
    %Se asigna la entrada por teclado del limite superior
    f_sup=input(texto_sup);
    %Se asigna la entrada por teclado del itmax
    itmax=input(texto_itmax);
end

function [ it, values ] = biseccion2( f, a , b, error, itmax )
      disp('Metodo de biseccion');
      it=[];
      values=[];
      %Margen de tolerancia al error
      error=0.001;
      %Se carga la funcion f(x)
      f=inline(f);
      %Variable para controlar la cantidad de iteraciones
      i=1;
      ea(1)=100;
      %Se valida que existan raices 
      if f(a)*f(b) < 0
        %Xa evaluada en 1 corresponde al limite inferior
        xa(1)=a;
        %Xb evaluada en 1 corresponde al limite superior
        xb(1)=b;
        %Xr corresponde al punto medio de evaluar xa y xb en 1
        xr(1)=(xa(1)+xb(1))/2;
        %Impresiones de pantalla para el primer resultado
        fprintf('It \t r \n');
        fprintf('%2d %11.7f \n',i,xr(i));
        it(i)=i;
        values(i)=xr(i);
        %Bucle que permite iterar la solución
        while abs(ea(i)) >= error,
            if f(xa(i))*f(xr(i))<0
                xa(i+1)=xa(i);
                xb(i+1)=xr(i);
            end
            if f(xa(i))*f(xr(i))>0
                xa(i+1)=xr(i);
                xb(i+1)=xb(i);
            end
            %Xr corresponde al punto medio de evaluar xa y xb en i+1
            xr(i+1)=(xa(i+1)+xb(i+1))/2;
            ea(i+1)=abs((xr(i+1)-xr(i))/(xr(i+1))*100);
            %Impresion de pantalla de la ene-sima iteracion
            fprintf('%2d \t %11.7f \n',...
            i+1,xr(i+1));
            it(i+1)=i+1;
            values(i+1)=xr(i+1);
            % Se incremanta la variable iterante
            i=i+1;
        end
      else
        fprintf('NO EXISTE UNA RAIZ EN ESTE INTERVALO\n');
      end
end





