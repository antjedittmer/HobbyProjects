function [x0,nv] = plotStars
% draw the circle
close all;

% clear; clc;
x0 = 10000;
%x = -x0:x0;
%y1 = sqrt(x0^2-x.^2
%y2 = - sqrt(x0^2-x.^2);

% user settings
ratio = 0.5; % inner circle
nv = 8; % number of vertex points
[rxVec, ryVec,rx,ry,x,y1,y2,rx1,ry1] = plotStar(x0,ratio,nv);

% plot an inner star
ratio = 0.15;
[rxVec1, ryVec1] = plotStar(0.1*x0,ratio,nv);

% plot a circle on each line
r1 = x0/20;
xM = x0/3;
[rxMatrix,ry1Matrix,ry2Matrix] = getCircle(r1,nv,xM);

% 2nd circle on each line
r1 = x0/15;
xM = 2*x0/3;
[rxMatrix1,ry1Matrix1,ry2Matrix1] = getCircle(r1,nv,xM);

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

plot(rxVec1,ryVec1,'b');

for idx = 0: nv-1
    x1 = rxMatrix(idx +1,:);
    y1 = ry1Matrix(idx+1,:);
    y2 = ry2Matrix(idx+1,:);
    plot(x1,y1,'b',x1,y2,'b');
end

for idx = 0: nv-1
    x1 = rxMatrix1(idx +1,:);
    y1 = ry1Matrix1(idx+1,:);
    y2 = ry2Matrix1(idx+1,:);
    plot(x1,y1,'b',x1,y2,'b');
end
hold off

hFig =figure(2);

plot(rxVec,ryVec,'k');
axis tight;
set(gcf, 'position',[360   149   523   523]);
hold on;


plot(rxVec1,ryVec1,'k');

for idx = 0: nv-1
    x1 = rxMatrix(idx +1,:);
    y1 = ry1Matrix(idx+1,:);
    y2 = ry2Matrix(idx+1,:);
    plot(x1,y1,'k',x1,y2,'k');
end

for idx = 0: nv-1
    x1 = rxMatrix1(idx +1,:);
    y1 = ry1Matrix1(idx+1,:);
    y2 = ry2Matrix1(idx+1,:);
    plot(x1,y1,'k',x1,y2,'k');
end
hold off
saveas(hFig,'sternchen.pdf')

%% subfunctions
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

function [rxMatrix,ry1Matrix,ry2Matrix] = getCircle(r1,nv,xM)


x1a = (-r1:r1);
x1 = x1a + xM;
y1 = sqrt(r1^2 - (x1a).^2);
y2 = -sqrt(r1^2 - (x1a).^2);

ln = length(x1);

rxM = nan(nv,1);
ryM = nan(nv,1);
rxMatrix = nan(nv,ln);
ry1Matrix = nan(nv,ln);
ry2Matrix = nan(nv,ln);
for idx = 0: nv-1
    aAlpha = idx * 2*pi/nv;
        
    rxM(idx+1) = xM* cos(aAlpha);
    ryM(idx+1) = xM* sin(aAlpha);
    
    rxMatrix(idx +1,:) = x1a' + rxM(idx+1);
    ry1Matrix(idx+1,:) = y1' + ryM(idx+1);
    ry2Matrix(idx+1,:) = y2' + ryM(idx+1);
end