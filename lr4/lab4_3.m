clear;
close all;

t = 1:0.01:4.5;

x = @(t) cos(cos(t) .* t.^2 - t);

x = x(t);

graph = plot(t, x); grid;

[trainInd, valInd, testInd] = dividerand(size(x,2), 0.8, 0, 0.2);
%[trainInd, testInd] = divideind(size(x,2), 1:1921, 1922:2401);

Trx = t(trainInd);
Testx = t(testInd);

Try = x(trainInd);
Testy = x(testInd);

spread = 0.01;
net = newgrnn(Trx, Try, spread);

display(net);
view(net); 

xr = sim(net, Trx);
xte = sim(net, Testx);

err1 = abs(Try - xr);
err2 = abs(Testy - xte);

mean1 = mean(err1);
mean2 = mean(err2);

figure;
gr = plot(Trx, err1, Testx, err2); grid;

third_part = figure;
graph = plot(t, x, Trx, xr, Testx, xte); grid;

uiwait(third_part);