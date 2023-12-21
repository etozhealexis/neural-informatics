% I часть

clear;
close all;

t = -pi:0.025:pi;

% Эллипс 1
a1 = 0.4; b1 = 0.4; alpha1 = 0; x1_0 = 0.1; y1_0 = -0.15;
x1 = @(t) x1_0 + a1*cos(t)*cos(alpha1) + b1*sin(t)*sin(alpha1);
y1 = @(t) y1_0 + a1*cos(t)*sin(alpha1) + b1*sin(t)*cos(alpha1);

x1 = x1(t);
y1 = y1(t);

% Эллипс 2
a2 = 0.7; b2 = 0.7; alpha2 = 0; x2_0 = 0; y2_0 = 0;
x2 = @(t) x2_0 + a2*cos(t)*cos(alpha2) + b2*sin(t)*sin(alpha2);
y2 = @(t) y2_0 + a2*cos(t)*sin(alpha2) + b2*sin(t)*cos(alpha2);

x2 = x2(t);
y2 = y2(t);

% Парабола
p = 1; alpha3 = 0; x3_0 = -0.8; y3_0 = 0;
x3 = @(t) (t.^2 / (2*p))*cos(alpha3) - t*sin(alpha3)+x3_0;
y3 = @(t) (t.^2 / (2*p))*sin(alpha3) + t*cos(alpha3)+y3_0;

x3 = x3(t);
y3 = y3(t);

graph = plot(x1, y1, x2, y2, x3, y3);

set(graph(1), 'Linestyle', '-', 'Color', 'r');
set(graph(2), 'Linestyle', '-', 'Color', 'g');
set(graph(3), 'Linestyle', '-', 'Color', 'b');

k = size(t,2);
n1 = 60;
n2 = 100;
n3 = 120;

p1 = randperm(k, n1);
p2 = randperm(k, n2);
p3 = randperm(k, n3);

X1 = x1(p1);
Y1 = y1(p1);

X2 = x2(p2);
Y2 = y2(p2);

X3 = x3(p3);
Y3 = y3(p3);

figure;
graph = plot(x1, y1, x2, y2, x3, y3, X1, Y1, X2, Y2, X3, Y3);

set(graph(1), 'Linestyle', '-', 'Color', 'r');
set(graph(2), 'Linestyle', '-', 'Color', 'g');
set(graph(3), 'Linestyle', '-', 'Color', 'b');
set(graph(4), 'LineStyle','none', 'Marker', 'o', 'Color', 'r', 'MarkerEdgeColor', 'k', 'MarkerFaceColor', 'r', 'MarkerSize', 7);
set(graph(5), 'LineStyle','none', 'Marker', 'o', 'Color', 'g', 'MarkerEdgeColor', 'k', 'MarkerFaceColor', 'g', 'MarkerSize', 7);
set(graph(6), 'LineStyle','none', 'Marker', 'o', 'Color', 'b', 'MarkerEdgeColor', 'k', 'MarkerFaceColor', 'b', 'MarkerSize', 7);


[trainInd1, valInd1, testInd1] = dividerand(n1, 0.7, 0.2, 0.1);
[trainInd2, valInd2, testInd2] = dividerand(n2, 0.7, 0.2, 0.1);
[trainInd3, valInd3, testInd3] = dividerand(n3, 0.7, 0.2, 0.1);


train1X = X1(trainInd1);
train1Y = Y1(trainInd1);

train2X = X2(trainInd2);
train2Y = Y2(trainInd2);

train3X = X3(trainInd3);
train3Y = Y3(trainInd3);

% train1t = zeros(1, size(train1X, 2));
% train2t = zeros(1, size(train2X, 2));
% train3t = zeros(1, size(train3X, 2));

% Эталонные выходы
for i=1:size(train1X, 2)
    train1t(i,:) = [1, 0, 0];
end

for i=1:size(train2X, 2)
    train2t(i,:) = [0, 1, 0];
end

for i=1:size(train3X, 2)
    train3t(i,:) = [0, 0, 1];
end

% Контрольные множества
val1X=X1(valInd1);
val1Y=Y1(valInd1);

val2X=X2(valInd2);
val2Y=Y2(valInd2);

