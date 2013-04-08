%% czyszczenie

clear all;

%% parametry symulacji

dt = 100;          % [s] opoznienie startu symulacji

%% parametry pomieszczenia i grzejnika

Vg = 0.01;         % [m3] objetosc grzejnika
Vp = 20;           % [m3] objetosc pomieszczenia

%% parametry fizyczne

cpw = 4190;        % [J / kg*K] cieplo wlasciwe wody
row = 980;         % [kg / m3] gestosc wody
cpp = 1008;        % [J / kg*K] cieplo wlasciwe powietrza     
rop = 1.185;       % [kg / m3] gestosc powietrza

Cvg = cpw*row*Vg/4; % [W] pojemnosc cieplna grzejnika
Cvw = cpp*rop*Vp;   % [W] pojemnosc cieplna pomieszczenia

%% wartosci nominalne

Tzew_n = -20;      % [C] temperatura zewnetrzna
Twew_n = 20;       % [C] temperatura wewnetrzna
Tgz_n = 90;        % [C] temperatura zasilania grzejnika
Tgp_n = 70;        % [C] temperatura powrotu z grzejnika
Q_n = 20000;       % [W] cieplo wymagane
Qt_n = 0;          % [W] cieplo technologiczne

Tgsr_n = Tgp_n;                     % [C] temperatura srednia grzejnika
Fg_n = Q_n/(cpw*row*(Tgz_n-Tgp_n)); % [m3 / s] przeplyw wody przez grzejnik
kg = Q_n/(Tgsr_n-Twew_n);           % wspolczynnik przewodzenia grzejnika
kw = (Q_n-Qt_n)/(Twew_n-Tzew_n);    % wspolczynnik przewodzenia scian

%% wartosci poczatkowe

Tzew_0 = Tzew_n;   % [C] temperatura zewnetrzna
Tgz_0 = Tgz_n;     % [C] temperatura zasilania grzejnika
Twew_0 = Twew_n;
Qt_0 = Qt_n;       % [W] straty/zyski technologiczne

Tgp_0 = (kw*(Twew_0-Tzew_0)+Qt_0)/kg+Twew_0;
Tgsr_0 = Tgp_0;
Fg_0 = kg*(Tgsr_0-Twew_0)/(cpw*row*(Tgz_0-Tgp_0));

% zmiany wartosci

dTzew = 0;         % [C] zmiana temperatury zewnetrznej
dTgz = 0;          % [C] zmiana temperatury zasilania grzejnika
dFg = 0;           % [m3 / s] przeplyw wody przez grzejnik
dQt = 0;           % [W] straty/zyski technologiczne

% regulacja Tgz
 
Tr_0 = Tgz_0;     % wyjscie regulatora w t=0
ki = .05;         % wzmocnienie czlonu I
kp = 3.5;         % wzmocnienie czlonu P
 
Twew_z0 = Twew_0; % wartosc zadana
dTwew_z = 2;      % zmiana wartoœci zadanej

clf;

%% pierwszy punkt pracy - wartoœci nominalne

sim('lab2_PI_Tgz');

figure(1);
plot(t, Twew, 'r');
% title('Temperatura wewnetrzna');
hold;
 
figure(2);
plot(t, Tgz, 'r');
% title('Temperatura zasilania');
hold;

x1=sum(Twew_z-Twew);

%% drugi punkt pracy

Tzew_0 = Tzew_0+10;
Twew_0 = Twew_0-2;
Twew_z0 = Twew_0;

Tgp_0 = (kw*(Twew_0-Tzew_0)+Qt_0)/kg+Twew_0;
Tgsr_0 = Tgp_0;
Fg_0 = kg*(Tgsr_0-Twew_0)/(cpw*row*(Tgz_0-Tgp_0));

sim('lab2_PI_Tgz');

figure(1);
plot(t, Twew, 'g');
 
figure(2);
plot(t, Tgz, 'g');

x2=sum(Twew_z-Twew);

%% trzeci punkt pracy

Tzew_0 = Tzew_n;
Twew_0 = Twew_n;
Twew_z0 = Twew_0;

Tgz_0 = Tgz_0-10;
Tr_0 = Tgz_0;     % wyjscie regulatora w t=0

Tgp_0 = (kw*(Twew_0-Tzew_0)+Qt_0)/kg+Twew_0;
Tgsr_0 = Tgp_0;
Fg_0 = kg*(Tgsr_0-Twew_0)/(cpw*row*(Tgz_0-Tgp_0));

sim('lab2_PI_Tgz');

figure(1);
plot(t, Twew);
legend('1 pp','2 pp','3 pp');

figure(2);
plot(t, Tgz);
legend('1 pp','2 pp','3 pp');

x1
x2
x3=sum(Twew_z-Twew)

