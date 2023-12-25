close all;
clear all;

t = 0:0.01:2.5;

x = cos(cos(t) .* t.^2 - t);

% gr = plot(t, x); grid;
% set(gr(1), 'LineStyle', '-', 'Color', 'r', 'LineWidth', 2);

%рыхлый набор данных
[trainInd, testInd] = dividerand(size(x, 2), 0.8, 0.2);
% [trainInd, testInd] = divideind(size(x, 2), 1:225, 226:251);

Trx = t(trainInd);
Tsx = t(testInd);

Try = x(trainInd);
Tsy = x(testInd);

spread = 0.01;

net = newgrnn(Trx,Try,spread);

display(net);

% view(net);
xr = sim(net, Trx);
xs = sim(net, Tsx);

figure;
gr2 = plot(t, x, Trx, xr, Tsx, xs); grid;

set(gr2(1), 'LineStyle', '-', 'Color', 'r', 'LineWidth', 2);
set(gr2(2),  'Marker', 'o', 'Color', 'g', 'LineWidth', 1, 'LineStyle', 'none');
set(gr2(3),  'Marker', 'o', 'Color', 'b', 'LineWidth', 1, 'LineStyle', 'none');

err1 = abs(Try-xr);
err2 = abs(Tsy-xs);

figure;
gr3 = plot(Trx, err1, Tsx, err2); grid;

set(gr3(1),  'Marker', 'o', 'Color', 'g', 'LineWidth', 1, 'LineStyle', 'none');
set(gr3(2),  'Marker', 'o', 'Color', 'b', 'LineWidth', 1, 'LineStyle', 'none');
