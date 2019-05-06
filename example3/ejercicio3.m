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

lim_inf=-1;
lim_sup=1;
tolerancia=0.00001;
[ interes, valor_total ] = getInteres( ac, fx1, lim_inf, lim_sup, tolerancia );

function [ interes, valor_total ] = getInteres( ac, f, lim_inf, lim_sup, tolerancia )
    max_iter=100000;
    i=1;
    interes=[];
    valor_total=[];
    
    while i <= max_iter
        ac_min = f(lim_inf);
        ac_max = f(lim_sup);
        
        if abs( ac - ac_min ) <= tolerancia
            interes(i) = lim_inf;
            valor_total(i) = ac_min;
            return
        else
            if ( ac_min > ac )
                lim_inf=lim_inf - tolerancia;
            else
                lim_inf=lim_inf + tolerancia;
            end
        end
        
        if abs( ac - ac_max ) <= tolerancia
            interes(i) = lim_sup;
            valor_total(i) = ac_max;
            return
        else
            if ( ac_max > ac )
                lim_sup=lim_sup - tolerancia;
            else
                lim_sup=lim_sup + tolerancia;
            end
        end
        fprintf("%d \t %2f \t %2f \t %2f \t %2f \t %2f \n", i, ac, lim_inf, ac_min, lim_sup, ac_max );
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