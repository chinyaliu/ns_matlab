close all; clear all; clc;
load('testNS.mat');
x = 2*pi*(0:N)/N;
y = 2*pi*(0:M)/M;
[X,Y] = meshgrid(y,x);
[X2,Y2] = meshgrid(y(1:end-1),x(1:end-1));
for i = 1:length(ns)
fig1 = figure('position',[100,100,1280,540]);%, 'Visible', 'off');
    a = ns(i).u./ns(1).u;
    sca = sum(a(a>=0&a<=1),'all')./sum(a>0&a<=1,'all');
    subplot('position',[0.08 0.1 0.4 0.8]);
    f1 = ns(i).vort;
    f1 = [f1;f1(1,:)];
    f1 = [f1,f1(:,1)];
    f2 = ns(i).p;
    f2 = [f2;f2(1,:)];
    f2 = [f2,f2(:,1)];
%     imagesc([0 2*pi],[0 2*pi],ns(i).vort);
    s = pcolor(X,Y,f1);
    s.FaceColor = 'interp';
    set(s,'edgecolor','none');
    set(gca,'YDir','normal');
    colorbar;
%     bottom = -2;
%     top = 2;
%     caxis manual
%     caxis([bottom top]);
    h = colorbar;
    ylabel(h,'\omega_z','fontsize',14,'rotation',0);
    hold on;
    quiver(X2,Y2,ns(i).u,ns(i).w,sca,'k','AutoScale','off');
    xlim([0 2*pi]);
    ylim([0 2*pi]);
    xlabel('x','fontsize',14);
    ylabel('z ','fontsize',14,'rotation',0);
    xticks(0:0.5*pi:2*pi);
    yticks(0:0.5*pi:2*pi);
    set(gca,'XTickLabel',{'0','0.5\pi','\pi','1.5\pi','2\pi'})
    set(gca,'YTickLabel',{'0','0.5\pi','\pi','1.5\pi','2\pi'})
    hold off;
    
    subplot('position',[0.55 0.1 0.4 0.8]);
%     imagesc([0 2*pi],[0 2*pi],ns(i).p);
%     s = pcolor(X2,Y2,ns(i).fw.');
    s = pcolor(X,Y,f2);
    s.FaceColor = 'interp';
    set(s,'edgecolor','none');
    set(gca,'YDir','normal');
    colorbar;
%     bottom = -0.5;
%     top = 0.5;
%     caxis manual
%     caxis([bottom top]);
    h = colorbar;
    ylabel(h,'p','fontsize',14,'rotation',0);
    hold on;
    quiver(X2,Y2,ns(i).u,ns(i).w,sca,'k','AutoScale','off');
    xlim([0 2*pi]);
    ylim([0 2*pi]);
    xlabel('x','fontsize',14);
    ylabel('z ','fontsize',14,'rotation',0);
    xticks(0:0.5*pi:2*pi);
    yticks(0:0.5*pi:2*pi);
    set(gca,'XTickLabel',{'0','0.5\pi','\pi','1.5\pi','2\pi'})
    set(gca,'YTickLabel',{'0','0.5\pi','\pi','1.5\pi','2\pi'})
    hold off;
    tex = sprintf('t = %4.0f T0',ns(i).t);
    sgtitle(tex,'fontsize',14');
    
    F(i) = getframe(gcf) ;
end

% % create the video writer with 1 fps
% writerObj = VideoWriter('truncate_1k001.mp4','MPEG-4');
% writerObj.FrameRate = 30;
% % set the seconds per image
% % open the video writer
% open(writerObj);
% % write the frames to the video
% for i=1:length(F)
%     % convert the image to a frame
%     frame = F(i) ;    
%     writeVideo(writerObj, frame);
% end
% % close the writer object
% close(writerObj);