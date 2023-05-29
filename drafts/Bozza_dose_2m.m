%%
conv = 1.602176462E-7; %GeV/g --> Gy

pr = 3600*3.121e14; % # primari

%% Fotoni
in_hf = 3.7485E-15;
Dose_hf_inside = in_hf*pr*conv %fattore di quaalità dei fotoni è 1 Gy == Sv

out_hf = 1.4422E-15;
Dose_hf_outside = out_hf*pr*conv %fattore di quaalità dei fotoni è 1 Gy == Sv


%% Neutroni
% per avere dose dei neutroni, run prima dal Analisi_hf_out, la sezione che serve (n_in oppure n_out) 
% poi runna questo, per calcolare fq.
% per avere la dose equivalente in Sv, Dose_n[inise/outside] * fq !!!!
fqs = 2.5 + 18.2*exp((-log(E).^2)./6);
fq = sum(fqs.*flux)/sum(flux);
out_n = 2.0267E-12;
in_n = 1.3020E-11;
Dose_n_inside = in_n*pr*conv;
Dose_n_outside = out_n*pr*conv;

