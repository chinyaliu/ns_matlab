close all; clear all; clc;
load('testNS.mat');
x = 2*pi*(0:N-1)/N;
y = 2*pi*(0:M-1)/M;
[X,Y] = meshgrid(x,y);
[X2,Y2] = meshgrid(x,y(2:end-1));
F = @(t) exp(-2*t/Re);
u = @(t) sin(X).*cos(Y).*F(t);
w = @(t) -cos(X).*sin(Y).*F(t);
p = @(t) 0.25*(cos(2*X)+cos(2*Y)).*(F(t).^2);
labelname = {'$-\frac{N}{2}$';'$-\frac{N}{4}$';'0';'$\frac{N}{4}$';'$\frac{N}{2}-1$'};
for i = 1:length(ns)
    fig1 = figure('position',[100,100,1740,720], 'Visible', 'off');
    subplot('position',[0.1 0.1 0.35 0.75]);
    f = fft2(ns(i).u);
    f2 = fft2(ns(i).p);
%     f = fft2(ns(i).u);
%     f2 = fft2(u(ns(i).t));
    f = [f(N/2+1:end,:);f(1:N/2,:)];
    f = [f(:,N/2+1:end) f(:,1:N/2)];
    f2 = [f2(N/2+1:end,:);f2(1:N/2,:)];
    f2 = [f2(:,N/2+1:end) f2(:,1:N/2)];
    imagesc([-N/2 N/2-1], [-N/2 N/2-1], abs(f));
%     imagesc([-N/2 N/2-1], [-N/2 N/2-1], real(f));
    xlabel('m','fontsize',14);
    xticks([-N/2 -N/4 0 N/4 N/2-1]);
    ylabel('n','fontsize',14,'rotation',90);
    yticks(-N/2:2:N/2-1);
    yticks([-N/2 -N/4 0 N/4 N/2-1]);
    set(gca,'YDir','normal','xticklabel',labelname,'fontsize',12,'yticklabel',labelname,'fontsize',12,'TickLabelInterpreter','latex');
    colorbar;
    bottom = 0;
    top = 50;
    caxis manual
    caxis([bottom top]);
    title('numerical','fontsize',12);
    title('u','fontsize',12);
    subplot('position',[0.55 0.1 0.35 0.75]);
    imagesc([-N/2 N/2-1], [-N/2 N/2-1], abs(f2));
%     imagesc([-N/2 N/2-1], [-N/2 N/2-1], real(f2));
    set(gca,'YDir','normal','xticklabel',labelname,'fontsize',12,'yticklabel',labelname,'fontsize',12,'TickLabelInterpreter','latex');
    xlabel('m','fontsize',14);
    xticks([-N/2 -N/4 0 N/4 N/2-1]);
    ylabel('n','fontsize',14,'rotation',90);
    yticks([-N/2 -N/4 0 N/4 N/2-1]);
    colorbar;
    bottom = 0;
    top = 20;
    caxis manual
    caxis([bottom top]);
    title('analytical','fontsize',12);
    title('p','fontsize',12);
    tex = sprintf('t = %4.0f',ns(i).t);
    sgtitle(tex,'fontsize',14');
    
    Fm(i) = getframe(gcf) ;
end

% create the video writer with 1 fps
writerObj = VideoWriter('up','MPEG-4');
writerObj.FrameRate = 20;
% set the seconds per image
% open the video writer
open(writerObj);
% write the frames to the video
for i=1:length(Fm)
    % convert the image to a frame
    frame = Fm(i) ;    
    writeVideo(writerObj, frame);
end
% close the writer object
close(writerObj);