val3X=X3(valInd3);
val3Y=Y3(valInd3);

for i=1:size(val1X, 2)
    val1t(i,:) = [1, 0, 0];
end

for i=1:size(val2X, 2)
    val2t(i,:) = [0, 1, 0];
end

for i=1:size(val3X, 2)
    val3t(i,:) = [0, 0, 1];
end

% Тестовые множества
test1X=X1(testInd1);
test1Y=Y1(testInd1);

test2X=X2(testInd2);
test2Y=Y2(testInd2);

test3X=X3(testInd3);
test3Y=Y3(testInd3);

for i=1:size(test1X, 2)
    test1t(i,:) = [1, 0, 0];
end

for i=1:size(test2X, 2)
    test2t(i,:) = [0, 1, 0];
end

for i=1:size(test3X, 2)
    test3t(i,:) = [0, 0, 1];
end

figure;
graph = plot(x1, y1, x2, y2, x3, y3, X1, Y1, X2, Y2, X3, Y3, train1X, train1Y, train2X, train2Y, train3X, train3Y, val1X, val1Y, val2X, val2Y, val3X, val3Y, test1X, test1Y, test2X, test2Y, test3X, test3Y);

axis([-1.2 1.2 -1.2 1.2]);

set(graph(1), 'Linestyle', '-', 'Color', 'r');
set(graph(2), 'Linestyle', '-', 'Color', 'g');
set(graph(3), 'Linestyle', '-', 'Color', 'b');
set(graph(4), 'LineStyle','none', 'Marker', 'o', 'Color', 'r');
set(graph(5), 'LineStyle','none', 'Marker', 'o', 'Color', 'g');
set(graph(6), 'LineStyle','none', 'Marker', 'o', 'Color', 'b');
set(graph(7), 'LineStyle','none', 'Marker', 'o', 'Color', 'r', 'MarkerEdgeColor', 'k', 'MarkerFaceColor', 'r', 'MarkerSize', 7);
set(graph(8), 'LineStyle','none', 'Marker', 'o', 'Color', 'g', 'MarkerEdgeColor', 'k', 'MarkerFaceColor', 'g', 'MarkerSize', 7);
set(graph(9), 'LineStyle','none', 'Marker', 'o', 'Color', 'b', 'MarkerEdgeColor', 'k', 'MarkerFaceColor', 'b', 'MarkerSize', 7);
set(graph(10), 'LineStyle','none', 'Marker', 'V', 'Color', 'r', 'MarkerEdgeColor', 'k', 'MarkerFaceColor', 'r', 'MarkerSize', 7);
set(graph(11), 'LineStyle','none', 'Marker', 'V', 'Color', 'g', 'MarkerEdgeColor', 'k', 'MarkerFaceColor', 'g', 'MarkerSize', 7);
set(graph(12), 'LineStyle','none', 'Marker', 'V', 'Color', 'b', 'MarkerEdgeColor', 'k', 'MarkerFaceColor', 'b', 'MarkerSize', 7);
set(graph(13), 'LineStyle','none', 'Marker', 's', 'Color', 'r', 'MarkerEdgeColor', 'k', 'MarkerFaceColor', 'r', 'MarkerSize', 7);
set(graph(14), 'LineStyle','none', 'Marker', 's', 'Color', 'g', 'MarkerEdgeColor', 'k', 'MarkerFaceColor', 'g', 'MarkerSize', 7);
set(graph(15), 'LineStyle','none', 'Marker', 's', 'Color', 'b', 'MarkerEdgeColor', 'k', 'MarkerFaceColor', 'b', 'MarkerSize', 7);

trainX = [train1X, train2X, train3X];
trainY = [train1Y, train2Y, train3Y];

valX = [val1X, val2X, val3X];
valY = [val1Y, val2Y, val3Y];

testX = [test1X, test2X, test3X];
testY = [test1Y, test2Y, test3Y];


net = feedforwardnet(20);
net = configure(net, [-1.2, 1.2; -1.2,1.2], [0, 1; 0, 1; 0, 1]);

net.layers{2}.transferFcn = 'tansig';

net.trainFcn='trainrp';
net.divideFcn='divideind';

