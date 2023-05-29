clc
load n_1m.mat
n=1;

E = 1000*(n1m(:,2) + n1m(:,1))/(2);
dE = n1m(:,2) - n1m(:,1);
Area = 1400000;
flux = n1m(:,3).*dE*Area*n;
err = n1m(:,4);

cond = flux>0; %condizione di rilevanza

figure(2)
errorbar(E(cond),flux(cond),err(cond).*flux(cond)/100, 'o');
title 'flux of n outside the bunker'


fqs = 2.5 + 18.2*exp((-log(E).^2)./6);
fq = sum(fqs.*flux)/sum(flux)
