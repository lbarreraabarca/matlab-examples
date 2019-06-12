clc;
clear;

[ opcion ] = getData( );
[ f,a,b ] = getFuncion( );
[ trapecio ] = getTrapecio( f, a, b );
[ simpson1 ] = getSimpson1( f, a, b );
[ simpson3 ] = getSimpson3( f, a, b );

[ o ] = eleccion( f,a,b, trapecio, simpson1, simpson3, opcion );

function o = eleccion( f,a,b, trapecio, simpson1, simpson3, opcion )

    if opcion == 1
        out = graficar( f,a,b, trapecio );
    elseif opcion == 2
        out = graficar( f,a,b, simpson1 );
    elseif opcion == 3
        out = graficar( f,a,b, simpson3 );
    else
        out = graficar( f,a,b, trapecio );
        out = graficar( f,a,b, simpson1 );
        out = graficar( f,a,b, simpson3 );
    end 
    o=1;
end

function out = graficar( f,a,b, valor )
    
    f0 = f(0);
    x_array = [ a b ];
    y_array = [ f0 valor ];
    
    fprintf( "Resultado : %11.4f \n", valor );
    
    area( x_array, y_array );
    out=0;
end

function [ f,a,b ] = getFuncion( )
    
    %Constantes del ejercicio
    n=5;
    r=0.05;
    %Limites de la integral
    a=0;
    b=n;

    %funcion
    syms x;
    fx=10000 + 375*x + exp(-r*x);
    
    %Se integra la funcion
    fx_int=int(fx);
    
    %Se transoforma  a una funcion que se puede evaluar
    f=inline(fx_int);
end

function [ I ] = getTrapecio( f, a, b )
    %Trapecio
    I = ( ( b-a )/2 )*( f(a)+ f(b)); 
end

function [ I ] = getSimpson1( f, a, b )
    %Simpson 1/3
    h_2 = (b-a)/2;
    x_2_1 = a + h_2;
    I = (h_2/3)*(f(a)+4*f(x_2_1)+f(b)); 
end

function [ I ] = getSimpson3( f, a, b )
    %Simpson 3/8
    h_3 = (b-a)/3;
    x_3_1 = a + h_3;
    x_3_2 = a + 2*h_3;
    I = ((3*h_3)/8)*(f(a)+f(b)+3*(f(x_3_1)+f(x_3_2)));
end


function [ opcion ] = getData( )
    %Variables genericas de texto
    ingrese='Desea ver los resultados para : \n';
    txt_1 = '( 1 ) Metodo Trapecio \n ';
    
    %Texto para solicitar ingresar k3
    ingrese=strcat(ingrese, txt_1);
    txt_1 = '( 2 ) Metodo Simpson 1/3 \n ';
    
    ingrese=strcat(ingrese, txt_1);
    txt_1 = '( 3 ) Metodo Simpson 3/8 \n ';
    
    ingrese=strcat(ingrese, txt_1);
    txt_1 = '( 4 ) Todos \n ';
    
    ingrese=strcat(ingrese, txt_1);
    opcion=input(ingrese);

end 
