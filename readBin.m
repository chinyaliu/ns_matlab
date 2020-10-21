close all; clear all; clc;
% fid = fopen('postdata\out_inrank.dat');
fid = fopen('postdata\out_inputNS.dat');
% fid = fopen('postdata\out_run4.dat');
M = fread(fid,1,'int');
N = fread(fid,1,'int');
Re = fread(fid,1,'real*8');
dt = fread(fid,1,'real*8');
T = fread(fid,1,'real*8');
i = 1;
while ~feof(fid)
    ns(i).t = fread(fid,1,'real*8');
    u = fread(fid,M*N,'real*8');
    if isempty(u)
        break;
    end
    ns(i).u = reshape(u,[N M]);
    w = fread(fid,M*N,'real*8');
    ns(i).w = reshape(w,[N M]);
    p = fread(fid,M*N,'real*8');
    ns(i).p = reshape(p,[N M]);
    vort = fread(fid,M*N,'real*8');
    ns(i).vort = reshape(vort,[N M]);
    dV = fread(fid,M*N,'real*8');
    ns(i).dV = reshape(dV,[N M]);
    i = i+1;
end
fclose(fid);
ns = ns(1:end-1);
save('testNS.mat','ns','M','N','Re','dt');