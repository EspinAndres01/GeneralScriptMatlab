%Para el uso de este script es necesario pasarle 4 parametros:
%x=columnas
%r=filas
%e= [] ingresar datos manualmente, 1 importar tabla de excel
%n= tiene 4 opciones y default de formato de decimales.

%Una vez que se importan los datos o se los ingresa manualmente el script
%automaticamente genera la tabla con sus etiquetas C1... en la parte
%superior e imprime sus valores.

%Para usar los datos importados es importante colocar un nombre por defecto
%como Book1 o si no se puede cambiar el nombre dentro del script de acuerdo
%a como se llame la tabla que importo.

%%OJO: ES IMPORTATE IMPORTAR LOS DATOS DESDE MATLAB YA QUE ASI SE TIENE UN
%%MEJOR CONTROL DE LOS DATOS

function varargout = Ftable(varargin)
tic;%Inicia el tiempo de ejecucion
% Argumentos
narginchk(2,4);
x = varargin{1};
r = varargin{2};
e = [];
n = [];

if nargin >= 3
    e = varargin{3};
end

if nargin == 4
    n = varargin{4};
end

% tabla con 'x' columnas y 'r' filas, las etiquetas de la columna son C1, C2, ..., Cx
tbl = array2table(zeros(r-1,x),'VariableNames', strcat('C', cellstr(num2str((1:x)'))));

% Si 'e' es 1, importar datos  de Excel
if e == 1
    imported_data = readtable('Book2.xlsx');%Importa los datos de acuerdo al nombre del archivo
    if size(imported_data, 2) == x && size(imported_data, 1) == r-1
        tbl = imported_data;
    else
        error('Los datos importados no coinciden con las dimensiones de la tabla');
    end
elseif isempty(e) %Si e es igual a vacio se ingresa la tabla manualmente
    for i = 1:r-1
        for j = 1:x
            tbl{i, j} = input(['Ingrese el valor para la fila ' num2str(i) ', columna ' num2str(j) ': ']);
        end
    end
end

% formato 'n' afecta a los decimales
if n == 1
    format bank;
elseif n == 2
    format long;
elseif n == 3
    format short e;
elseif n == 4
    format rat;
else
    format short;  % Formato por defecto
end
% Mostrar la tabla
disp(tbl);
% Salidas de la tabla
if nargout == 1
    varargout{1} = tbl;
end
tElapsed = toc;
disp(['El tiempo de ejecución fue: ', num2str(tElapsed), ' segundos.']);
end
