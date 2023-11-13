clear all;
close all;

x = @ (t) sin(sin(t).*t.^2 - 2.*t + 7);

% h1 = 0.02
t1 = 0:0.02:4;

P = x(t1);

plot(t1, P, '.-'); grid;

%%% Входное множество
%%% Первые пять точек, на которые ориентируемся

for i = 1:5
    Pi(i) = P(6 - i);
end

%%% Остальные

for i = 1:size(P, 2) - 5
    PM(i) = P(i + 5);
end

%%%%%%%%%%%
%%% Сеть

% диапазон, вход, задержки, скорость обучения
net = newlin([0, 4], 1, [1 2 3 4 5], 0.05);

display(net);

% view(net);

%%% Инициализация сети

net.inputWeights{1, 1}.initFcn = 'rands';
net.biases{1}.initFcn = 'rands';

net = init(net);

IW = net.IW{1, 1};
b = net.b{1};

M1 = sqrt(mse(PM - net(PM)));

%%% Модификация векторов в последовательности элементов

Pi = con2seq(Pi); % начальные 5 точек
PM = con2seq(PM); % следующие точки
P = con2seq(P); % общий набор

% адаптация (настройка весов)
net.adaptParam.passes = 100;
% обученная сеть, выход сети, погрешность 
% - 
% сеть, входные данные, выходные данные, нач знач
[net, Y, E] = adapt(net, PM, PM, Pi);

Y = sim(net, P, Pi);

Y = seq2con(Y); Y = Y{1};
P = seq2con(P); P = P{1};
E = Y - P;

M2 = sqrt(mse(Y - P)); 

% как на графике

figure;

subplot(211);
plot(t1, P, 'b', t1, Y, 'r--'); grid;

subplot(212);
plot(t1, E, 'g'); grid;
