close all;
clear all;

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

% gr = plot(x1, y1, x2, y2, x3, y3);
% 
% set(gr(1), 'LineStyle', '-', 'Color', 'r', 'LineWidth', 2);
% set(gr(2), 'LineStyle', '-', 'Color', 'g', 'LineWidth', 2);
% set(gr(3), 'LineStyle', '-', 'Color', 'b', 'LineWidth', 2);

k = size(t, 2);

p1 = randperm(k, 60);
p2 = randperm(k, 100);
p3 = randperm(k, 120);

X1 = x1(p1);
X2 = x2(p2);
X3 = x3(p3);

Y1 = y1(p1);
Y2 = y2(p2);
Y3 = y3(p3);

gr = plot(x1, y1, x2, y2, x3, y3, X1, Y1, X2, Y2, X3, Y3);

% set(gr(1), 'LineStyle', '-', 'Color', 'r', 'LineWidth', 2);
% set(gr(2), 'LineStyle', '-', 'Color', 'g', 'LineWidth', 2);
% set(gr(3), 'LineStyle', '-', 'Color', 'b', 'LineWidth', 2);
% set(gr(4), 'LineStyle', 'none', 'Marker', 'o', 'Color', 'r', 'MarkerEdgeColor', 'b', 'MarkerFaceColor', 'c', 'MarkerSize', 5);
% set(gr(5), 'LineStyle', 'none', 'Marker', 'o', 'Color', 'g', 'MarkerEdgeColor', 'b', 'MarkerFaceColor', 'c', 'MarkerSize', 5);
% set(gr(6), 'LineStyle', 'none', 'Marker', 'o', 'Color', 'b', 'MarkerEdgeColor', 'b', 'MarkerFaceColor', 'c', 'MarkerSize', 5);

[trainInd1, testInd1] = dividerand(60, 0.8, 0.2);
[trainInd2, testInd2] = dividerand(100, 0.8, 0.2);
[trainInd3, testInd3] = dividerand(120, 0.8, 0.2);

train1X = X1(trainInd1);
train1Y = Y1(trainInd1);

train2X = X2(trainInd2);
train2Y = Y2(trainInd2);

train3X = X3(trainInd3);
train3Y = Y3(trainInd3);

for i = 1:size(train1X,2)
    train1t(i) = 1;
end;
for i = 1:size(train2X,2)
    train2t(i) = 2;
end;

for i = 1:size(train3X,2)
    train3t(i) = 3;
end;

test1X = X1(testInd1);
test1Y = Y1(testInd1);

test2X = X2(testInd2);
test2Y = Y2(testInd2);

test3X = X3(testInd3);
test3Y = Y3(testInd3);

for i = 1:size(test1X, 2)
    test1t(i) = 1;
end;

for i = 1:size(test2X, 2)
    test2t(i) = 2;
end;

for i = 1:size(test3X, 2)
    test3t(i) = 3;
end;

axis([-1.2 1.2 -1.2 1.2]);

gr = plot(x1, y1, x2, y2, x3, y3,train1X,train1Y,train2X,train2Y,train3X,train3Y,test1X,test1Y,test2X,test2Y,test3X,test3Y);
grid;

set(gr(1), 'LineStyle', '-', 'Color', 'r', 'LineWidth', 2);
set(gr(2), 'LineStyle', '-', 'Color', 'g', 'LineWidth', 2);
set(gr(3), 'LineStyle', '-', 'Color', 'b', 'LineWidth', 2);
set(gr(4), 'LineStyle', 'none', 'Marker', 'o', 'Color', 'r', 'MarkerEdgeColor', 'b', 'MarkerFaceColor', 'c', 'MarkerSize', 5);
set(gr(5), 'LineStyle', 'none', 'Marker', 'o', 'Color', 'g', 'MarkerEdgeColor', 'b', 'MarkerFaceColor', 'c', 'MarkerSize', 5);
set(gr(6), 'LineStyle', 'none', 'Marker', 'o', 'Color', 'b', 'MarkerEdgeColor', 'b', 'MarkerFaceColor', 'c', 'MarkerSize', 5);
set(gr(7), 'LineStyle', 'none', 'Marker', 'v','Color', 'r', 'MarkerEdgeColor','k', 'MarkerFaceColor', 'r','MarkerSize',5);
set(gr(8), 'LineStyle', 'none', 'Marker', 'v','Color', 'g', 'MarkerEdgeColor','k', 'MarkerFaceColor', 'g','MarkerSize',5);
set(gr(9), 'LineStyle', 'none', 'Marker', 'v','Color', 'b', 'MarkerEdgeColor','k', 'MarkerFaceColor', 'b','MarkerSize',5);

