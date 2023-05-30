% Hello World
clear
clc

%% Costanti

omega_runs=0;
T_tot=0;
cicli=0;

for V = [10e3:1e3:15e3]

% Carica del p+
q = 1.602e-19;
% Massa del p+
m = 1.67e-27;

% Parameteri

% Dimensione del gap
gap = 0.05;
% Tensione applicata nel gap
%V = 12e3; %V
% Campo magnetico nei settori
B = 1.6; %T

% Energia da raggiungere
E_trg_MeV = 18; %MeV
E_trg = E_trg_MeV*(1.6e-13); %MeV --> J

% Grandezze derivate dalle precedenti

% Campo elettrico applicato nel gap
E_campo = q*V;
% Variazione di velocità nel gap
dv_gap = sqrt(E_campo*2/m);

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

figure(1)

while E(end) < E_trg

% Nuova velocità
new_v = v(end) + dv_gap;
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
new_t_gap = gap/new_v;
% Salvo la somma dei due
T = [T new_t_dee+new_t_gap];

% Calcolo centro della traiettoria semicircolare
new_x = x(end) - (-R(end-1) + R(end))*(-1)^ii;
x = [x new_x];
% Plot della traiettoria nel gap: moto rettilineo
y_plot_g = linspace(-gap/2,gap/2,n_plot);

if (-1)^ii == 1
x_plot_g = ones(length(y_plot_g))*x(end-1)  + new_x + R(end);
else
x_plot_g = ones(length(y_plot_g))*x(end-1)  + new_x - R(end-1);
end

plot(x_plot_g(1,:), y_plot_g);

hold on

% Plot della traiettoria nei settori: moto circolare
t_plot = linspace(0,new_t_dee, n_plot);
% Trovo i punti con coords cilindriche
x_plot = (new_R*cos(new_omega*t_plot)) + new_x;
y_plot = (new_R*sin(new_omega*t_plot) + gap/2)*(-1)^ii;
% Plot

if (-1)^ii == 1
    %comet(x_plot,y_plot);
    plot(x_plot,y_plot);

else
    x_plot = x_plot(:,end:-1:1);
    %comet(x_plot,y_plot);
    plot(x_plot,y_plot);

end

% Incremento contatore
ii = ii + 1;

end


% Tempo di permanenza totale nel ciclotrone
T_tot = [T_tot sum(T)];
% Omega
omega_runs = [omega_runs new_omega];
%% Semi cicli
cicli = [cicli ii];

% Converto Energia anche in MeV
E_MeV = E./(1.6e-13);
save(strcat('E',num2str(V)),"E_MeV");

% Raggio finale traiettoria
save(strcat('R',num2str(V)),"R");

end

save('omega',"omega_runs");
save('cicli',"cicli");
save('Times',"T_tot");
