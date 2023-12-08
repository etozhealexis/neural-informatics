clear all;
close all;

x = @ (t) sin(sin(t).*t.^2 - 2.*t + 7);

t1 = 0:0.02:4;

P = x(t1);

plot(t1, P, '.-'); grid;

for i = 1:3
    Pi(i) = P(i);
end

for i = 1:size(P, 2) - 3
    PM(i) = P(i + 2);
end

for i = 1:size(P, 2) - 3
    PM1(i) = P(i + 3);
end

% 1 / максимальное ограничение сверху
lr = maxlinlr(P, 'bias');

% линейная сеть, вход, выход, задержки, максимальная скорость
net = newlin([-1, 1], [-1, 1], [1 2 3], lr);

% Инициализация сети случайными значениями
net.inputweights{1, 1}.initFcn = 'rands';
net.biases{1}.initFcn = 'rands';

net = init(net);

IW = net.IW{1, 1};
b = net.b{1};

M1 = sqrt(mse(P - net(P)));

Pi = con2seq(Pi);
PM = con2seq(PM);
PM1 = con2seq(PM1);
P = con2seq(P);

% точность + обучение
net.trainParam.goal = 1E-6;
net.trainParam.epochs = 600;
net = train(net, PM, PM1, Pi);

Y = net(P);

Y = seq2con(Y); Y = Y{1};
PM = seq2con(PM); PM = PM{1};
P = seq2con(P); P = P{1};

t3 = 0.02:0.02:4.02;
X = x(t3);

E = X - Y;

M2 = sqrt(mse(Y-X));

figure;

subplot(211);
plot(t1, P, 'b', t1, Y, 'r--'); grid;

subplot(212);
plot(t3, E, 'g'); grid;


% Формирование набора данных для прогноза
t4 = 0:0.02:4.4;
P1 = x(t4);
P2 = con2seq(P1);
Y1 = sim(net, P2);

Y1 = seq2con(Y1); Y1 = Y1{1};
P2 = seq2con(P2); P2 = P2{1};
E1 = Y1 - P2;

M3 = sqrt(mse(Y1 - P2));

figure

subplot(211);
plot(t4, P2, 'b', t4, Y1, 'r--'); grid;

subplot(212)
plot(t4, E1, 'g'); grid;

