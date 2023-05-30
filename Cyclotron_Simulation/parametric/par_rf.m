r_f = [];
B_vect = 0.5:0.05:2.5;

for jj=1:length(B_vect)
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
V = 12.5e3; %V
% Campo magnetico nei settori
B = B_vect(jj);

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
% Raggio finale
r_f = [r_f R(end)];
end

figure(1)
plot(B_vect, r_f);
hold on
grid on
title 'r_f(t) al variare di B'
xlabel 'B [T]'
ylabel 'r_f [m]'



