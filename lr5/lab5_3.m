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

IW = [p1; p2; p3];
b1 = [n*m; n*m; n*m];
epsilon = 1/2;
Q = 3;
LW = zeros([Q,Q]);


for i = 1:Q
    for j = 1:Q
        LW(i,j) = -epsilon;
        if i == j
            LW(i,j) = 1;
        else

        end
    end
end

T = [p1; p2; p3]';

a1 = IW*T + [b1, b1, b1];

net = newhop(a1);
net.layers{1}.transferFcn = 'poslin';

net.LW{1, 1} = LW;
net.b{1} = [0; 0; 0];

display(net);
view(net);

Ai = IW*T + [b1, b1, b1];
epochs = 600;
[Y] = sim(net, 3, [], Ai);
for i = 1:epochs
    [Y] = sim(net, 3, [], Y);
end
Y = Y(:,1);

if not(Y(1) == 0)
    X = X2;
else
    if not(Y(2) == 0)
        X = X1;
    else
        if not(Y(3) == 0)
            X = X4;
        else
            return;
        end
    end
end

print_image(X, map);

p = rand(n, m);
nd = 0.2;
nd1 = 0.3;

X11 = noise(X1, n, m, p, nd);
X41 = noise(X4, n, m, p, nd1);

print_image(X11, map);
print_image(X41, map);

p11 = to_vector(X2);
p21 = to_vector(X11);
p31 = to_vector(X41);

IW = [p1; p2; p3];
Ai1 = IW * [p11; p21; p31]' + [b1, b1, b1];

epochs = 600;

[D] = sim(net, 3, [], Ai1);
for i = 1:epochs
    [D] = sim(net, 3, [], D);
end

Y0 = D(:,2);

if not(Y0(1) == 0)
    X = X2;
else
    if not(Y0(2) == 0)
        X = X1;
    else
        if not(Y0(3) == 0)
            X = X4;
        else
            return;
        end
    end
end

print_image(X, map);

Y4 = D(:,3);

if not(Y4(1) == 0)
    X = X2;
else
    if not(Y4(2) == 0)
        X = X1;
    else
        if not(Y4(3) == 0)
            X = X4;
        else
            return;
        end
    end
end

print_image(X, map);








function print_image(img, map)
    figure;
    image(img);
    colormap(map);
    axis off;
    axis image;
end

function image = to_image(vect, n, m)

vect = reshape(vect, [n, m]);

for i = 1 : size(vect, 1)
    for j = 1 : size(vect, 2)
        if vect(i, j) == 1
            vect(i, j) = 2;
        else
            vect(i, j) = 1;
        end
    end
end

image = vect;

end

function vector = to_vector(image)

for i = 1 : size(image, 1)
    for j = 1 : size(image, 2)
        if image(i, j) == 1
            image(i, j) = -1;
        else
            image(i, j) = 1;
        end
    end
end

vector = image(:)';

end

function noisy_image = noise(image, n, m, noise_vector, nd)

for i = 1 : n
    for j = 1 : m
        if noise_vector(i, j) < nd
            if image(i, j) == 1
                image(i, j) = 2;
            else
                image(i, j) = 1;
            end
        else
            image(i, j) = image(i, j);
        end
    end
end

noisy_image = image;

end

