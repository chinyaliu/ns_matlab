close all; clear all; clc;
load('testNS.mat');
cl = {[0.8500 0.3250 0.0980],[0.9290 0.6940 0.1250],[0.4660 0.6740 0.1880],[0.3010 0.7450 0.9330]};
x = 2*pi*(0:incase(1).M-1)/incase(1).M;
y = 2*pi*(0:incase(1).N-1)/incase(1).N;
[X,Y] = meshgrid(x,y);
for j = 1:length(incase)
    Re = incase(j).Re;
    F = @(t) exp(-2*t/Re);
    u = @(t) sin(X).*cos(Y).*F(t);
    w = @(t) -cos(X).*sin(Y).*F(t);
    p = @(t) 0.25*(cos(2*X)+cos(2*Y)).*(F(t).^2);
    for i = 1:length(incase(j).ns)
        incase(j).ns(i).u_err = max(abs(u(incase(j).ns(i).t)-incase(j).ns(i).u),[],'all');
        incase(j).ns(i).w_err = max(abs(w(incase(j).ns(i).t)-incase(j).ns(i).w),[],'all');
        incase(j).ns(i).p_err = max(abs(p(incase(j).ns(i).t)-incase(j).ns(i).p),[],'all');
        d = [incase(j).ns(i).u_err incase(j).ns(i).w_err incase(j).ns(i).p_err];
        incase(j).ns(i).max_err = max(d);
        incase(j).ns(i).dV_err =  max(abs(incase(j).ns(i).dV),[],'all');
    end
%     plot(tp,p_err,'-o','linewidth',1,'DisplayName',num2str(Re),'Color',cl{mod(j,4)+1});
%     plot(tp,dV_err,'-.o','linewidth',1,'HandleVisibility','off','Color',cl{mod(j,4)+1});
    in(j).ns = struct2table(incase(j).ns);
    incase(j).ue = max(in(j).ns.u_err);
    incase(j).we = max(in(j).ns.w_err);
    incase(j).pe = max(in(j).ns.p_err);
    incase(j).max_err = max(in(j).ns.max_err);
end

T = struct2table(incase);
maxerr = T.max_err;
dR = T.Re;
save('testNS.mat','incase');

fig2 = figure('position',[50,50,1280,720]);
plot(in(1).ns.t*2/incase(1).Re,in(1).ns.max_err,'-o','linewidth',1,'Displayname',num2str(dR(1)));
hold on;
for i = 2:length(in)
    plot(in(i).ns.t*2/incase(i).Re,in(i).ns.max_err,'-o','linewidth',1,'Displayname',num2str(dR(i)));
end
hold off;
le = legend('location','southeast','fontsize',14');
le.Title.String = "Re";
xlabel('times e-folding length','fontsize',14');
ylabel('error','fontsize',14');
title('Numerical solution error with different Reynolds number','fontsize',14');
set(gca,'Yscale','log');
grid on;

fig1 = figure('position',[50,50,1280,720]);
plot(dR,maxerr,'-ko','linewidth',1);
xlabel('Re','fontsize',14');
ylabel('error','fontsize',14');
% xticks([2:2:10 20 40 80]);
title('Numerical solution error with different Reynolds number','fontsize',14');
set(gca,'Yscale','log');
% xlim([0 max(M)]);
grid on;
% print(fig1,'errEu','-r800','-dpng');

fig3 = figure('position',[50,50,1280,720]);
plot(in(1).ns.t,in(1).ns.dV_err,'-o','linewidth',1,'Displayname',num2str(dR(1)));
hold on;
for i = 2:length(in)
    plot(in(i).ns.t,in(i).ns.dV_err,'-o','linewidth',1,'Displayname',num2str(dR(i)));
end
hold off
legend('location','southeast','fontsize',14');
xlabel('t','fontsize',14');
ylabel('divergence of V','fontsize',14');
% xticks([2:2:10 20 40 80]);
title('Numerical solution error with different Reynolds number','fontsize',14');
set(gca,'Yscale','log');
% xlim([0 max(M)]);
grid on;
% print(fig3,'errEu','-r800','-dpng');