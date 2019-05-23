% Se limpiza la memoria de las variables
clc;
clear;

%Llamada a la funcion getData
[ k1, k2, k3 ] = getData( );
%Llamada al metodo newton raphson
[it, oA, oB, oC, ox1, ox2, ox3 ] = methodNewtonRaphson( k1, k2, k3 );
%Graficar salida
a = graficarResultados( it, oA, oB, oC, ox1, ox2, ox3 );

function x = graficarResultados( it, oA, oB, oC, ox1, ox2, ox3 )
    subplot(3,2,1)
    plot(it,oA)
    title('A')

    subplot(3,2,2)
    plot(it,oB)
    title('B')

    subplot(3,2,3)
    plot(it,oC)
    title('C')

    subplot(3,2,4)
    plot(it,ox1)
    title('x1')
    
    subplot(3,2,5)
    plot(it,ox2)
    title('x2')
    
    subplot(3,2,6)
    plot(it,ox3)
    title('x3')
    x=0;
end


function [it, oA, oB, oC, ox1, ox2, ox3 ] = methodNewtonRaphson( k1, k2, k3 )
    %Inicalizar vectores de salida
    it =[];
    oA=[];
    oB=[];
    oC=[];
    ox1=[];
    ox2=[];
    ox3=[];
    %Condiciones iniciales
    X0 = [1; 1; 1 ];
    maxIter = 500;
    tolX = 1e-6;
    %Computacion usando Newton Raphson 
    X=X0;
    Xold=X0;

    for i = 1:maxIter
        [ f, j, outA, outB, outC, x1, x2, x3 ] = getSistemaEcuaciones( k1, k2, k3, X );
        X = X - inv(j)*f;
        
        %fprintf('%2d %11.4f %11.4f %11.4f %11.4f %11.4f %11.4f \n',i, outA, outB, outC, x1, x2, x3 );
        it(i) =i;
        oA(i)=outA;
        oB(i)=outB;
        oC(i)=outC;
        ox1(i)=x1;
        ox2(i)=x2;
        ox3(i)=x3;
        
        %Se obtiene el error
        error(:,i) = abs(X-Xold);
        Xold = X;
        if (error(:,i) < tolX)
            break;
        end
    end
    
end


function [ f, j, outA, outB, outC, x1, x2, x3 ] = getSistemaEcuaciones( k1, k2, k3, X )
    %Definir las variables
    x = X(1);
    y = X(2);
    z = X(3);
    
    %Ecuaciones principales
    A = 2*x + y - 2*z;
    B = 1 - 2*x - y;
    C = 1 + x + y - z;  
    
    %Se define el sistema de ecuaciones
    f(1,1) = k1*B*B*C -( x*A*A );
    f(2,1) = k2*B*C -( y*A );
    f(3,1) = k3*A*A - ( z*C );
    
    % Se define el jacobiano
    syms x y z;
    AA=2*x + y - 2*z;
    BB = 1 - 2 * x - y;
    CC = 1 + x + y - z;
    %Sistema a evaluar
    sistema = [ k1*BB*BB*CC - ( x*AA*AA )
                , k2*BB*CC - ( y*AA )
                , k3*AA*AA - ( z*CC ) ];
    %Variables del sistema
    variables = [ x, y, z];
    %Se calcula el jacobiano
    jacobiano = jacobian( sistema, variables );
    
    %Definir las variables
    x = X(1);
    y = X(2);
    z = X(3);
    
    j = subs(jacobiano);
    outA = A;
    outB = B;
    outC = C;
    x1 = X(1);
    x2 = X(2);
    x3 = X(3);     
end


function [ k1, k2, k3 ] = getData( )
    %Variables genericas de texto
    ingrese='Ingrese ';
    txt_k1= ' K1 : ';
    txt_k2= ' K2 : ';
    txt_k3= ' K3 : ';
    
    %Texto para solicitar ingresar k1
    texto_k1=strcat(ingrese, txt_k1);
    
    %Texto para solicitar ingresar k2
    texto_k2=strcat(ingrese, txt_k2);
    
    %Texto para solicitar ingresar k3
    texto_k3=strcat(ingrese, txt_k3);
        
    %Se asigna la entrada por teclado del k1
    k1=input(texto_k1);
    
    %Se asigna la entrada por teclado del k2
    k2=input(texto_k2);
    
    %Se asigna la entrada por teclado del k3
    k3=input(texto_k3);
        
end 