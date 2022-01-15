
function plotStars
% draw the circle
% clear; close all; clc;
x0 = 10000;
%x = -x0:x0;
%y1 = sqrt(x0^2-x.^2);
%y2 = - sqrt(x0^2-x.^2);

% user settings
ratio = 0.45; % inner circle
nv = 8; % number of vertex points
[rxVec, ryVec,rx,ry,x,y1,y2,rx1,ry1] = plotStar(x0,ratio,nv);

% Plot
figure(1)
plot(x,y1,'k--',x,y2,'k--');
axis tight;
set(gcf, 'position',[360   149   523   523]);
hold on;

plot(rx,ry,'r*');
plot(x,y1,'k-.',x,y2,'k-.');
plot(rx1,ry1,'ro');
plot(rxVec,ryVec);


function [rxVec, ryVec,rx,ry,x,y1,y2,rx1,ry1] = plotStar(x0,ratio,nv)
% draw the vertex points 
offset = 0;
[rx,ry] = getStar(x0,nv,offset);

% plot inner circle
x0 = ratio * 10000;
x = -x0:x0;
y1 = sqrt(x0^2-x.^2);
y2 = - sqrt(x0^2-x.^2);
offset = pi/nv;
[rx1,ry1] = getStar(x0,nv,offset);

% connest inner and out points
rxAll = [rx';rx1'];
ryAll = [ry';ry1'];
rxVec = [rxAll(:);rxAll(1)];
ryVec = [ryAll(:);ryAll(1)];

function [rx,ry] = getStar(x0,nv,offset)
rx = nan(nv,1);
ry = nan(nv,1);
for idx = 0: nv-1
    aAlpha = idx * 2*pi/nv + offset;
    rx(idx+1) = x0* cos(aAlpha);
    ry(idx+1) = x0* sin(aAlpha);
end