%обучающее
trainX = [train1X, train2X, train3X];
trainY = [train1Y, train2Y, train3Y];
%тестовое
testX = [test1X, test2X, test3X];
testY = [test1Y, test2Y, test3Y];
%выходное 
traint = [train1t, train2t, train3t];
testt = [test1t, test2t, test3t];

spread = 0.3;
%предельное значение критерия обучения 
goal = 1E-5;

net = newrb([trainX;trainY], traint, goal);

display(net);

% view(net);
%выход, округленные значения к какому классу принадежит точка
Y = round(sim(net, [trainX; trainY]));

Z = abs(Y-traint);

N = size(traint, 2);

p = 0;

for i=1:N
    if not(Z(i)==0)
        p=p+1;
    end;
end;
% здесь процент
probtrain = ((N-p)/N)*100

Y1 = round(sim(net, [testX; testY]));

Z1 = abs(Y1-testt);

N1 = size(testt, 2);

p = 0;

for i=1:N1
    if not(Z1(i)==0)
        p=p+1;
    end;
end;
% здесь процент
probtest = ((N1-p)/N1)*100

xs=-1.2:0.025:1.2;
ys=-1.2:0.025:1.2;

for i=1:size(xs,2)
    for j=1:size(xs,2)
        Xs(i,j)=xs(i);
        Ys(i,j)=ys(j);
    end;
end;

X=[];
for i=1:size(xs,2)
    X=[X,Xs(i,:)];
end;

Y=[];
for i=1:size(xs,2)
    Y=[Y,Ys(i,:)];
end; 

%Загоняем Х,У во входное множество
Pp=[X;Y];

%Прогоняем сеть на множестве всех точек плоскости
Zz=round(sim(net,Pp));

%формирование первого подмножества
xa1=[];
ya1=[];

for i=1:size(Zz,2)
    if Zz(i)==1
        xa1=[xa1,X(i)];
        ya1=[ya1,Y(i)];
    end;
end;

%формирование второго подмножества
xa2=[];
ya2=[];

for i=1:size(Zz,2)
    if Zz(i)==2
        xa2=[xa2,X(i)];
        ya2=[ya2,Y(i)];
    end;
end;

%формирование третьего подмножества
xa3=[];
ya3=[];

for i=1:size(Zz,2)
    if Zz(i)==3
        xa3=[xa3,X(i)];
        ya3=[ya3,Y(i)];
    end;
end;

figure;

gr2=plot(xa1,ya1,xa2,ya2,xa3,ya3,x1,y1,x2,y2,x3,y3); grid;

set(gr2(1), 'LineStyle', 'none', 'Marker', 'o', 'Color', 'r', 'MarkerEdgeColor', 'r', 'MarkerFaceColor', 'r', 'MarkerSize', 5);
set(gr2(2), 'LineStyle', 'none', 'Marker', 'o', 'Color', 'g', 'MarkerEdgeColor', 'g', 'MarkerFaceColor', 'g', 'MarkerSize', 5);
set(gr2(3), 'LineStyle', 'none', 'Marker', 'o', 'Color', 'b', 'MarkerEdgeColor', 'b', 'MarkerFaceColor', 'b', 'MarkerSize', 5);
set(gr2(4), 'LineStyle', '-', 'Color', 'r', 'LineWidth', 2);
set(gr2(5), 'LineStyle', '-', 'Color', 'g', 'LineWidth', 2);
set(gr2(6), 'LineStyle', '-', 'Color', 'b', 'LineWidth', 2);
