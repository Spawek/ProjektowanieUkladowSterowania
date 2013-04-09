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
Tgz_0 = 90;        % [C] temperatura zasilania grzejnika
Tgp_n = 70;        % [C] temperatura powrotu z grzejnika
Q_n = 20000;       % [W] cieplo wymagane

%% zmiany wartosci

dTzew = -20;         % [C] zmiana temperatury zewnetrznej
dTgz = 0;          % [C] zmiana temperatury zasilania grzejnika
dFg = 0;           % [m3 / s] przeplyw wody przez grzejnik
dQt = 0;           % [W] straty/zyski technologiczne

%% symulacje 
clf
out = symulacja_dyn(Vg, Vp, cpw, row, cpp, rop, Tzew_n, Twew_n, Tgz_0, Tgp_n, Q_n, dTzew, dTgz, dFg, dQt);
subplot(2,1,1)
plot(out(:,1), out(:,2),'r')
title('temp wewnatrz w czasie')
hold on
subplot(2,1,2)
plot(out(:,1), out(:,3),'r')
title('temp grzejnika w czasie')
hold on


Tzew_0 = Tzew_0 + 10;
out = symulacja_dyn(Vg, Vp, cpw, row, cpp, rop, Tzew_0, Twew_n, Tgz_0, Tgp_n, Q_n, dTzew, dTgz, dFg, dQt);
subplot(2,1,1)
plot(out(:,1), out(:,2),'g')
subplot(2,1,2)
plot(out(:,1), out(:,3),'g')
Tzew_0 = Tzew_0 - 10;

Tgz_0 = Tgz_0 - 10;
out = symulacja_dyn(Vg, Vp, cpw, row, cpp, rop, Tzew_n, Twew_n, Tgz_0, Tgp_n, Q_n, dTzew, dTgz, dFg, dQt);
subplot(2,1,1)
plot(out(:,1), out(:,2),'b')
subplot(2,1,2)
plot(out(:,1), out(:,3),'b')
Tgz_0 = Tgz_0 + 10;

Fg_0 = Fg_0 * 0.5;
out = symulacja_dyn(Vg, Vp, cpw, row, cpp, rop, Tzew_n, Twew_n, Tgz_0, Tgp_n, Q_n, dTzew, dTgz, dFg, dQt);
subplot(2,1,1)
plot(out(:,1), out(:,2),'y')
subplot(2,1,2)
plot(out(:,1), out(:,3),'y')
Fg_0 = Fg_0 * 2;

legend('Punkt pracy 1','Punkt pracy 2', 'Punkt pracy 3', 'punkt pracy 4','SouthWest')

hold off