net.divideParam.trainInd = 1:size(trainX, 2);
net.divideParam.valInd = size(trainX, 2) + 1:size(valX, 2) + size(trainX, 2);
net.divideParam.testInd = size(valX, 2) + size(trainX, 2) + 1:size(testX, 2) + size(valX, 2) + size(trainX, 2);

display(net);
view(net);

init(net);

net.trainParam.epochs = 1500;
net.trainParam.max_fail = 15;
net.trainParam.goal = 1e-5;

X = [trainX];
Y = [trainY];

X = [trainX, valX, testX];
Y = [trainY, valY, testY];

P = [X; Y]';

T = [train1t; train2t; train3t; val1t; val2t; val3t; test1t; test2t; test3t];

net = train(net, P', T');



trx = [trainX; trainY];

tr = sim(net, trx);

for i=1:3
    for j=1:size(trx,2)
        if tr(i, j) < 0.5
            a(i, j) = 0;
        else
            a(i, j) = 1;
        end
    end
end

tt = [train1t; train2t; train3t]';

N = 0;

for i=1:size(trx, 2)
    if a(:,i) == tt(:,i)
        N = N + 1;
    end
end

display(N);


vlx = [valX; valY];

vl = sim(net, vlx);

for i=1:3
    for j=1:size(vlx,2)
        if vl(i, j) < 0.5
            b(i, j) = 0;
        else
            b(i, j) = 1;
        end
    end
end

vv = [val1t; val2t; val3t]';

K = 0;

for i=1:size(vlx, 2)
    if b(:,i) == vv(:,i)
        K = K + 1;
    end
end

display(K);


testx = [testX; testY];

te = sim(net, testx);

for i=1:3
    for j=1:size(testx,2)
        if te(i, j) < 0.5
            c(i, j) = 0;
        else
            c(i, j) = 1;
        end
    end
end

tete = [test1t; test2t; test3t]';

M = 0;

for i=1:size(testx, 2)
    if c(:,i) == tete(:,i)
        M = M + 1;
    end
end

display(M);

xs = -1.2:0.025:1.2;
ys = -1.2:0.025:1.2;

for i = 1:size(xs, 2)
    for j = 1:size(xs, 2)
        Xs(i, j) = xs(i);
        Ys(i, j) = ys(j);
    end
end
        
X = [];
for i = 1:size(xs, 2)
    X = [X, Xs(i,:)];
end
        
Y = [];
for i = 1:size(ys, 2)
    Y = [Y, Ys(i,:)];
end

Pp = [X; Y];

Zz = sim(net, Pp);

for i = 1:size(Zz, 1)
    for j = 1:size(Zz, 2)
        if Zz(i, j) < 0.5
            Oo(i, j) = 0;
        else
            Oo(i, j) = 1;
        end
    end
end

xa1 = [];
ya1 = [];

for i = 1:size(Zz, 2)
    if Oo(:,i)'==[1,0,0]
        xa1 = [xa1, X(i)];
        ya1 = [ya1, Y(i)];
    else
    end
end

xa2 = [];
ya2 = [];

for i = 1:size(Zz, 2)
    if Oo(:,i)'==[0,1,0]
        xa2 = [xa2, X(i)];
        ya2 = [ya2, Y(i)];
    else
    end
end

xa3 = [];
ya3 = [];

for i = 1:size(Zz, 2)
    if Oo(:,i)'==[0,0,1]
        xa3 = [xa3, X(i)];
        ya3 = [ya3, Y(i)];
    else
    end
end

view(net);

first_part = figure;

gr2 = plot(x1, y1, x2, y2, x3, y3, xa1, ya1, xa2, ya2, xa3, ya3);

set(graph(1), 'Linestyle', '-', 'Color', 'r');
set(graph(2), 'Linestyle', '-', 'Color', 'g');
set(graph(3), 'Linestyle', '-', 'Color', 'b');
set(graph(4), 'LineStyle','none', 'Marker', 'o', 'Color', 'r');
set(graph(5), 'LineStyle','none', 'Marker', 'o', 'Color', 'g');
set(graph(6), 'LineStyle','none', 'Marker', 'o', 'Color', 'b');

uiwait(first_part);