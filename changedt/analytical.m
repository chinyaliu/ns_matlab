close all; clear all; clc;
load('testNS.mat');
Re = incase(1).Re;
x = 2*pi*(0:M-1)/M;
y = 2*pi*(0:N-1)/N;
[X,Y] = meshgrid(x,y);
F = @(t) exp(-2*t/Re);
u = @(t) sin(X).*cos(Y).*F(t);
w = @(t) -cos(X).*sin(Y).*F(t);
p = @(t) 0.25*(cos(2*X)+cos(2*Y)).*(F(t).^2);
for j = 1:length(incase)
    for i = 1:length(incase(j).ns)
        u_err(i) = max(abs(u(incase(j).ns(i).t)-incase(j).ns(i).u),[],'all');
        w_err(i) = max(abs(w(incase(j).ns(i).t)-incase(j).ns(i).w),[],'all');
        p_err(i) = max(abs(p(incase(j).ns(i).t)-incase(j).ns(i).p),[],'all');
        cases(j).t(i) = incase(j).ns(i).t;
    end
    incase(j).ue = max(u_err);
    incase(j).ue(sum(isnan(u_err))>0) = nan;
    incase(j).we = max(w_err);
    incase(j).we(sum(isnan(w_err))>0) = nan;
    incase(j).pe = max(p_err);
    incase(j).pe(sum(isnan(p_err))>0) = nan;
end
T = struct2table(incase);
pe = T.pe;
ue = T.ue;
we = T.we;
dt = T.dt;
save('testNS.mat','incase','M','N');
fig1 = figure('position',[50,50,1280,720]);
semilogy(dt,pe,'-ko','linewidth',1);
xlabel('\Deltat','fontsize',14');
ylabel('error','fontsize',14');
xticks([0 0.005 0.01:0.01:0.05]);
title('Numerical solution error with 2nd-order Runge-Kutta method','fontsize',14');
grid on;
% print(fig1,'err2oRK','-r800','-dpng');
fig2 = figure('position',[50,50,1280,720]);
semilogy(cases(end).t,p_err,'-ko','linewidth',1);
xlabel('t','fontsize',14');
ylabel('error','fontsize',14');
% xticks([0 0.001 0.0075 0.01:0.01:0.05]);
title('Numerical solution error with Runge-Kutta methods','fontsize',14');
% xlim([0 0.05^3]);
grid on;