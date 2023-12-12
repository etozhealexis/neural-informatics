clear;
close all;

t = 1:0.01:4.5;

x = @(t) cos(cos(t) .* t.^2 - t);

x = x(t);

graph = plot(t, x); grid;

[trainInd, valInd] = divideind(size(x,2), 1:276, 277:5501);

Trx = t(trainInd);
Valx = t(valInd);

Try = x(trainInd);
Valy = x(valInd);

net = feedforwardnet(40);
configure(net, [1, 4.5], [-1, 1]);

net.layers{2}.transferFcn = 'tansig';
net.trainFcn = 'traincgf';
net.divideFcn = 'divideind';

net.divideParam.trainInd = 1:size(Trx, 2);
net.divideParam.valInd = size(Trx, 2) + 1:size(Valx, 2);
net.divideParam.testInd = [];

display(net);
view(net);

init(net);

net.trainParam.epochs = 300;
net.trainParam.max_fail = 300;
net.trainParam.goal = 1e-8;

P = [Trx, Valx];
T = [Try, Valy];

[net, tr] = train(net, P, T);

plotperf(tr);

xr = sim(net, Trx);
xv = sim(net, Valx);

second_part = figure;
graph = plot(t, x, Trx, xr, Valx, xv); grid;

uiwait(second_part);