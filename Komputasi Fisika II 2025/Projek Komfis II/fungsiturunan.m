function fungsiturunan(f, a, b, c, d, n, h, t, var)
% Visualisasi turunan parsial fungsi f(x, y)
% f: fungsi dua variabel @(x,y)
% [a,b] untuk x-range, [c,d] untuk y-range
% n: orde, h: langkah, t: metode (1=maju,2=mundur,3=pusat)
% var: 'x' atau 'y' untuk memilih turunan parsial

[x, y] = meshgrid(a:h:b, c:h:d);
df = zeros(size(x));

for i = 1:size(x,1)
    for j = 1:size(x,2)
        [df(i,j), ~] = turunan(f, x(i,j), y(i,j), n, h, t, var);
    end
end

% Gambar grafik permukaan
figure(2)
surf(x, y, df);
xlabel('x'); ylabel('y');
if var == 'x'
    zlabel('df/dx');
    title('Turunan Parsial terhadap x');
else
    zlabel('df/dy');
    title('Turunan Parsial terhadap y');
end
shading interp; colorbar;
end
