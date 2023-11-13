clear all;
close all;

x =  @ (t) cos(cos(t).*t.^2 - t);
y = @ (t) 0.2 .* cos(cos(t).*t.^2 - t + pi);

t1 = 1:0.01:4.5;

P = x(t1);

plot(t1, P, '.-'); grid;

P1 = zeros(4, size(P, 1));

for i = 1:3
    P2(i) = 0;
end

for i = 1:size(P, 2)
    P2(i + 3) = P(i);
end

for i = 1:4
    P3(i, 1:size(P, 2)) = P2(i:size(P, 2) + i - 1);
end

% оценка шума среднеквадратическая
T = y(t1);

T = con2seq(T);
P = con2seq(P3);

% настраивает веса при помощи
% псевдо-инверсного правила
net = newlind(P, T);

Y = net(P);

Y = seq2con(Y); Y = Y{1};
T = seq2con(T); T = T{1};

M3 = sqrt(mse(T - Y));

figure;
plot(t1, T, 'b', t1, Y, 'r--'); grid;
