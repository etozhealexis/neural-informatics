clear;
close all;

n = 12;
m = 10;

map = [0, 0, 1; 1, 1, 1];

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


print_image(X1, map);
print_image(X4, map);
print_image(X2, map);

p1 = to_vector(X1); 
p2 = to_vector(X4); 
p3 = to_vector(X2); 

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
nd2 = 0.4;

X11 = noise(X1, n, m, p, nd);
X41 = noise(X4, n, m, p, nd1);
X21 = noise(X2, n, m, p, nd2);

print_image(X11, map);
print_image(X41, map);
print_image(X21, map);

p11 = to_vector(X11);
p21 = to_vector(X41);
p31 = to_vector(X21);

Ai = [p11; p21; p31]';

epochs = 600;

[Y] = sim(net, 3, [], Ai);
for i = 1:epochs
    [Y] = sim(net, 3, [], Y);
end

Y1 = Y(:,1);

T1 = to_image(Y1, n, m);
print_image(T1, map);

Y4 = Y(:,2);

T4 = to_image(Y4, n, m);
print_image(T4, map);

Y2 = Y(:,3);

T2 = to_image(Y2, n, m);
print_image(T2, map);





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