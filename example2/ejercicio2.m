clear;

%Gravedad
g = 9.8
%Llamada a la funcion que solicita los parametros de entrada.
% [ dens_liq, dens_par, mu, dp ] = getData()

% Factor de friccion
% cd = ( 4 * g * dp * ( dens_par - dens_liq ) ) / ( 3 * dens_liq )

output = getReynoldsNumber( ) 

function output = getReynoldsNumber( )
    
    syms y x
    %1era ecuacion funcion por rama
    eq1 = y == ( 24 / x )
    inv_eq1 = solve( eq1, x )
    
    %2da ecuacion funcion por rama
    eq2 = y == (24/x)*(1 + 0.14*x^(0.7))
    inv_eq2 = solve( eq2, x )
    
end


function [ dens_liq, dens_par, mu, dp ] = getData( )
    %Variables genericas de texto
    ingrese='Ingrese '
    txt_dens_liq= ' densidad del liquido : '
    txt_dens_par= ' densidad de la particula : '
    txt_mu= ' viscosidad del liquido : '
    txt_dp= ' diametro de la particula : '
    
    %Texto para solicitar ingresar la densidad del liquido
    texto_dens_liq=strcat(ingrese, txt_dens_liq)
    
    %Texto para solicitar ingresar la densidad de la particula
    texto_dens_par=strcat(ingrese, txt_dens_par)
    
    %Texto para solicitar ingresar la viscosidad del liquido
    texto_mu=strcat(ingrese, txt_mu)
    
    %Texto para solicitar ingresar el diametro de la particula
    texto_dp=strcat(ingrese, txt_dp)
    
    %Se asigna la entrada por teclado de la densidad del liquido
    dens_liq=input(texto_dens_liq)
    
    %Se asigna la entrada por teclado de la densidad del liquido
    dens_par=input(texto_dens_par)
    
    %Se asigna la entrada por teclado de la viscosidad del liquido
    mu=input(texto_mu)
    
    %Se asigna la entrada por teclado del diametro de la particula
    dp=input(texto_dp)
    
end 

