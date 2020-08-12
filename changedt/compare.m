close all; clear all; clc;
load('postdata_Eu\testNS.mat');
inEu = struct2table(incase);
load('postdata_RK\testNS.mat');
inRK2 = struct2table(incase);
load('postdata_SSPRK\testNS.mat');
inRK3 = struct2table(incase);

dt = inEu.dt;
fig1 = figure('position',[50,50,1280,720]);
semilogy(dt,inEu.pe,'-ko','linewidth',1,'Displayname','Euler');
hold on
semilogy(dt,inRK2.pe,'-bo','linewidth',1,'Displayname','2nd-order RK');
semilogy(dt,inRK3.pe,'-ro','linewidth',1,'Displayname','SSP-RK');
hold off
xlabel('\Deltat','fontsize',14');
ylabel('error','fontsize',14');
xticks([0 0.005 0.01:0.01:0.05]);
legend('location','southeast','fontsize',14');
title('Numerical solution error with analytical solution','fontsize',14');
grid on;
print(fig1,'err16re100t2','-r800','-dpng');