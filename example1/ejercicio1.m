%Ejercicio 1
clear all;

%Se solicitan los datos para la primera funcion
func=' f(x) : '
validate=1
[f, f_inf, f_sup, itmax ]=getData( func, validate )
%Se solicitan los datos para la segunda funcion
func=' g(x) : '
validate=0
g=getData( func, validate )

y=biseccion2(f,g, f_inf, f_sup, itmax )

function [f, f_inf, f_sup, itmax ] = getData( func, validate )
    %Variables genericas de texto
    ingrese='Ingrese '
    lim_inf= ' limite inferior de '
    lim_sup= ' limite superior de '
    itmax_txt= ' itmax : '

    %Texto para solicitar engresar la funcion 
    texto_func=strcat(ingrese, func)

    f_str=input(texto_func)
    f=inline(f_str, 'x')

    %Valida que solo pida los limites una sola vez
    if validate == 1
        %Texto para solicitar el limite inferior
        texto_inf=strcat(ingrese , lim_inf)
        texto_inf=strcat(texto_inf , func)

        %Texto para solicitar el limite superior
        texto_sup=strcat(ingrese , lim_sup)
        texto_sup=strcat(texto_sup , func)
        
        %Texto para solicitar cantidad de iteraciones
        texto_itmax=strcat(ingrese, itmax_txt)
        
        %Se asigna la entrada por teclado del limite inferior
        f_inf=input(texto_inf)
        %Se asigna la entrada por teclado del limite superior
        f_sup=input(texto_sup)
        %Se asigna la entrada por teclado del itmax
        itmax=input(texto_itmax)
        
    else
        %Se asigna 0 dado que no se utiliza
        f_inf=0
        f_sup=0
    end
end


function y = biseccion2( f, g, a , b, itmax )
    %Params:
    % f corresponde a la funcion f(x)
    % g corresponde a la funcion g(x)
    % a corresponde al limite inferior
    % b corresponde al limite superior
    % itmax corresponde a la cantidad de iteraciones
    
    c = b - (f(b)*(a-b))/(f(a)-f(b));
    if (g(a)*g(b)) <= 0
        while ((g(c)~=0) && (abs(b-a)>itmax))
            if (g(c)*g(b)) > 0
                a=c
            else
                b=c
            end
            c=(a+b)/2
        end 
    end
    y=c
end
