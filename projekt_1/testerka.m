%% TESTING SCRIPT

Vg = 0.1;          % [m3] objetosc grzejnika
Vp = 75;           % [m3] objetosc pomieszczenia

%% parametry fizyczne

cpw = 4190;        % [J / kg*K] cieplo wlasciwe wody
row = 980;         % [kg / m3] gestosc wody
cpp = 1008;        % [J / kg*K] cieplo wlasciwe powietrza     
rop = 1.185;       % [kg / m3] gestosc powietrza


%% wartosci nominalne

Tzew_n = -20;      % [C] temperatura zewnetrzna
Twew_n = 20;       % [C] temperatura wewnetrzna
Tgz_n = 90;        % [C] temperatura zasilania grzejnika
Tgp_n = 70;        % [C] temperatura powrotu z grzejnika
Q_n = 20000;       % [W] cieplo wymagane

%% zmiany wartosci

dTzew = -20;         % [C] zmiana temperatury zewnetrznej
dTgz = 0;          % [C] zmiana temperatury zasilania grzejnika
dFg = 0;           % [m3 / s] przeplyw wody przez grzejnik
dQt = 0;           % [W] straty/zyski technologiczne

%% symulacje 
clf
Vg = 0.1; 
out = symulacja_dyn(Vg, Vp, cpw, row, cpp, rop, Tzew_n, Twew_n, Tgz_n, Tgp_n, Q_n, dTzew, dTgz, dFg, dQt);
subplot(2,1,1)
plot(out(:,1), out(:,2),'r')
title('temp wewnatrz w czasie')
hold on
subplot(2,1,2)
plot(out(:,1), out(:,3),'r')
title('temp grzejnika w czasie')
hold on

Vg = 0.3; 
out = symulacja_dyn(Vg, Vp, cpw, row, cpp, rop, Tzew_n, Twew_n, Tgz_n, Tgp_n, Q_n, dTzew, dTgz, dFg, dQt);
subplot(2,1,1)
plot(out(:,1), out(:,2),'g')
subplot(2,1,2)
plot(out(:,1), out(:,3),'g')

Vg = 0.5; 
out = symulacja_dyn(Vg, Vp, cpw, row, cpp, rop, Tzew_n, Twew_n, Tgz_n, Tgp_n, Q_n, dTzew, dTgz, dFg, dQt);
subplot(2,1,1)
plot(out(:,1), out(:,2),'b')
subplot(2,1,2)
plot(out(:,1), out(:,3),'b')

legend('Vgrz = 0.1', 'Vgrz = 0.3', 'Vgrz = 0.5','Location','SouthWest')

hold off

