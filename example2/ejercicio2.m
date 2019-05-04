clear;
%Gravedad
g = 9.8;
%Llamada a la funcion que solicita los parametros de entrada.
[ dens_liq, dens_par, mu, dp ] = getData();

% Factor de friccion
cd = ( 4 * g * dp * ( dens_par - dens_liq ) ) / ( 3 * dens_liq );

%Reynolds y cd 1era funcion 
cd1_str='24/x';
re1_min=-inf;
re1_max=0.1;
[ cd1_min, cd1_max ] = getRangeCd( cd1_str, re1_min, re1_max );

%Reynolds y cd 2da funcion
cd2_str='(24/x)*(1+0.14*x^(0.7))';
re2_min=0.1;
re2_max=1000;
[ cd2_min, cd2_max ] = getRangeCd( cd2_str, re2_min, re2_max );

%Reynolds y cd 3era funcion
re3_min=1000;
re3_max=350000;
cd3_min=0.44;
cd3_max=0.44;

%Reynolds y cd 4ta funcion
cd4_str='-19-(80000/x)';
re4_min=350000;
re4_max=inf;
[ cd4_min, cd4_max ] = getRangeCd( cd4_str, re4_min, re4_max );


%Calcular el numero de reynolds
re = getReynoldsNumber( cd, cd1_min, cd1_max, cd2_min, cd2_max, cd3_min, cd3_max, cd4_min, cd4_max, re1_min, re1_max, re2_min, re2_max, re3_min, re3_max, re4_min, re4_max );

%Calcular el vt
vt = getVt( re, mu, dens_liq, dp );

fprintf('-----------\nResultados\n-----------\n')
fprintf( 'Numero de Reynolds : %11.7f \n', re )
fprintf( 'Coeficiente de friccion : %11.7f \n', cd )
fprintf( 'Velocidad de sedimentacion : %11.7f \n', vt )


%Obtener la iteracion del valor de vt
metodoFalsaPosicion( mu, dens_liq, dp );


%Funcion para obtener las cotas inferiores y superiores.
function [ min , max ] = getRangeCd( f_str, x_min, x_max )
    f=inline(f_str, 'x');
    min=f(x_min);
    max=f(x_max);
    if ( max < min )
        aux=max;
        max=min;
        min=aux;
    end
end


function vt = getVt( re, mu, dens_liq, dp )
    vt = (re * mu )/( dens_liq * dp ); 
end

function reynolds_value = getReynoldsNumber( cd, cd1_min, cd1_max, cd2_min, cd2_max, cd3_min, cd3_max, cd4_min, cd4_max, re1_min, re1_max, re2_min, re2_max, re3_min, re3_max, re4_min, re4_max )
    syms y x;
    if ( cd >= cd1_min ) && ( cd <= cd1_max )
        eq = y == ( 24 / x );
    elseif ( cd >= cd2_min ) && ( cd <= cd2_max )
        eq = y == (24/x)*(1+0.14*x^(0.7));
    elseif ( cd >= cd3_min ) && ( cd <= cd3_max )
        eq = y == 0.44;
    elseif ( cd >= cd4_min ) && ( cd <= cd4_max )
        eq = y == -19 -(80000/x);
    end
    reynolds_value=getInverse( eq, cd );   
end

function rv = getInverse( eq, cd )
    %Representacion de los simbolos para la ecuacion
    syms y x;
    %Obtiene la funcion inversa de la ecuacion
    inv_eq=solve( eq, x);
    inverse_function=inline(inv_eq);
    %Se evalua la ecuacion de numero de reynolds a partir del valor de cd
    rv=inverse_function(cd);
end


function [ dens_liq, dens_par, mu, dp ] = getData( )
    %Variables genericas de texto
    ingrese='Ingrese ';
    txt_dens_liq= ' densidad del liquido : ';
    txt_dens_par= ' densidad de la particula : ';
    txt_mu= ' viscosidad del liquido : ';
    txt_dp= ' diametro de la particula : ';
    
    %Texto para solicitar ingresar la densidad del liquido
    texto_dens_liq=strcat(ingrese, txt_dens_liq);
    
    %Texto para solicitar ingresar la densidad de la particula
    texto_dens_par=strcat(ingrese, txt_dens_par);
    
    %Texto para solicitar ingresar la viscosidad del liquido
    texto_mu=strcat(ingrese, txt_mu);
    
    %Texto para solicitar ingresar el diametro de la particula
    texto_dp=strcat(ingrese, txt_dp);
    
    %Se asigna la entrada por teclado de la densidad del liquido
    dens_liq=input(texto_dens_liq);
    
    %Se asigna la entrada por teclado de la densidad del liquido
    dens_par=input(texto_dens_par);
    
    %Se asigna la entrada por teclado de la viscosidad del liquido
    mu=input(texto_mu);
    
    %Se asigna la entrada por teclado del diametro de la particula
    dp=input(texto_dp);
    
end 


function y = metodoFalsaPosicion( mu, dens_liq, dp  )
    %Fx=input('Ingrese la funcion: ','s');
    syms x
    Fx=(mu*x)/(dens_liq*dp);
    a=input('Ingrese a : ');
    c=input('Ingrese c : ');
    e=input('Ingrese el error : ');
  
    x=a;
    Fa=eval(Fx);
    x=c;
    Fc=eval(Fx);
    fprintf('\n %6s %7s %8s %10s %8s %8s %8s \n ','A','B','C','F(a)','F(b)','F(c)','|c-a|');
    while abs(c-a)>e
        b=(c*Fa-a*Fc)/(Fa-Fc);
        x=b;
        Fb=eval(Fx);
        fprintf('\n %8.4f %8.4f %8.4f %8.4f %8.4f %8.4f %8.4f \n',a,b,c,Fa,Fb,Fc,abs(c-a));
        if abs(Fc)<e
            break;
          else    
          if Fa*Fb<=0
              c=b;
              Fc=Fb;
              else
              a=b;
              Fa=Fb;
          end
       end
              end
              fprintf('\nEl resultado sera %.4f',b);
              ezplot(Fx);%graficamos la funcion
              grid on;
    y=1;
end

