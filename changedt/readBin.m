close all; clear all; clc;
files = dir('out_run*.dat');
for j=1:length(files)
    fid = fopen(files(j).name);
    M = fread(fid,1,'int');
    N = fread(fid,1,'int');
    incase(j).Re = fread(fid,1,'real*8');
    incase(j).dt = fread(fid,1,'real*8');
    incase(j).T = fread(fid,1,'real*8');
    i = 1;
    while ~feof(fid)
        incase(j).ns(i).t = fread(fid,1,'real*8');
        u = fread(fid,M*N,'real*8');
        if isempty(u)
            break;
        end
        incase(j).ns(i).u = reshape(u,[N M]);
        w = fread(fid,M*N,'real*8');
        incase(j).ns(i).w = reshape(w,[N M]);
        p = fread(fid,M*N,'real*8');
        incase(j).ns(i).p = reshape(p,[N M]);
%         fu = fread(fid,M*N,'real*8');
%         incase(j).ns(i).fu = reshape(fu,[N M]);
%         fw = fread(fid,M*N,'real*8');
%         incase(j).ns(i).fw = reshape(fw,[N M]);
%         q = fread(fid,M*N,'real*8');
%         incase(j).ns(i).q = reshape(q,[N M]);
%         dV = fread(fid,M*N,'real*8');
%         incase(j).ns(i).dV = reshape(dV,[N M]);
        vort = fread(fid,M*N,'real*8');
        incase(j).ns(i).vort = reshape(vort,[N M]);
        i = i+1;
    end
    fclose(fid);
    incase(j).ns = incase(j).ns(1:end-1);
end
T = struct2table(incase);
T = sortrows(T,'dt');
incase = table2struct(T);
save('testNS.mat','incase','M','N');