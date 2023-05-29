
clc

load bragg.mat

x = 10*(PiccoBraggTarget(:,1) + PiccoBraggTarget(:,2))/2 + 6.9883;
y = PiccoBraggTarget(:,3);

err = PiccoBraggTarget(:,4)/100;

nums = [1 2 3];
names = ['A' 'B' 'C'];

figure(1)
semilogy(x,y, LineWidth=2);
hold on;
title 'Deposito di energia'



%errorbar(x,y,err);
