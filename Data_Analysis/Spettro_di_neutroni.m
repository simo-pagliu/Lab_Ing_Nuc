%% fronte

clc;
clear;
load n_0.mat;

n = neutroniok;
E = 1000*(n(:,2) + n(:,1))/2;
dE = (n(:,2) - n(:,1))/2; 
flux = n(:,3);
err = n(:,4);



figure(4);
letargia = flux.*E;

cond = err<90 & letargia>eps;

semilogx(E(cond),letargia(cond), LineWidth=2);
hold on;

% linea ai 25meV
% v_25 = linspace(0,max(max(letargia)), 100);
% semilogx((2.5e-8)*ones(length(v_25)), v_25, LineWidth=1);

% linea ai 13MeV
% v_13 = linspace(0,max(max(letargia)), 100);
% semilogx((13.11)*ones(length(v_25)), v_25, LineWidth=1);

title 'flux of n inside the bunker, front of the beam';
% legend 'neutroni' '25meV' '13MeV'

%% @ 90 degrees

clc;
clear;
load n_90.mat;

n = neutroniok;
E = 1000*(n(:,2) + n(:,1))/2;
dE = (n(:,2) - n(:,1))/2; 
flux = n(:,3);
err = n(:,4);


figure(4);
letargia = flux.*E;

cond = err<50 & letargia>eps;

semilogx(E(cond),letargia(cond), LineWidth=2);
hold on;

% linea ai 25meV
v_25 = linspace(0,max(max(letargia)), 100);
semilogx((2.5e-8)*ones(length(v_25)), v_25, LineWidth=1);

% linea ai 13MeV
v_13 = linspace(0,max(max(letargia)), 100);
semilogx((13.11)*ones(length(v_25)), v_25, LineWidth=1);

title 'flux of n inside the bunker, 90degrees form the beam';