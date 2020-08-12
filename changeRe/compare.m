close all; clear all; clc;
load('Euler_t\testNS.mat');
inEu = struct2table(incase);
load('RK2_t\testNS.mat');
inRK2 = struct2table(incase);
load('RK3_t\testNS.mat');
inRK3 = struct2table(incase);

re = inEu.Re;
fig1 = figure('position',[50,50,1280,720]);
% semilogy(re,inEu.max_err,'-ko','linewidth',1,'Displayname','Euler');
% hold on
% semilogy(re,inRK2.max_err,'-bo','linewidth',1,'Displayname','2nd-order RK');
% semilogy(re,inRK3.max_err,'-ro','linewidth',1,'Displayname','3rd-order RK');
for i = 1:length(incase)
    eEu(i) = inEu.ns(i,6).max_err;
    eRK2(i) = inRK2.ns(i,6).max_err;
    eRK3(i) = inRK3.ns(i,6).max_err;
end
semilogy(re,eEu,'-ko','linewidth',1,'Displayname','Euler');
hold on
semilogy(re,eRK2,'-bo','linewidth',1,'Displayname','2nd-order RK');
semilogy(re,eRK3,'-ro','linewidth',1,'Displayname','3rd-order RK');

load('Euler\testNS.mat');
inEu = struct2table(incase);
load('RK2\testNS.mat');
inRK2 = struct2table(incase);
load('RK3\testNS.mat');
inRK3 = struct2table(incase);
% semilogy(re,inEu.max_err,'--k*','linewidth',1,'HandleVisibility','off');
% semilogy(re,inRK2.max_err,'--b*','linewidth',1,'HandleVisibility','off');
% semilogy(re,inRK3.max_err,'--r*','linewidth',1,'HandleVisibility','off');
for i = 1:length(incase)
    eEu(i) = inEu.ns(i,6).max_err;
    eRK2(i) = inRK2.ns(i,6).max_err;
    eRK3(i) = inRK3.ns(i,6).max_err;
end
semilogy(re,eEu,'--k*','linewidth',1,'HandleVisibility','off');
hold on
semilogy(re,eRK2,'--b*','linewidth',1,'HandleVisibility','off');
semilogy(re,eRK3,'--r*','linewidth',1,'HandleVisibility','off');
hold off
xlabel('Re','fontsize',14');
ylabel('error','fontsize',14');
xticks(100:100:1000);
legend('location','southeast','fontsize',14');
title('Numerical solution error with analytical solution','fontsize',14');
grid on;
% print(fig1,'err16','-r800','-dpng');