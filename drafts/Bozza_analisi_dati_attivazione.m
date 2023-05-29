load attivita_t0.mat
A = RUN42tab(:,1);
Z = RUN42tab(:,2);
Bq_cmc = RUN42tab(:,3);
prec_100 = RUN42tab(:,4);

Bq = Bq_cmc;

prec_Bq = Bq.*(prec_100/100);

plot3(A,Z,log10(Bq), '*');

vol_acqua = pi*0.6^3;
vol_ag = pi*(0.6+25e-4)^3 - vol_acqua;
vol_avional = pi*(0.6+50e-4)^3 - vol_acqua;
vol_ti = pi*0.6^2*25e-4;
vol_havar=vol_ti;
%% valuto se le attivita  con alto errore sono rilvanti
A_err_5 = A(prec_100>5);
Z_err_5 = Z(prec_100>5);
Bq_err_5 = Bq(prec_100>5);

delta = max(Bq) - max(Bq_err_5) % ok, lol, no

%% investigo su 28-13 (Al-28)
disp('Al28')
Al28 = A==28 & Z==13;
Bq(Al28).*vol_avional
prec_100(Al28)

%% investigo su 24-11 (Na-24)
disp('Na24')
Na24 = A==24 & Z==11;
Bq(Na24)
prec_100(Na24)

%% investigo su 31-14 (Si-31)
disp('Si31')
Si31 = A==31 & Z==14;
Bq(Si31).*vol_avional
prec_100(Si31)

%% investigo su 17-9 (F-17)
disp('F17')
F19 = A==17 & Z==9;
Bq(F19).*vol_acqua
prec_100(F19)

%% investigo su 17-9 (Ag-110)
disp('F17')
F19 = A==17 & Z==9;
Bq(F19).*vol_acqua
prec_100(F19)

%% investigo su 25-51 (Mn51)
disp('Mn51')
Mn51 = A==51 & Z==25;
Bq(Mn51).*vol_havar
prec_100(Mn51)

%% investigo su 29-58 (Cu58)
disp('Cu58')
Cu58 = A==58 & Z==29;
Bq(Cu58).*vol_avional
prec_100(Cu58)

%% investigo su 29-60 (Cu60)
disp('Cu60')
Cu60 = A==60 & Z==29;
Bq(Cu60).*vol_avional
prec_100(Cu60)

%% investigo su 47-108 (Ag108)
disp('Ag108')
Ag108 = A==108 & Z==47;
Bq(Ag108).*vol_ag
prec_100(Ag108)

%% investigo su 47-110 (Ag110)
disp('Ag110')
Ag110 = A==110 & Z==47;
Bq(Ag110).*vol_ag
prec_100(Ag110)


%% investigo su 18-9 (F-18)
clc
F18 = A==18 & Z==9;
A_0 = Bq(F18).*vol_acqua;
prec_100(F18)

lamda_F18 = log(2)/(109.771*60);

A_0 = A_0/1e9

t=0:3600*24;

A_F18 = (A_0*exp(-lamda_F18.*t));

plot(t,A_F18);
hold on
t_points=0:3600:3600*24;
A_F18_points = (A_0*exp(-lamda_F18.*t_points));
plot(t_points,A_F18_points,'*');
