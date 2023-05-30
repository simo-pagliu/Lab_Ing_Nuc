T_rec = [];
for jj=1:3
% Hello World
clear v R E omega T ii
clc

% Costanti

% Carica del p+
q = 1.602e-19;
% Massa del p+
m = 1.67e-27;

% Parameteri

% Dimensione del gap
gap = 0.05;
% Tensione applicata nel gap
V = [10e3 12.5e3 15e3]; %V
V = V(jj);
% Campo magnetico nei settori
B = 1.6;

% Energia da raggiungere
E_trg_MeV = 18; %MeV
E_trg = E_trg_MeV*(1.6e-13); %MeV --> J

% Accelerazione nel gap
a = (q*V)/(m*gap);

% Inizializzazione delle variabili necessarie
x=0;
y=0;
v=0;
R=0;
E=0;
omega=0;
T=0;
ii=0;

% Step per plotting (maggiore --> più  preciso)
n_plot = 100;

%% Ciclo di Calcolo

% Ciclo while, continua fino al SUPERAMENTO dell'energia di target (18MeV)
% NOTA: energia è calcolata in J

while E(end) < E_trg

% Nuova velocità
%moto uniformemente accelerato
new_t_gap = (-v(end) + sqrt(v(end)^2 + 4*0.5*a*gap))/a;
new_v = a*new_t_gap + v(end);
v = [v, new_v];

% Nuovo raggio, calcolato dalla forza di Lorentz
new_R = (m*new_v)/(q*B);
R = [R, new_R];

% Nuovo valore di Energia raggiunta
new_E = 0.5*m*new_v^2;
E = [E, new_E];

% Omega
new_omega = new_v/new_R;
omega = [omega, new_omega];

% Tempo di attraversamento del semicerchio
new_t_dee = pi/(new_omega);
% Tempo di attraversamento del gap
%new_t_gap = gap/new_v;
% Salvo la somma dei due
T = [T new_t_dee+new_t_gap];

% Incremento contatore
ii = ii + 1;

end

% Tempo di permanenza totale nel ciclotrone
T_tot = sum(T);
% Converto Energia anche in MeV
E_MeV = E./(1.6e-13);

%% Vari Plots

%% Andamento Energia nel tempo
figure(2)
t = linspace(0,T_tot,length(E));
plot(t, E_trg_MeV*ones(length(t)), LineWidth=2);
grid on
title 'Energia(t)'
hold on
plot(t,E_MeV);
xlabel 't [s]'
ylabel 'E [MeV]'
legend '18MeV' '1' '2' '3' '4' '5';

%% Andamento Velocità nel tempo
figure(3)
t = linspace(0,T_tot,length(v));
plot(t,v);
grid on
hold on
title 'Velocità(t)'
xlabel 't [s]'
ylabel 'v [m/s]'
legend '1' '2' '3' '4' '5';

%% Andamento Raggio nel tempo
figure(4)
t = linspace(0,T_tot,length(R));
plot(t,R);
hold on
grid on
title 'Raggio(t)'
xlabel 't [s]'
ylabel 'r [m]'
legend '1' '2' '3' '4' '5';

%% Andamento Omega nel tempo
% Atteso costante
figure(5)
t = linspace(0,T_tot,length(omega)-1);
plot(t,omega(:,2:end));
hold on
grid on
title 'Omega(t)'
xlabel 't [s]'
ylabel 'omega [rad/s]'
legend '1' '2' '3' '4' '5';

%% MMM
T_rec = [T_rec T_tot]
% figure(6)
% tempo_di_permanenza = strcat('Tempo di permanenza per p+ =', {' '}, num2str(T_tot));
% text(0.5,0.5,tempo_di_permanenza,"HorizontalAlignment","center");

end







