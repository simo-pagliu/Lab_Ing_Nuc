clear all
close all
clc

%% Energia dei neutroni in funzione dell'angolo di scattering

syms Tp T18F Q teta Tn

uma=1.66054e-27;
m18F = 18.000937956*uma;
m18O = 17.999161001*uma;
mn=1.674927351e-27;
mp=1.6726231e-27;
c=299792458;

Q = (m18O+mp-m18F-mn)*c^2;
Tp = 18/6.242e12;
% pp = sqrt(2*mp*Tp);
% p18F = sqrt(2*m18F*T18F);
% pn = sqrt(2*mn*Tn);

eq1= Q+Tp == T18F+Tn;
eq2= m18F*T18F == (mp*Tp)+(mn*Tn)-(2*sqrt(mp*mn*Tp*Tn)*cos(teta));

sol = solve(eq1,eq2,T18F,Tn)

teta=linspace(0,pi,10);
Eneutrone=matlabFunction(sol.Tn(2)*6.242e12);
plot(teta,Eneutrone(teta),'Color',[0.2 0.4 1.0],'LineWidth',2)
hold on
plot(pi/2,Eneutrone(pi/2),'ko','LineWidth',3)
plot(pi/2,Eneutrone(pi/2),'wo','LineWidth',2)
