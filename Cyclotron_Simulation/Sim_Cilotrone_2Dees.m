% Hello World
clear
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
V = 12e3; %V
% Campo magnetico nei settori
B = 1.5;

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

figure(1)

while ii<50

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

% Calcolo centro della traiettoria semicircolare
new_x = x(end) - (-R(end-1) + R(end))*(-1)^ii;
x = [x new_x];
% Plot della traiettoria nel gap: moto rettilineo
y_plot_g = linspace(-gap/2,gap/2,n_plot);

if (-1)^ii == 1
x_plot_g = ones(length(y_plot_g))*x(end-1)  + R(end-1);
else
x_plot_g = ones(length(y_plot_g))*x(end-1) - R(end-1);
end

%plot(x_plot_g(1,:), y_plot_g);

hold on

% Plot della traiettoria nei settori: moto circolare
t_plot = linspace(0,new_t_dee, n_plot);
% Trovo i punti con coords cilindriche
x_plot = (new_R*cos(new_omega*t_plot)) + new_x;
y_plot = (new_R*sin(new_omega*t_plot) + gap/2)*(-1)^ii;
% Plot

if (-1)^ii == 1
    %comet(x_plot,y_plot);
    %plot(x_plot,y_plot);

else
    x_plot = x_plot(:,end:-1:1);
    %comet(x_plot,y_plot);
    %plot(x_plot,y_plot);

end

figure(1)
filename = 'mygif.gif';
      plot(x_plot_g(1,:), y_plot_g);
      hold on
      plot(x_plot,y_plot);
      axis([-0.1 0.1 -0.1 0.1]) ;
      drawnow
      frame = getframe(1);
      im = frame2im(frame);
      [imind,cm] = rgb2ind(im,256);
      if ii == 0
          imwrite(imind,cm,filename,'gif','DelayTime',0.1, 'Loopcount',inf);
      else
          imwrite(imind,cm,filename,'gif','DelayTime',0.1, 'WriteMode','append');
      end


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
plot(t,E_MeV);
grid on
title 'Energia(t)'
hold on
plot(t, E_trg_MeV*ones(length(t)), LineWidth=2);
xlabel 't [s]'
ylabel 'E [MeV]'
legend 'Energia' '18MeV';

%% Andamento Velocità nel tempo
figure(3)
t = linspace(0,T_tot,length(v));
plot(t,v);
grid on
title 'Velocità(t)'
xlabel 't [s]'
ylabel 'v [m/s]'

%% Andamento Raggio nel tempo
figure(4)
t = linspace(0,T_tot,length(R));
plot(t,R);
grid on
title 'Raggio(t)'
xlabel 't [s]'
ylabel 'r [m]'

%% Andamento Omega nel tempo
% Atteso costante
figure(5)
t = linspace(0,T_tot,length(omega)-1);
plot(t,omega(:,2:end));
grid on
title 'Omega(t)'
xlabel 't [s]'
ylabel 'omega [rad/s]'

%% MMM
figure(6)
tempo_di_permanenza = strcat('Tempo di permanenza per p+ =', {' '}, num2str(T_tot));
text(0.5,0.5,tempo_di_permanenza,"HorizontalAlignment","center");





















