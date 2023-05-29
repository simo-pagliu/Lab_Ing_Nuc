%% 
n = 3.121e14; % #/s
irr_time = 3600; % s

%% hf outside
clc
load hf_flux_out.mat

E = linspace(0.1,18,1000000);
dE = (E(2) - E(1))*1e-3;
Area = 1400000;


flux = RUN35tab(:,3)*dE*Area*n;
err = RUN35tab(:,4);

cond = err<50 & flux>0; %condizione di rilevanza

figure(1)
%errorbar(E(cond),flux(cond),err(cond).*flux(cond)/100, 'o');
plot(E,flux)
title 'flux of hf outside the bunker'

tot_flux = sum(flux)
disp('[#/s]')
tot_pr = tot_flux*irr_time
disp('[#]')

%tot_fluence = n*irr_time*1.1348170E-10 %1m
%tot_fluence = n*4.2750629E-12*irr_time %1.5m
tot_fluence = n*irr_time*1.5810613E-13 %2m
disp('[#/cm2]')
tot_err_fluence = 2.471319
disp('[%]')

%% n outside
clc
load n_flux_out.mat

E = 1000*(RUN34tab(:,2) + RUN34tab(:,1))/(2);
dE = RUN34tab(:,2) - RUN34tab(:,1);
Area = 1400000;
flux = RUN34tab(:,3).*dE*Area*n;
err = RUN34tab(:,4);

cond = flux>0; %condizione di rilevanza

figure(2)
%errorbar(E(cond),flux(cond),err(cond).*flux(cond)/100, 'o');

title 'flux of n outside the bunker'

tot_flux = sum(flux)
disp('[#/s]')
tot_pr = tot_flux*irr_time
disp('[#]')
tot_fluence = n*irr_time*1.0144366E-13
%tot_fluence = n*8.6752399E-13*irr_time %1m 
%tot_fluence = n*1.4619779E-14*irr_time %1.5m

disp('[#/cm2]')
tot_err_fluence = 59.91163
disp('[%]')


%% hf inside
clc
load hf_flux_in.mat

E = linspace(0.1,18,1000000);
dE = (E(2) - E(1))*1e-3;
Area = 3.39292002;
flux = RUN32tab(:,3).*dE*Area*n;
err = RUN32tab(:,4);

cond = err < 5 & flux>0; %condizione di rilevanza

figure(3)
errorbar(E(cond),flux(cond),(err(cond).*flux(cond)/100), 'o');
title 'flux of hf inside the bunker'

tot_flux = sum(flux)
disp('[#/s]')
tot_pr = tot_flux*irr_time
disp('[#]')
tot_fluence = n*2.2464328E-02
disp('[#/cm2]')
tot_err_fluence = 6.1851852E-02
disp('[%]')


%% n inside
clc
load n_flux_in.mat

E = 1000*(RUN30tab(:,2) + RUN30tab(:,1))/2;
dE = (RUN30tab(:,2) - RUN30tab(:,1))/2; 
Area = 3.39292002;
flux = RUN30tab(:,3).*dE*Area*n;
err = RUN30tab(:,4);

cond = err < 20 & flux>0; %condizione di rilevanza

figure(4)
%errorbar(E(cond),flux(cond),err(cond).*flux(cond)/100, 'o');
semilogy(E,flux.*E)
title 'flux of n inside the bunker'

tot_flux = sum(flux)
disp('[#/s]')
tot_pr = tot_flux*irr_time
disp('[#]')
tot_fluence = n*1.3453056E-02
disp('[#/cm2]')
tot_err_fluence = 5.6543883e-02
disp('[%]')


