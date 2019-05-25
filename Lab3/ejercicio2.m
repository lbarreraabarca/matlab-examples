% Se limpiza la memoria de las variables
clc;
clear;

%Llamada a la funcion getData
[ k1, k2, k3, p1, p3, p4 ] = getData( );
%Llamada al metodo newton raphson
[ c_iter, c_Q1, c_Q2, c_Q3, c_p2, Q1, Q2, Q3, p2, error ] = methodNewtonRaphson( k1, k2, k3, p1, p3, p4 );

fprintf('Resultados\n');
fprintf('Q1    = %11.8f\n', Q1 );
fprintf('Q2    = %11.8f\n', Q2 );
fprintf('Q3    = %11.8f\n', Q3 );
fprintf('p2    = %11.8f\n', p2 );
fprintf('Error = %11.8f\n', error );

%Graficar salida
a = graficarResultados( c_iter, c_Q1, c_Q2, c_Q3, c_p2);

function x = graficarResultados( it, oA, oB, oC, ox1 )
    subplot(3,2,1)
    plot(it,oA)
    title('Q1')

    subplot(3,2,2)
    plot(it,oB)
    title('Q2')

    subplot(3,2,3)
    plot(it,oC)
    title('Q3')

    subplot(3,2,4)
    plot(it,ox1)
    title('p2')
    
    x=0;
end


function [ c_iter, c_Q1, c_Q2, c_Q3, c_p2, Q1, Q2, Q3, p2, error ] = methodNewtonRaphson( k1, k2, k3, p1, p3, p4 )
    %Inicalizar vectores de salida
    it =[];
    %Condiciones iniciales
    X0 = [1; 1; 1 ];
    maxIter = 1000000;
    tolX = 1e-6;
    %Computacion usando Newton Raphson 
    X=X0;
    [ c_iter, c_Q1, c_Q2, c_Q3, c_p2, Q1, Q2, Q3, p2, error ] = getSistemaEcuaciones( k1, k2, k3, p1, p3, p4, X, tolX, maxIter );
    
end


function [ c_iter, c_Q1, c_Q2, c_Q3, c_p2, Q1, Q2, Q3, p2, error ] = getSistemaEcuaciones( k1, k2, k3, p1, p3, p4, X, tolX, maxIter )
    
    %Definir las variables - condiciones iniciales
    p2 = X(1);
    menor_valor= inf;
    
    c_iter =[];
    c_Q1 = [];
    c_Q2 = [];
    c_Q3 = [];
    c_p2 = [];
    cont_iter = 1;
    for i = 1:maxIter 
        %Ecuaciones principales
        Q1 = ( p1 - p2 )/( k1 )^(1/1.75);
        Q2 = ( p2 - p3 )/( k2 )^(1/1.75);
        Q3 = ( p2 - p4 )/( k3 )^(1/1.75);
        
        dif = abs( Q2 + Q3 );
        dif2 = abs(Q1 - dif) ;
        
        if dif2 < menor_valor
            menor_valor = dif2;
            error = menor_valor;
            q1_f = Q1;
            q2_f = Q2;
            q3_f = Q3;
            p2_f = p2;
            
            if ( mod( i, 1000 ) == 0 )
                c_iter( cont_iter ) = cont_iter;
                c_Q1( cont_iter ) = Q1;
                c_Q2( cont_iter ) = Q2;
                c_Q3( cont_iter ) = Q3;
                c_p2( cont_iter ) = p2;
                cont_iter = cont_iter + 1;
            end
            
        end
        
        if ( dif2 <= tolX )
            break;
        else
            if ( Q1 > dif )
                veces = Q1 / dif;
                if ( veces > 1 )
                    p2 = p2 + veces;
                else
                    p2 = p2 + tolX;
                end
            else
                p2 = p2 - tolX;
            end
        end
    end 
    
    Q1 = q1_f;
    Q2 = q2_f;
    Q3 = q3_f;
	p2 = p2_f;
    
end


function [ k1, k2, k3, p1, p3, p4 ] = getData( )
    %Variables genericas de texto
    ingrese='Ingrese ';
    txt_k1= ' K1 : ';
    txt_k2= ' K2 : ';
    txt_k3= ' K3 : ';
    txt_p1= ' p1 : ';
    txt_p3= ' p3 : ';
    txt_p4= ' p4 : ';
    
    %Texto para solicitar ingresar k1
    texto_k1=strcat(ingrese, txt_k1);
    
    %Texto para solicitar ingresar k2
    texto_k2=strcat(ingrese, txt_k2);
    
    %Texto para solicitar ingresar k3
    texto_k3=strcat(ingrese, txt_k3);
    
    %Texto para solicitar ingresar p1
    texto_p1=strcat(ingrese, txt_p1);
    
    %Texto para solicitar ingresar p3
    texto_p3=strcat(ingrese, txt_p3);
    
    %Texto para solicitar ingresar p3
    texto_p4=strcat(ingrese, txt_p4);
    
    %Se asigna la entrada por teclado del k1
    k1=input(texto_k1);
    
    %Se asigna la entrada por teclado del k2
    k2=input(texto_k2);
    
    %Se asigna la entrada por teclado del k3
    k3=input(texto_k3);
    
    %Se asigna la entrada por teclado del p1
    p1=input(texto_p1);
    
    %Se asigna la entrada por teclado del p3
    p3=input(texto_p3);
    
    %Se asigna la entrada por teclado del p3
    p4=input(texto_p4);
    
end 