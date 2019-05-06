clear;
%Se obtienen los valores de entrada solictados 
[ ac, ah, pc, ph, n ] = getData( );

%Se instancia la funcion de la primera cuenta
syms x;
eq1=( pc / x )*( (1 + x )^n -1 );
fx1=inline(eq1);

%Se instancia la funcion de la primera cuenta
syms x;
eq2=( ph / x )*( 1 - (1 + x )^(-n) );
fx2=inline(eq2);

lim_inf=-5;
lim_sup=5;
tolerancia=0.00005;
[ interes_c, valor_c ] = getInteres( ac, fx1, lim_inf, lim_sup, tolerancia );
[ interes_h, valor_h ] = getInteres( ah, fx2, lim_inf, lim_sup, tolerancia );

fprintf( 'Ac real : %.4f \n', ac )
fprintf( 'Ac calculado : %.4f \n', valor_c )
fprintf( 'Interes Ic : %.4f \n', interes_c )

fprintf( 'Ah real : %.4f \n', ah )
fprintf( 'Ah calculado : %.4f \n', valor_h )
fprintf( 'Interes Ih : %.4f \n', interes_h )

function [ interes, valor ] = getInteres( ac, f, lim_inf, lim_sup, tolerancia )
    max_iter=200000;
    i=1;    
    while i <= max_iter
        ac_min = f(lim_inf);
        ac_max = f(lim_sup);
        
        if abs( ac - ac_min ) <= tolerancia
            interes = lim_inf;
            valor = ac_min;
            return
        else
            if ( ac_min > ac )
                lim_inf=lim_inf - tolerancia;
            else
                lim_inf=lim_inf + tolerancia;
            end
        end
        
        if abs( ac - ac_max ) <= tolerancia
            interes = lim_sup;
            valor = lim_sup;
            return
        else
            if ( ac_max > ac )
                lim_sup=lim_sup - tolerancia;
            else
                lim_sup=lim_sup + tolerancia;
            end
        end
        
        dif1=abs(ac -ac_max);
        dif2=abs(ac -ac_min);
        
        if (dif1 >= dif2 )
            interes = lim_inf;
            valor = ac_min;
        else
            interes = lim_sup;
            valor = ac_max;
        end
        %fprintf("%d \t %2f \t %2f \t %2f \t %2f \t %2f \n", i, ac, lim_inf, ac_min, lim_sup, ac_max );
        i = i+1;
    end
end

function [ ac, ah, pc, ph, n ] = getData( )
    %Variables genericas de texto
    ingrese='Ingrese ';
    txt_ac= ' Ac : ';
    txt_ah= ' Ah : ';
    txt_pc= ' Pc : ';
    txt_ph= ' Ph : ';
    txt_n = ' periodos : ';
    
    %Texto para solicitar ingresar ac
    texto_ac=strcat(ingrese, txt_ac);
    
    %Texto para solicitar ingresar ah
    texto_ah=strcat(ingrese, txt_ah);
    
    %Texto para solicitar ingresar el pc
    texto_pc=strcat(ingrese, txt_pc);
    
    %Texto para solicitar ingresar el ph
    texto_ph=strcat(ingrese, txt_ph);
    
    %Texto para solicitar ingresar la cantidad de periodos
    texto_n=strcat(ingrese, txt_n);
    
    %Se asigna la entrada por teclado del ac
    ac=input(texto_ac);
    
    %Se asigna la entrada por teclado del ah
    ah=input(texto_ah);
    
    %Se asigna la entrada por teclado del pc
    pc=input(texto_pc);
    
    %Se asigna la entrada por teclado del ph
    ph=input(texto_ph);
    
    %Se asigna la entrada por teclado cantidad de periodos
    n=input(texto_n);
    
end 