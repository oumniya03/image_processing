function varargout = TP1matlab(varargin)
% TP1MATLAB MATLAB code for TP1matlab.fig
%      TP1MATLAB, by itself, creates a new TP1MATLAB or raises the existing
%      singleton*.
%
%      H = TP1MATLAB returns the handle to a new TP1MATLAB or the handle to
%      the existing singleton*.
%
%      TP1MATLAB('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in TP1MATLAB.M with the given input arguments.
%
%      TP1MATLAB('Property','Value',...) creates a new TP1MATLAB or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before TP1matlab_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to TP1matlab_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help TP1matlab

% Last Modified by GUIDE v2.5 17-Feb-2025 21:42:32

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @TP1matlab_OpeningFcn, ...
                   'gui_OutputFcn',  @TP1matlab_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before TP1matlab is made visible.
function TP1matlab_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to TP1matlab (see VARARGIN)

% Choose default command line output for TP1matlab
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes TP1matlab wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = TP1matlab_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --------------------------------------------------------------------
function Untitled_1_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Transformation_Callback(hObject, eventdata, handles)
% hObject    handle to Transformation (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Untitled_3_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Untitled_4_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% --------------------------------------------------------------------
function Untitled_5_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Untitled_6_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------




% --------------------------------------------------------------------
function Laplacien_29_Callback(hObject, eventdata, handles)
% hObject    handle to Laplacien_29 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
image=handles.courant_data;
%image=imnoise(imageO,'salt & pepper', 0.05);
[n,m]=size(image);
image = double(image);
%b=image;
[n m]=size(image);
b=zeros(n,m);
%M1=[0 1 0;1 -4 1;0 1 0];
M1=[-1 -1 -1;-1 8 -1;-1 -1 -1];
for i=2:n-1
    for j=2:m-1
        V=image((i-1:i+1),(j-1:j+1));
        S=V.*M1;
        b(i,j)=sum(S(:));
    end
end
b=uint8(b);
axes(handles.imgT);
imshow(b);


% --------------------------------------------------------------------
function Sobel_30_Callback(hObject, eventdata, handles)
% hObject    handle to Sobel_30 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
 if ~isfield(handles, 'courant_data') || isempty(handles.courant_data)
        disp('Erreur : Aucune image chargée.');
        return;
    end

    % Récupérer l'image courante
    image = handles.courant_data;
    
    % Conversion de l'image en double pour le traitement
    image = double(image);
    
    % Initialisation des masques Sobel pour les gradients horizontal et vertical
    maskhor = [-1, 0, 1; -2, 0, 2; -1, 0, 1];  % Masque Sobel horizontal
    maskver = [-1, -2, -1; 0, 0, 0; 1, 2, 1];  % Masque Sobel vertical
    
    % Récupérer les dimensions de l'image
    [n, m] = size(image);
    
    % Initialiser les matrices de sortie pour les gradients
    outputhor = zeros(size(image)); 
    outputver = zeros(size(image));
    output = zeros(size(image)); 
    
    % Appliquer les masques Sobel sur l'image
    for i = 2:n-1
        for j = 2:m-1
            % Calculer le gradient horizontal
            Gx = sum(sum(image(i-1:i+1, j-1:j+1) .* maskhor));
            % Calculer le gradient vertical
            Gy = sum(sum(image(i-1:i+1, j-1:j+1) .* maskver));
            
            % Calculer la magnitude du gradient (magnitude totale)
            output(i, j) = sqrt(Gx^2 + Gy^2);
        end
    end
    
    % Convertir les résultats en uint8 pour l'affichage
    output = uint8(output);

    % Affichage de l'image résultante dans l'axe correspondant
    axes(handles.imgT);
    imshow(output);


% --------------------------------------------------------------------
function Gradient_31_Callback(hObject, eventdata, handles)
% hObject    handle to Gradient_31 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
image=handles.courant_data;
[n,m]=size(image); %les dimension de l image ;
image = double(image); %initialiser l'image
output=image; 
%image=rgb2gray(image);
image=double(image);
[m,n] = size(image);
output=zeros(size(image)); %initialiser l'image par zero
outputhor=zeros(size(image)); %init 0 variation horizontale
outputver=zeros(size(image)); %init 0 variation verticale
%les 3 output pour 
maskhor = [0,0,0;-1,0,1;0,0,0]; % filtre horizontale
maskver = [0,-1,0;0,0,0;0,1,0]; %filtre verticale 
%traitement a partir de la 4 ligne et la 4 colonne parceque lorsque k= 3
%val max de k , 
for i=4:(m-3)
   for j=4:(n-3) 
      for k=1:3         
          for l=1:3
            outputhor(i,j) = outputhor(i,j)+image(i-k,j-l)*maskhor(k,l);            
            outputver(i,j) = outputver(i,j)+image(i-k,j-l)*maskver(k,l);          
          end
      end
    end
 end
%mymin=min(min(output))
%mymax=max(max(output))
for i=4:(m-3)
for j=4:(n-3)       
    output(i,j)=sqrt(outputhor(i,j)*outputhor(i,j) + outputver(i,j)*outputver(i,j));
    %
end 
end 
%outputhor=uint8(outputhor); 
%outputver=uint8(outputver); 
output=uint8(output); %convertion en entier

%b=uint8(b);
axes(handles.imgT);
imshow(output);

%figure(10);colormap(gray(256));imagesc(outputhor);title('gradient hor'); 
%figure(11);colormap(gray(256));imagesc(outputver);title('gradient ver'); 
%figure(12);colormap(gray(256));imagesc(output);title('gradient');


% --------------------------------------------------------------------
function Prewitt_32_Callback(hObject, eventdata, handles)
% Vérifier si une image est chargée
if ~isfield(handles, 'courant_data') || isempty(handles.courant_data)
    disp('Erreur : Aucune image chargée.');
    return;
end

% Récupération et conversion en double
image = handles.courant_data;
if ndims(image) == 3
    image = rgb2gray(image); % Conversion en niveaux de gris si l'image est en couleur
end
image = double(image);
[n, m] = size(image);

% Masques Prewitt
maskhor = [-1, 0, 1; -1, 0, 1; -1, 0, 1]; % Filtre horizontal
maskver = [-1, -1, -1; 0, 0, 0; 1, 1, 1]; % Filtre vertical

% Convolution avec les masques
outputhor = conv2(image, maskhor, 'same');
outputver = conv2(image, maskver, 'same');

% Calcul de la magnitude du gradient
output = sqrt(outputhor.^2 + outputver.^2);
output = uint8(output);

% Affichage du résultat
axes(handles.imgT);
imshow(output);
title('Détection de contours avec Prewitt');

% --------------------------------------------------------------------
function Robert_33_Callback(hObject, eventdata, handles)
% hObject    handle to Robert_33 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

image = handles.courant_data;
[n,m]=size(image);
image = double(image);
 %num = get(handles.slider1, 'value');
% set(handles.edit1, 'String', num2str(num));
for x=1:n-1
 for y=1:m-1
  b(x,y)= abs(uint8( double(image(x,y))-double(image(x+1,y+1))))+ abs(uint8( double(image(x,y+1)) - double(image(x+1,y))));
 end
end
    % num = get(handles.slider1, 'Value');
    % set(handles.txt1, 'String', num2str(num));
        %Seuillage
        [n,m]=size(image);
        for i=1:n-1
         for j=1:m-1
          if b(i,j) < 25
            b(i,j)=0;
          end
         end
        end
           %
  handles.ima_traite = b;
  axes(handles.imgT);
  imshow(b);
%Grrr
handles.output = hObject;
% Update handles structure
guidata(hObject, handles);


% --------------------------------------------------------------------
function Moyenneur3_21_Callback(hObject, eventdata, handles)
% hObject    handle to Moyenneur3_21 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
image=handles.courant_data;
[n,m]=size(image);
image = double(image);
b=image;
H=(1/9)*[1 1 1 ; 1 1 1 ; 1 1 1 ];
for x = 2 : n-1
    for y = 2 : m-1
     %img(x,y)=mean([image(x-1,y-1)+image(x-1,y)+image(x-1,y+1)+image(x,y-1)+image(x,y)+image(x,y+1)+image(x+1,y-1)+image(x+1,y)+image(x+1,y+1)]);
      f=image(x-1:x+1,y-1:y+1);
      v=f.*H;
      %b=conv2(img,H);
      b(x,y)=sum(v(:));
      %b(x,y)=mean(f(:));
    end 
end
b=uint8(b);
%imshow(b);
axes(handles.imgT);
imshow(b);


% --------------------------------------------------------------------
function Moyenneur5_22_Callback(hObject, eventdata, handles)
% hObject    handle to Moyenneur5_22 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
image=handles.courant_data;
[n,m]=size(image);
image = double(image);
b=image;
H=(1/25)*[1 1 1 1 1 ; 1 1 1 1 1 ; 1 1 1 1 1 ; 1 1 1 1 1 ; 1 1 1 1 1];
for x = 3 : n-2
    for y = 3 : m-2
     f=image(x-2:x+2,y-2:y+2);
      v=f.*H;
      b(x,y)=sum(v(:));
    end 
end
b=uint8(b);
axes(handles.imgT);
imshow(b);
handles.ima_traite = b;
handles.output = hObject;
guidata(hObject, handles);

% --------------------------------------------------------------------
function Conique_23_Callback(hObject, eventdata, handles)
% hObject    handle to Conique_23 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Gaussien3_24_Callback(hObject, eventdata, handles)
% hObject    handle to Gaussien3_24 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
image=handles.courant_data;
[n,m]=size(image);
image = double(image);
b=image;
H=(1/16)*[1 2 1 ;2 4 2 ; 1 2 1];
for x = 2 : n-1
    for y = 2 : m-1
    f=image(x-1:x+1,y-1:y+1);
      v=f.*H;
      b(x,y)=sum(v(:));
    end 
end
b=uint8(b);
axes(handles.imgT);
imshow(b);
handles.ima_traite = b;
handles.output = hObject;
guidata(hObject, handles);

% --------------------------------------------------------------------
function Gaussien5_25_Callback(hObject, eventdata, handles)
% hObject    handle to Gaussien5_25 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
image=handles.courant_data;
[n,m]=size(image);
image = double(image);
b=image;
H=(1/256)*[1 4 6 4 1 ; 4 16 24 16 4 ; 6 24 36 24 6 ; 4 16 24 16 4 ; 1 4 6 4 1];
for x = 3 : n-2
    for y = 3 : m-2
  f=image(x-2:x+2,y-2:y+2);
      v=f.*H;
      b(x,y)=sum(v(:));
    end 
end
b=uint8(b);
axes(handles.imgT);
imshow(b);
handles.ima_traite = b;
handles.output = hObject;
guidata(hObject, handles);


% --------------------------------------------------------------------
function Pyramidal_27_Callback(hObject, eventdata, handles)
% hObject    handle to Pyramidal_27 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
image=handles.courant_data;
[n,m]=size(image);
image = double(image);
b=image;
H=(1/81)*[1 2 3 2 1 ; 2 4 6 4 2 ; 3 6 9 6 3 ; 2 4 6 4 2 ; 1 2 3 2 1];
for x = 3 : n-2
    for y = 3 : m-2
          f=image(x-2:x+2,y-2:y+2);
      v=f.*H;
      b(x,y)=sum(v(:));
    end 
end
b=uint8(b);
axes(handles.imgT);
imshow(b);
handles.ima_traite = b;
handles.output = hObject;
guidata(hObject, handles);



% --------------------------------------------------------------------
function Mediane_28_Callback(hObject, eventdata, handles)
% hObject    handle to Mediane_28 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
image=handles.courant_data;
image=double(image);
[n,m]=size(image);
img=image;
for i=2:n-1
    for j=2:m-1
       fenetre=image(i-1:i+1,j-1:j+1);
       v=[fenetre(1,:) fenetre(2,:) fenetre(3,:)];
       sort(v);
       a=median(v);
       img(i,j)=a;
    end
end
b=uint8(img);
handles.ima_traite = b;
axes(handles.imgT);
imshow(b);
handles.output = hObject;
guidata(hObject, handles);



% --------------------------------------------------------------------
function FPB_17_Callback(hObject, eventdata, handles)
% hObject    handle to FPB_17 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

I = handles.courant_data;
 F=fftshift(fft2(I)); 
% %calcul de la taille de l'image; 
%%pour conniatre le nombre de ligne et le nombre  des colonnes 
 M=size(F,1); 
 N=size(F,2); 
 P=size(F,3);
 %initialisation par 0
 H0=zeros(M,N); 
 D0=10; 
 M2=round(M/2); 
 N2=round(N/2); 
 H0(M2-D0:M2+D0,N2-D0:N2+D0)=1; %Le filtre
 for i=1:M 
  for j=1:N 
      %le produit matricielle 
      G(i,j)=F(i,j)*H0(i,j); 
 end 
 end 
 g=ifft2(G); %l'inverseur;
 %affichage de l'image 
 imshow(abs(g),[0,255]);


% --------------------------------------------------------------------
function FPBB_18_Callback(hObject, eventdata, handles)
% hObject    handle to FPBB_18 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


I = handles.courant_data;
%I = imread('eight.tif');

F=fftshift(fft2(I)); %centrer le spectre 
%calcul de la taille de l'image; 
M=size(F,1); 
N=size(F,2); 
P=size(F,3);

H0=zeros(M,N); 
D0=20; 
M2=round(M/2); 
N2=round(N/2); 
H0(M2-D0:M2+D0,N2-D0:N2+D0)=1; % le filtre

for i=1:M 
for j=1:N 
%H(i,j)=1/(1+(H0(i,j)/D0)^(2*n)); %
G(i,j)=F(i,j)*H0(i,j); 
end 
end 

g=ifft2(G); 

%subplot(1,2,1);imshow(I);title('image originale'); 
%subplot(1,2,2);
imshow(abs(g),[0,255]);%title('image filtrée'); 

% --------------------------------------------------------------------
function FPH_19_Callback(hObject, eventdata, handles)
% hObject    handle to FPH_19 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
I=handles.courant_data;
%charge; 
F=fftshift(fft2(I)); 
%calcul de la taille de l'image; 
M=size(F,1); 
N=size(F,2); 
P=size(F,3); 
%initialisation par des 1 
H1=ones(M,N); 
D0=3; 
M2=round(M/2); 
N2=round(N/2); 
H1(M2-D0:M2+D0,N2-D0:N2+D0)=0; 
for i=1:M 
for j=1:N 
G(i,j)=F(i,j)*H1(i,j); 
end 
end 
g=ifft2(G); 
%subplot(1,2,1);imshow(I);title('image originale'); 
%subplot(1,2,2);
imshow(255-abs(g),[0,255]);
%title('image filtrée');


% --------------------------------------------------------------------
function FPHH_20_Callback(hObject, eventdata, handles)
% hObject    handle to FPHH_20 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


I=handles.courant_data;

F=fftshift(fft2(I)); 
%calcul de la taille de l'image; 
M=size(F,1); 
N=size(F,2); 
P=size(F,3); 

H1=ones(M,N); 
D0=3; 
M2=round(M/2); 
N2=round(N/2); 
H1(M2-D0:M2+D0,N2-D0:N2+D0)=0; 

n=3; 

for i=1:M 
for j=1:N 
H(i,j)=1/(1+(H1(i,j)/D0)^(2*n)); 
G(i,j)=F(i,j)*H(i,j); 
end 
end 

g=ifft2(G); 

%subplot(1,2,1);imshow(I);title('image originale'); 
%subplot(1,2,2);
imshow(255-abs(g),[0,255]);%title('image filtrée');

% --------------------------------------------------------------------
function FPBande_21_Callback(hObject, eventdata, handles)
% hObject    handle to FPBande_21 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
function FPHB_20_Callback(hObject, eventdata, handles)
% hObject    handle to FPHB_20 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Récupération de l'image courante
I = handles.courant_data;

% Appliquer la Transformée de Fourier 2D et recentrer le spectre
F = fftshift(fft2(I));

% Calcul de la taille de l'image
[M, N] = size(F); 
M2 = round(M/2); 
N2 = round(N/2);

% Paramètres du filtre passe-bande
D1 = 30; % Fréquence de coupure basse
D2 = 80; % Fréquence de coupure haute
n = 2; % Ordre du filtre Butterworth

% Création du filtre passe-bande Butterworth
H = zeros(M, N);
for u = 1:M
    for v = 1:N
        % Distance au centre
        D = sqrt((u - M2)^2 + (v - N2)^2);
        
        % Si la distance est entre D1 et D2, on laisse passer la fréquence
        if D >= D1 && D <= D2
            H(u, v) = 1 / (1 + ((D - (D1 + D2) / 2) / ((D2 - D1) / 2))^(2 * n)); 
        end
      G(u,v) = F(u,v) *  H(u, v);
    end
end

% Appliquer le filtre en multipliant le spectre


% Retourner dans le domaine spatial (inverse de la transformée de Fourier)
g = ifft2(ifftshift(G));

% Affichage de l'image filtrée
imshow(255 - abs(g), [0, 255]); % Affichage avec inversion de l'image (255 - g)
title('Image Filtrée - Passe-Bande');


% --------------------------------------------------------------------
function Inversion_Callback(hObject, eventdata, handles)
% hObject    handle to Inversion (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
image=handles.courant_data;
%[n,m]=size(image);
image = double(image);
[l c]=size(image);
image = double(image);
v=image;
for i=1:l
   for j=1:c
     v(i,j)=-double(image(i,j))+255;
    end
 end 


v=uint8(v); 
axes(handles.imgT);
imshow(v);


% --------------------------------------------------------------------
function Contraste_12_Callback(hObject, eventdata, handles)
% hObject    handle to Contraste_12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
image=handles.courant_data;
%[n,m]=size(image);
image = double(image);
%output=image;

%ima=imread('cameraman.tif');
[l c]=size(image);
image = double(image);
v=image;
for i=1:l
    for j=1:c
      fpixel = (image(i,j)-128)*5 + 128; 
    % on vérifie que la valeur obtenue est bien dans [0..255]
    if( fpixel>255 )
      fpixel = 255;
    else if( fpixel<0 )
      fpixel = 0;
        end 
    end
    
   v(i,j) = fpixel;
    end
end  
v=uint8(v); 
axes(handles.imgT);
imshow(v);


% --------------------------------------------------------------------
function Division_13_Callback(hObject, eventdata, handles)
% hObject    handle to Division_13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    % Vérifier si une image est chargée
    if ~isfield(handles, 'courant_data') || isempty(handles.courant_data)
        disp('Erreur : Aucune image chargée.');
        return;
    end

    % Récupérer l'image courante
    I4 = handles.courant_data;

    % Calcul des moyennes manuellement
    m0 = 1;
    m1 = mean(I4(:)); % Moyenne de tous les pixels
    m2 = mean(I4(:).^2); % Moyenne des carrés des pixels
    m3 = mean(I4(:).^3); % Moyenne des cubes des pixels

    % Calcul des coefficients C0 et C1
    C1 = (m3 - (m1 * m2)) / (m2 - m1);
    C0 = (-m2 - (C1 * m1)) / m0;

    % Vérification de delta pour éviter sqrt() d'une valeur négative
    delta = C1^2 - 4 * C0;

    % Calcul des seuils z1 et z2
    z1 = (-C1 - sqrt(delta)) / 2;
    z2 = (-C1 + sqrt(delta)) / 2;

    % Calcul du seuil
    seuil = (z1 + z2) / 2;

    % Affichage du seuil
    disp(['Le seuil calculé est : ', num2str(seuil)]);
    text(2, 10, num2str(seuil));

    % Application du seuil sur l'image (division de l'image par le seuil)
    % Si l'intention est de binariser l'image
    bin = uint8(I4 > seuil) * 255; % Pixels supérieurs au seuil sont blancs (255)

   
    % Affichage de l'image binarisée
    axes(handles.imgT);
    handles.ima_traite = bin;
    imshow(handles.ima_traite);

    handles.output = hObject;

    guidata(hObject, handles);



% --------------------------------------------------------------------
function Histogramme_15_Callback(hObject, eventdata, handles)
    % Vérifier si une image est chargée
    if ~isfield(handles, 'courant_data') || isempty(handles.courant_data)
        disp('Erreur : Aucune image chargée.');
        return;
    end

    % Récupérer l'image courante
    img = handles.courant_data;
    % Vérification si l'image est en couleur et conversion en niveaux de gris
    if ndims(img) == 3
        img = rgb2gray(img); % Convertir l'image couleur en niveaux de gris
    end

    % Conversion en uint8 pour le traitement de l'histogramme
    img = uint8(img);
    % Taille de l'image
    [l, c] = size(img);

    % Initialisation du vecteur d'histogramme
    vec = zeros(1, 256);

    % Calcul de l'histogramme manuellement
    for i = 1:l
        for j = 1:c
            niveau = img(i, j); % Niveaux de gris entre 0 et 255
            vec(niveau + 1) = vec(niveau + 1) + 1; % Incrémenter l'histogramme
        end
    end

    % Affichage de l'histogramme
    axes(handles.imgT);
    bar(0:255, vec, 'k'); % Affichage en barres noires
    title('Histogramme des niveaux de gris');
    xlabel('Valeurs des pixels');
    ylabel('Nombre de pixels');

% --------------------------------------------------------------------
function Ouvrir_7_Callback(hObject, eventdata, handles)
    % Ouvrir un fichier image
    [file, path] = uigetfile({'*.jpg;*.png;*.bmp;*.tiff', 'Image Files (*.jpg, *.png, *.bmp, *.tiff)'}, ...
                              'Choisir une image');
    if isequal(file, 0) % Si l'utilisateur annule
        errordlg('Aucun fichier sélectionné', 'Erreur');
        return;
    end
    
    % Concaténer le chemin complet
    fullPath = fullfile(path, file);
    
    % Vérifier si le fichier existe
    if ~isfile(fullPath)
        errordlg('Fichier introuvable', 'Erreur');
        return;
    end
    
    % Tenter de lire le fichier
    try
        handles.ima = imread(fullPath);
        imshow(handles.ima, 'Parent', handles.img0); % Afficher l'image originale
        title(handles.img0, 'image originale'); % Modifier le titre à "image originale"
        
        % Appliquer un traitement (par exemple : convertir en niveaux de gris)
        if size(handles.ima, 3) == 3
            imgT = rgb2gray(handles.ima);
        else
            imgT = handles.ima; % Si l'image est déjà en niveaux de gris
        end
        
        imshow(imgT, 'Parent', handles.imgT); % Afficher l'image traitée
        title(handles.imgT, 'image traitée'); % Modifier le titre à "image traitée"
        
        % Sauvegarder les images dans le handle
        handles.courant_data = handles.ima; % Stocker l'image originale
        handles.courant_traitement = handles.imgT; % Stocker l'image traitée

        guidata(hObject, handles); % Sauvegarder les données dans handles
    catch ME
        errordlg(['Erreur lors du chargement du fichier : ', ME.message], 'Erreur');
    end


% --------------------------------------------------------------------
function Enregistrer_8_Callback(hObject, eventdata, handles)
% hObject    handle to Enregistrer_8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
image = handles.ima_traite;
[file,path] = uiputfile('*.png','Enregistrer Votre Image ...');
imwrite(image, sprintf('%s',path,file),'png');


% --------------------------------------------------------------------
function Quitter_9_Callback(hObject, eventdata, handles)
% hObject    handle to Quitter_9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
delete(handles.figure1)




% --------------------------------------------------------------------
function Binarisation_Callback(hObject, eventdata, handles)
% Récupérer l'image courante
I4 = handles.courant_data;

% Calcul des moyennes manuellement
m0 = 1;
m1 = mean(I4(:)); % Moyenne de tous les pixels
m2 = mean(I4(:).^2); % Moyenne des carrés des pixels
m3 = mean(I4(:).^3); % Moyenne des cubes des pixels

% Calcul des coefficients C0 et C1
C1 = (m3 - (m1 * m2)) / (m2 - m1);
C0 = (-m2 - (C1 * m1)) / m0;

% Vérification de delta pour éviter sqrt() d'une valeur négative
delta = C1^2 - 4 * C0;

% Calcul des seuils z1 et z2
z1 = (-C1 - sqrt(delta)) / 2;
z2 = (-C1 + sqrt(delta)) / 2;

% Calcul du seuil
seuil = (z1 + z2) / 2;

% Binarisation de l'image
bin = (I4 > seuil) * 255;

% Affichage du seuil
text(2, 10, num2str(seuil));



% Affichage de l'image binarisée
axes(handles.imgT);
handles.ima_traite = bin;
imshow(handles.ima_traite);

handles.output = hObject;

guidata(hObject, handles);


% --------------------------------------------------------------------
function Niveaugris_14_Callback(hObject, eventdata, handles)
% hObject    handle to Niveaugris_14 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
ima=handles.courant_data;
d = length(size(ima));
if d==3
    imagray=rgb2gray(ima);
elseif d==2
   imagray=ima;
end
axes(handles.imgT);
imshow(imagray);


% --------------------------------------------------------------------
function Gaussien_Callback(hObject, eventdata, handles)

    % Vérifier si une image est chargée
    if ~isfield(handles, 'courant_data') || isempty(handles.courant_data)
        disp('Erreur : Aucune image chargée.');
        return;
    end

    % Récupérer l'image courante
    img = handles.courant_data;

    % Vérification si l'image est en couleur et conversion en niveaux de gris
    if ndims(img) == 3
        img = rgb2gray(img); % Convertir l'image couleur en niveaux de gris
    end

    % Paramètres du bruit gaussien
    % Moyenne du bruit (mu) et écart-type (sigma)
    mu = 0;   % Moyenne du bruit
    sigma = 25; % Ecart-type du bruit (peut être ajusté)

    % Ajouter le bruit gaussien à l'image
    bruit = mu + sigma * randn(size(img)); % Générer le bruit gaussien
    img_bruitee = double(img) + bruit;     % Ajouter le bruit à l'image

    % Assurez-vous que les valeurs de l'image restent dans la plage [0, 255]
    img_bruitee = uint8(min(max(img_bruitee, 0), 255));

   

    % Affichage de l'image bruitée
    axes(handles.imgT);
    handles.ima_traite = img_bruitee;
    imshow(handles.ima_traite);

    handles.output = hObject;

    guidata(hObject, handles);

% --------------------------------------------------------------------
function PoivreSel_35_Callback(hObject, eventdata, handles)
  
    % Vérifier si une image est chargée
    if ~isfield(handles, 'courant_data') || isempty(handles.courant_data)
        disp('Erreur : Aucune image chargée.');
        return;
    end

    % Récupérer l'image courante
    img = handles.courant_data;

    % Vérification si l'image est en couleur et conversion en niveaux de gris
    if ndims(img) == 3
        img = rgb2gray(img); % Convertir en niveaux de gris
    end

    % Paramètre du bruit (densité)
    densite = 0.05; % 5% des pixels seront affectés

    % Génération d'une matrice aléatoire pour définir les pixels affectés
    bruit = rand(size(img));

    % Copie de l'image pour modification
    img_bruitee = img;

    % Application du bruit Poivre et Sel
    img_bruitee(bruit < densite / 2) = 0;     % Poivre (noir)
    img_bruitee(bruit > 1 - densite / 2) = 255; % Sel (blanc)

    % Affichage de l'image bruitée
    axes(handles.imgT);
    handles.ima_traite = img_bruitee;
    imshow(handles.ima_traite);

    handles.output = hObject;
    guidata(hObject, handles);
   


% --------------------------------------------------------------------
function Morphologie_Callback(hObject, eventdata, handles)
% Menu principal pour la morphologie
disp('Menu Morphologie sélectionné');


% --------------------------------------------------------------------
function Detection_Callback(hObject, eventdata, handles)
% Menu principal pour la détection
disp('Menu Détection sélectionné');


% --------------------------------------------------------------------
function SUSAN_Callback(hObject, eventdata, handles)
    % SUSAN : Détection des points d'intérêt avec le détecteur SUSAN
    try
        % Debug: Vérifier le contenu de handles
        disp('Contenu de handles :');
        disp(handles);
        
        % Vérifier si une image a été chargée dans le programme
        if ~isfield(handles, 'courant_data') || isempty(handles.courant_data)
            errordlg('Veuillez d abord charger une image.', 'Erreur');
            return;
        end
        
        % Charger l'image depuis handles
        im = handles.courant_data;

        % ======================= Conversion de l'image ==========================
        d = length(size(im));
        if d == 3
            image = double(rgb2gray(im));
        elseif d == 2
            image = double(im);
        end

        % ========================= Initialisation ===============================
        [n, m] = size(image);
        rayon = 1;
        alpha = 80;
        r = 5;
        alpha = alpha / 100;

        % ======================== Construction du masque ========================
        mask = zeros(2 * rayon + 1);
        b = ones(rayon + 1);
        for i = 1:rayon + 1
            for j = 1:rayon + 1
                if rayon == 1
                    if j > i
                        b(i, j) = 0;
                    end
                else
                    if j > i + 1
                        b(i, j) = 0;
                    end
                end
            end
        end

        mask(1:rayon + 1, rayon + 1:2 * rayon + 1) = b;
        mask(1:rayon + 1, 1:rayon + 1) = rot90(b);
        mask0 = mask;
        mask0 = flipud(mask0);
        mask = mask0 + mask;
        mask(rayon + 1, :) = mask(rayon + 1, :);

        % ===================== Calcul de la réponse ============================
        max_reponse = sum(sum(mask));
        f = zeros(n, m);

        for i = (rayon + 1):n - rayon
            for j = (rayon + 1):m - rayon
                image_courant = image(i - rayon:i + rayon, j - rayon:j + rayon);
                image_courant_mask = image_courant .* mask;
                intensite_centrale = image_courant_mask(rayon + 1, rayon + 1);
                s = exp(-1 * (((image_courant_mask - intensite_centrale) / max_reponse) .^ 6));
                somme = sum(sum(s));

                % Gestion des centres à 0
                if intensite_centrale == 0
                    somme = somme - length(find(mask == 0));
                end
                f(i, j) = somme;
            end
        end

        % ============= Sélection et seuillage des points d'intérêt ============
        ff = f(rayon + 1:n - (rayon + 1), rayon + 1:m - (rayon + 1));
        minf = min(min(ff));
        maxf = max(max(f));
        fff = f;
        d = 2 * r + 1;
        temp1 = round(n / d);
        temp2 = round(m / d);

        fff(n:temp1 * d + d, m:temp2 * d + d) = 0;

        for i = (r + 1):d:temp1 * d + d
            for j = (r + 1):d:temp2 * d + d
                window = fff(i - r:i + r, j - r:j + r);
                window0 = window;
                [xx, yy] = find(window0 == 0);
                for k = 1:length(xx)
                    window0(xx(k), yy(k)) = max(max(window0));
                end
                minwindow = min(min(window0));
                [y, x] = find(minwindow ~= window & window <= minf + alpha * (maxf - minf) & window > 0);
                [u, v] = find(minwindow == window);
                if length(u) > 1
                    for l = 2:length(u)
                        fff(i - r - 1 + u(l), j - r - 1 + v(l)) = 0;
                    end
                end
                if ~isempty(x)
                    for l = 1:length(y)
                        fff(i - r - 1 + y(l), j - r - 1 + x(l)) = 0;
                    end
                end
            end
        end

        seuil = minf + alpha * (maxf - minf);
        [u, v] = find(minf <= fff & fff <= seuil);

        % ============== Affichage des résultats ==============================
        axes(handles.imgT); % S'assurer d'afficher dans le panneau image traitée
        imshow(im); % Afficher l'image originale
        hold on;
        plot(v, u, '.r', 'MarkerSize', 10); % Points d'intérêt en rouge
        hold off;

        % Afficher le nombre de points d'intérêt détectés
        disp(['Nombre de points dintérêt détectés : ', num2str(length(v))]);

        % Mettre à jour le handle
        guidata(hObject, handles);

    catch ME
        errordlg(['Erreur dans la fonction SUSAN : ', ME.message], 'Erreur');
    end


% --------------------------------------------------------------------
function HARRIS_Callback(hObject, ~, handles)
    % HARRIS : Détection des points d'intérêt avec l'algorithme de Harris

    try
        % Débogage : Vérifier le contenu de handles
        disp('Contenu de handles :');
        disp(handles);

        % Vérifier si une image a été chargée dans le programme
        if ~isfield(handles, 'courant_data') || isempty(handles.courant_data)
            errordlg('Veuillez dabord charger une image.', 'Erreur');
            return;
        end
        
        % Charger l'image depuis handles
        img = handles.courant_data;
        
        % Conversion de l'image en double
        imd = double(img);
        
        % Initialisation des paramètres pour l'algorithme de Harris
        sigma = 1; k = 0.04; w = 5 * sigma; seuil = 50; r = 6; sze = 2 * r + 1;
        dx = [-1 0 1]; dy = dx'; % filtre dérivatif
        g = fspecial('gaussian', max(1, fix(w)), sigma); % filtre gaussien
        
        % Calcul des gradients
        Ix = conv2(imd, dx, 'same');
        Iy = conv2(imd, dy, 'same');
        Ix2 = conv2(Ix.^2, g, 'same');
        Iy2 = conv2(Iy.^2, g, 'same');
        Ixy = conv2(Ix .* Iy, g, 'same');
        
        % Calcul de la réponse de Harris
        R = Ix2 .* Iy2 - Ixy.^2 - k * (Ix2 + Iy2).^2;
        R1 = (1000 / (max(max(R)))) * R;
        
        % Seuillage et extraction des points d'intérêt
        [m, n] = size(R1);
        [u, v] = find(R1 <= seuil);
        nb = length(u);
        for l = 1:nb
            R1(u(l), v(l)) = 0;
        end
        R11 = zeros(m + 2 * r, n + 2 * r);
        R11(r + 1:m + r, r + 1:n + r) = R1;
        
        [m1, n1] = size(R11);
        for i = r + 1:m1 - r
            for j = r + 1:n1 - r
                fenetre = R11(i - r:i + r, j - r:j + r);
                ma = max(max(fenetre));
                if fenetre(r + 1, r + 1) < ma
                    R11(i, j) = 0;
                end
            end
        end
        R11 = R11(r + 1:m + r, r + 1:n + r);
        [x, y] = find(R11);
        
        % Suppression des non-maxima
        MX = ordfilt2(R1, sze^2, ones(sze));
        R11 = (R1 == MX) & (R1 > seuil);
        [x, y] = find(R11);
        
        % Affichage des points d'intérêt
        nb = length(x);
        axes(handles.imgT); % S'assurer d'afficher dans le panneau image traitée
        imshow(img); % Afficher l'image originale
        hold on;
        plot(y, x, 'r.'); % Points d'intérêt en rouge
        hold off;
        
        % Mettre à jour le handle
        guidata(hObject, handles);

    catch ME
        errordlg(['Erreur dans la fonction HARRIS : ', ME.message], 'Erreur');
    end

% --------------------------------------------------------------------
function Erosion_Callback(hObject, eventdata, handles)
    % Erosion morphologique (sans strel)
    global originalImage;

    % Vérification si l'image est bien chargée
    if ~isfield(handles, 'courant_data') || isempty(handles.courant_data)
        errordlg('Veuillez charger une image d''abord', 'Erreur');
        return;
    end
    
    % Charger l'image depuis handles
    originalImage = handles.courant_data;  % Mettre à jour originalImage avec l'image chargée dans handles

    % Créer un élément structurant (par exemple un disque de taille 5)
    se = ones(5);  % Crée un masque de 5x5, vous pouvez ajuster la taille ou utiliser un autre motif

    % Appliquer l'érosion manuellement
    erodedImage = erodeImage(originalImage, se);

    % Afficher l'image érodée
    imshow(erodedImage, 'Parent', handles.img0);
    title(handles.img0, 'Erosion');

    % Mettre à jour handles
    guidata(hObject, handles);

% Fonction manuelle pour l'érosion
function erodedImage = erodeImage(image, se)
    [n, m] = size(image);
    [se_n, se_m] = size(se);
    erodedImage = zeros(n, m);

    % Appliquer l'érosion pour chaque pixel de l'image
    for i = 1 + floor(se_n / 2):n - floor(se_n / 2)
        for j = 1 + floor(se_m / 2):m - floor(se_m / 2)
            region = image(i - floor(se_n / 2):i + floor(se_n / 2), j - floor(se_m / 2):j + floor(se_m / 2));
            % Vérifier si le masque structurant est entièrement contenu dans la région de l'image
            if all(region(se == 1) == 255)  % 255 correspond à la valeur blanche dans une image binaire
                erodedImage(i, j) = 255;  % Erosion: si le masque est entièrement dans la région, affecter 255
            else
                erodedImage(i, j) = 0;    % Sinon, mettre à 0
            end
        end
    end

% --------------------------------------------------------------------
function Dilatation_Callback(hObject, eventdata, handles)
% Dilatation morphologique
global originalImage;

% Vérification si l'image est bien chargée
if isempty(originalImage)
    errordlg('Veuillez charger une image d''abord', 'Erreur');
    return;
end

se = strel('disk', 5);
dilatedImage = imdilate(originalImage, se);
imshow(dilatedImage, 'Parent', handles.img0);
title(handles.img0, 'Dilatation');

% --------------------------------------------------------------------
function Ouverture_Callback(hObject, eventdata, handles)
% Ouverture morphologique
global originalImage;

% Vérification si l'image est bien chargée
if isempty(originalImage)
    errordlg('Veuillez charger une image d''abord', 'Erreur');
    return;
end

se = strel('disk', 5);
openedImage = imopen(originalImage, se);
imshow(openedImage, 'Parent', handles.img0);
title(handles.img0, 'Ouverture');

% --------------------------------------------------------------------
function Fermeture_Callback(hObject, eventdata, handles)
% Fermeture morphologique
global originalImage;

% Vérification si l'image est bien chargée
if isempty(originalImage)
    errordlg('Veuillez charger une image d''abord', 'Erreur');
    return;
end

se = strel('disk', 5);
closedImage = imclose(originalImage, se);
imshow(closedImage, 'Parent', handles.img0);
title(handles.img0, 'Fermeture');

% --------------------------------------------------------------------
function White_top_Hat_Callback(hObject, eventdata, handles)
% Transformation de chapeau blanc
global originalImage;

% Vérification si l'image est bien chargée
if isempty(originalImage)
    errordlg('Veuillez charger une image d''abord', 'Erreur');
    return;
end

se = strel('disk', 5);
whiteTopHat = imtophat(originalImage, se);
imshow(whiteTopHat, 'Parent', handles.img0);
title(handles.img0, 'Chapeau Haut Blanc');

% --------------------------------------------------------------------
function Black_Top_Hat_Callback(hObject, eventdata, handles)
% Transformation de chapeau noir
global originalImage;

% Vérification si l'image est bien chargée
if isempty(originalImage)
    errordlg('Veuillez charger une image d''abord', 'Erreur');
    return;
end

se = strel('disk', 5);
blackTopHat = imbothat(originalImage, se);
imshow(blackTopHat, 'Parent', handles.img0);
title(handles.img0, 'Chapeau Haut Noir');

% --------------------------------------------------------------------
function Gradient_morphologique_Callback(hObject, eventdata, handles)
% Gradient morphologique
global originalImage;

% Vérification si l'image est bien chargée
if isempty(originalImage)
    errordlg('Veuillez charger une image d''abord', 'Erreur');
    return;
end

se = strel('disk', 5);
gradientImage = imdilate(originalImage, se) - imerode(originalImage, se);
imshow(gradientImage, 'Parent', handles.img0);
title(handles.img0, 'Gradient Morphologique');


% --------------------------------------------------------------------
function Point_Interet_Callback(hObject, eventdata, handles)
% Détection de points d'intérêt
%global originalImage;
% if isempty(originalImage)
%     errordlg('Veuillez charger une image d''abord', 'Erreur');
%     return;
% end
% corners = detectMinEigenFeatures(originalImage);
% imshow(originalImage, 'Parent', handles.img0);
% hold on;
% plot(corners);
% hold off;
% title(handles.img0, 'Points d''Intérêt');




% --------------------------------------------------------------------
function Untitled_8_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
