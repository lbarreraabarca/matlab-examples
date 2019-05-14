% Se limpiza la memoria de las variables
clear;

%Llamada a la funcion getData
[ k1, k2, k3 ] = getData( );

entrada=[1; 1; 1];
[ f, j ] = getSistemaEcuaciones( k1, k2, k3, entrada );


function [ f, j ] = getSistemaEcuaciones( k1, k2, k3, X )
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
    sistema = [ k1*BB*BB*CC - ( x*AA*AA )
                , k2*BB*CC - ( y*AA )
                , k3*AA*AA - ( z*CC ) ];
    variables = [ x, y, z];
    jacobiano = jacobian( sistema, variables );
    
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