function [out_data] = symulacja( Vg_,  Vp_, cpw_, row_, cpp_, rop_, Tzew_n_, Twew_n_, Tgz_n_, Tgp_n_, Q_n_, dTzew_, dTgz_, dFg_, dQt_)
% out_data = [time', temp_wewnatrz', temp_grzejnika]


%% deklaracja zmiennych globalnych
global Vg
global Vp
global cpw
global row
global cpp
global rop
global Tzew_n
global Twew_n
global Tgz_n
global Tgsr_n
global Fg_n
global Q_n
global Tzew_0
global Twew_0
global Tgz_0
global Tgsr_0
global Fg_0
global Qt_0
global dTzew
global dTgz
global dFg
global dQt
global dt
global kw
global kg

%% inicjalizacja parametrow

dt=5;              % [s] opoznienie startu symulacji

%% parametry pomieszczenia i grzejnika

Vg = Vg_;          % [m3] objetosc grzejnika
Vp = Vp_;           % [m3] objetosc pomieszczenia

%% parametry fizyczne

cpw = cpw_;        % [J / kg*K] cieplo wlasciwe wody
row = row_;         % [kg / m3] gestosc wody
cpp = cpp_;        % [J / kg*K] cieplo wlasciwe powietrza     
rop = rop_;       % [kg / m3] gestosc powietrza

Cvg = cpw*row*Vg;  % [W] pojemnosc cieplna grzejnika
Cvw = cpp*rop*Vp*3;  % [W] pojemnosc cieplna pomieszczenia
% (* 3) uwzglêdaniamy te¿ pojemnoœæ ciepln¹ œcian itp

%% wartosci nominalne

Tzew_n = Tzew_n_;      % [C] temperatura zewnetrzna
Twew_n = Twew_n_;       % [C] temperatura wewnetrzna
Tgz_n = Tgz_n_;        % [C] temperatura zasilania grzejnika
Tgp_n = Tgp_n_;        % [C] temperatura powrotu z grzejnika
Q_n = Q_n_;       % [W] cieplo wymagane

Tgsr_n = Tgp_n;                     % [C] temperatura srednia grzejnika
Fg_n = Q_n/(cpw*row*(Tgz_n-Tgp_n)); % [m3 / s] przeplyw wody przez grzejnik

%% wartosci poczatkowe

Tzew_0 = Tzew_n;   % [C] temperatura zewnetrzna
Twew_0 = Twew_n;   % [C] temperatura wewnetrzna
Tgz_0 = Tgz_n;     % [C] temperatura zasilania grzejnika
Tgsr_0 = Tgsr_n;   % [C] temperatura powrotu z grzejnika
Fg_0 = Fg_n;       % [m3 / s] przeplyw wody przez grzejnik
Qt_0 = 0;          % [W] straty/zyski technologiczne

%% zmiany wartosci

dTzew = dTzew_;         % [C] zmiana temperatury zewnetrznej
dTgz = dTgz_;          % [C] zmiana temperatury zasilania grzejnika
dFg = dFg_;           % [m3 / s] przeplyw wody przez grzejnik
dQt = dQt_;           % [W] straty/zyski technologiczne

%% wspolczynniki

kg = Q_n/(Tgsr_n-Twew_n);         % wspolczynnik przewodzenia grzejnika
kw = (Q_n-Qt_0)/(Twew_n-Tzew_n);  % wspolczynnik przewodzenia scian

%% symulacja

sim('lab2_model_bloczek')

out_data = [T_wew_out.time, T_wew_out.signals.values, T_gsr_out.signals.values];

end

