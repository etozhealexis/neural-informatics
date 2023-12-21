clear;
close all;

n = 12;
m = 10;

map = [0, 0, 0; 1, 1, 1];

X1 = [2 2 2  1 1 1 1  2 2 2;
      2 2 2  1 1 1 1  2 2 2;
      2 2 2  1 1 1 1  2 2 2;
      2 2 2  1 1 1 1  2 2 2;
      2 2 2  1 1 1 1  2 2 2;
      2 2 2  1 1 1 1  2 2 2;
      2 2 2  1 1 1 1  2 2 2;
      2 2 2  1 1 1 1  2 2 2;
      2 2 2  1 1 1 1  2 2 2;
      2 2 2  1 1 1 1  2 2 2;
      2 2 2  1 1 1 1  2 2 2;
      2 2 2  1 1 1 1  2 2 2];

X4 = [2  1 1   2 2 2 2  1 1  2;
      2  1 1   2 2 2 2  1 1  2;
      2  1 1   2 2 2 2  1 1  2;
      2  1 1   2 2 2 2  1 1  2;
      2  1 1   2 2 2 2  1 1  2;
      2  1  1  1  1  1   1  1 1  2;
      2  1  1  1  1  1   1  1 1  2;
      2 2 2 2 2 2 2   1 1  2;
      2 2 2 2 2 2 2   1 1  2;
      2 2 2 2 2 2 2   1 1  2;
      2 2 2 2 2 2 2   1 1  2;
      2 2 2 2 2 2 2   1 1  2];

X2 = [1 1 1 1 1 1  1 1  2 2;
      1 1 1 1 1 1  1 1  2 2;
      2 2 2 2 2 2  1 1  2 2;
      2 2 2 2 2 2  1 1  2 2;
      2 2 2 2 2 2  1 1  2 2;
      1 1 1 1 1 1  1 1  2 2;
      1 1 1 1 1 1  1 1  2 2;
      1 1   2 2 2 2 2 2 2 2;
      1 1   2 2 2 2 2 2 2 2;
      1 1   2 2 2 2 2 2 2 2;
      1 1 1 1 1 1  1 1  2 2;
      1 1 1 1 1 1  1 1  2 2];


print_image(X2, map);
print_image(X1, map);
print_image(X4, map);

p1 = to_vector(X2); 
p2 = to_vector(X1); 
p3 = to_vector(X4); 

T = [p1; p2; p3]';
net = newhop(T);

display(net);
view(net);

net = init(net);

Ai = T;
Y = sim(net, 3, [], Ai);
Y = Y(:, 1);

T1 = to_image(Y, n, m);
print_image(T1, map);

p = rand(n, m);

nd = 0.2;
nd1 = 0.3;

X21 = noise(X2, n, m, p, nd);
X11 = noise(X1, n, m, p, nd);
X41 = noise(X4, n, m, p, nd1);

print_image(X11, map);
print_image(X41, map);

p11 = to_vector(X21);
p21 = to_vector(X11);
p31 = to_vector(X41);

Ai = [p11; p21; p31]';

epochs = 600;

[Y] = sim(net, 3, [], Ai);
for i = 1:epochs
    [Y] = sim(net, 3, [], Y);
end

Y1 = Y(:,2);

T1 = to_image(Y1, n, m);
print_image(T1, map);

Y4 = Y(:,3);

T1 = to_image(Y4, n, m);
print_image(T1, map);