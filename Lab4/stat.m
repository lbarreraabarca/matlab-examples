clear;
clc;

interpolar = getData();
[ d1_x, d1_y, d2_x, d2_y, d3_x, d3_y, d4_x, d4_y ] = getStadistics();

%Experimento 1
[x1_out, y1_out] = diferencias_interpolares_newton( d1_x, d1_y, interpolar );
titulo='Experimento 1 - Ganaderia Sudamerica';
output = imprimirResultados( x1_out, y1_out, titulo );

%Experimento 2
[x2_out, y2_out] = diferencias_interpolares_newton( d2_x, d2_y, interpolar );
titulo='Experimento 2 - Habitantes en Chile';
output = imprimirResultados( x2_out, y2_out, titulo );

%Experimento 3
[x3_out, y3_out] = diferencias_interpolares_newton( d3_x, d3_y, interpolar );
titulo='Experimento 3 - Indices de precio al consumidor';
output = imprimirResultados( x3_out, y3_out, titulo );

%Experimento 4
[x4_out, y4_out] = diferencias_interpolares_newton( d4_x, d4_y, interpolar );
titulo='Experimento 4 - Gasto publico en Chile';
output = imprimirResultados( x4_out, y4_out, titulo );


function output = imprimirResultados( x_v, y_v, titulo )
    [m1, n1] = size(x_v);
    fprintf('%s\n', titulo);
    for i=1:n1
        fprintf('%11.2f %11.2f \n', x_v(i), y_v(i));
    end
    fprintf('-----------\n');
    output=-1;
end

%Interpolacion de newton
function [x_out, y_out]  = diferencias_interpolares_newton( data_x, data_y, data_interpolar )
    [m,n] = size(data_x);
    n=n-1;
    %n=input('ingrese el grado del polinomio, n=');
    for i=1:n+1
        X(i)=data_x(i);
        Y(i)=data_y(i);
    end
    DD=zeros(n+1);
    DD(:,1)=Y;
    for k=2:n+1
        for J=k:n+1
            DD(J,k)=[DD(J,k-1)-DD(J-1,k-1)]/[X(J)-X(J-k+1)];
        end
    end
    syms x;
    polnew=DD(1,1);
    P=1;
    for i=1:n
        P=P*(x-X(i));
        polnew=polnew+P*DD(i+1,i+1);
    end
    polnew=expand(polnew);
    %pretty(polnew);
    x_out = [];
    y_out = [];
    [m1, n1]=size(data_interpolar);
    for i=1:n1
        x=data_interpolar(i);
        x_out(i) = x;
        vi=eval(polnew);
        y_out(i) = vi; 
    end
     
end


function [ d1_x, d1_y, d2_x, d2_y, d3_x, d3_y, d4_x, d4_y ] = getStadistics( )
    %Ganadera 
    d1_x = [ 2012 2013 2014 2015 2016 2017 ];
    d1_y = [  537618675 537362766 538296218 541002179 543699095 541786762 ];

    d2_x = [ 2012 2013 2014 2015 2016 2017 ];
    d2_y = [ 17309746 17462982 17613798 17762681 17909754 18054726 ];
    
    d3_x = [ 2012 2013 2014 2015 2016 2017 ];
    d3_y = [ 315.900080193 399.527351517 468.906722464 500.493851337 620.896597978 634.054773345 ];

    d4_x = [ 2012 2013 2014 2015 2016 2017 ];
    d4_y = [ 30050204 31845155 35343503 39747891 42860636 45717502 ];

end


function [ interpolar ] = getData( )
    interpolar=[];
    %Variables genericas de texto
    ingrese='Ingrese ';
    txt_1 = ' cantidad de datos a interpolar : ';
    
    %Texto para solicitar ingresar k3
    texto_1=strcat(ingrese, txt_1);
        
    txt_2='Ingrese anio ';
    %Se asigna la entrada por teclado del k3
    n=input(texto_1);
    cont=1;
    while cont <= n
        tmp=input('Ingrese dato a interpolar : ');
        interpolar(cont)=tmp;
        cont = cont+1;
    end
end 


