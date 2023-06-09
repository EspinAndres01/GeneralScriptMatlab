function Fgraph(varargin)
% Esta función genera gráficos con diferentes opciones.Para utilizarla por
% consola se debe llamar como Fgraph(var independiente "x",var dependiente "f",tipo
% de grafico"p",tendencia de la cuadricula"t",tipo de escala "a") **
% Fgraph(x,f,p,t,a)
tic; %Inicio del tiempo de ejecucion
% Verifica que el número de argumentos de entrada sea entre 2 y 5. Si no es así, genera un error.
narginchk(2,5);

% Asigna las variables independientes (x) y dependientes (f) a partir de los argumentos de entrada.
x = varargin{1};
f = varargin{2};

% Inicializa las variables de tipo de gráfico (p), tipo de gráfico de tendencia (t) y tipo de escala (a) a valores vacíos, es decir estan inicializados como default.
p = [];
t = [];
a = [];

% Argumento del puesto 3, lo asigna a la variable de tipo de gráfico (p).
if nargin >= 3
    p = varargin{3};
end

% Argumento del puesto 4, lo asigna a la variable de tipo de gráfico de tendencia (t).
if nargin >= 4
    t = varargin{4};
end

% Argumento del puesto 5, lo asigna a la variable de tipo de escala (a).
if nargin == 5
    a = varargin{5};
end

% Validacion para p, decide si crear una nueva figura y un subgráfico, o solo una nueva figura.
if p == 1
    figure;
    subplot(length(f),1,1);
else
    figure;
end

% Elige la función de trazado(cuadricula) según el valor de 't'.
if isempty(t) || t == 0
    plotFunc = @plot;
elseif t == 1
    plotFunc = @stem;
elseif t == 2
    plotFunc = @semilogx;
elseif t == 3
    plotFunc = @semilogy;
elseif t == 4
    plotFunc = @loglog;
else
    error('El valor de "t" no es válido');
end

% Elige el modo de los ejes según el valor de 'a'.
if isempty(a) || a == 0
    axisFunc = 'normal';
elseif a == 1
    axisFunc = 'equal';
elseif a == 2
    axisFunc = 'square';
else
    error('El valor de "a" no es válido');
end

% Se puede modificar la variable fila y columna para el formato de
% presentacion de lo suplot
% dimension.
fila=3;
columna=2;
% Para cada elemento en 'f', crea un gráfico utilizando la función seleccionada previamente.
for i = 1:length(f) %en Matlab un array no empiza desde cero, siempre empieza contando desde el 1.
    if p == 1  % Si p es 1 se grafica n figuras en una misma ventana
        subplot(fila,columna,i);
    else
        figure; %Si p esta vacia se grafica n figuras ceparadas
    end
    plotFunc(varargin{1}{i}, f{i}); % Grafica los datos. 'plotFunc' es una función de trazado que 
                                     %se seleccionó anteriormente considerando el valor de 't'. 
                                     %Los datos para el eje X provienen delcontador del primer argumento,para el eje Y provienen del contador de elemento de 'f'.
    title('Título del gráfico'); %**REVISAR**
    xlabel('Eje X'); %**REVISAR**
    ylabel('Eje Y'); %**REVISAR**
    grid on; %Cuadricula activa
    axis(axisFunc); %tipo de ejes de acuerdo 'a'
end
tElapsed = toc;%Fin del tiempo de ejecucion
disp(['El tiempo de ejecución fue: ', num2str(tElapsed), ' segundos.']);
end
