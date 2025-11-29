% Inisialisasi parameter
a = 0; b = 2*pi;
c = 0; d = 2*pi;
h = 0.1;
t = 3;              % metode beda hingga (pusat)
var = 'x';          % bisa diganti 'y' untuk ∂f/∂y
f = @(x, y) sin(x).*cos(y);  % fungsi dua variabel

% Turunan eksak (untuk membandingkan)
if var == 'x'
    df_eksak = @(x, y) cos(x).*cos(y);
else
    df_eksak = @(x, y) -sin(x).*sin(y);
end

[x, y] = meshgrid(a:h:b, c:h:d);  % grid x-y
nawal = 2;
nakhir = 70;
k = 1;

for n = nawal:2:nakhir
    dfnum = zeros(size(x));
    dfexact = df_eksak(x, y);
    
    for i = 1:size(x,1)
        for j = 1:size(x,2)
            [dfnum(i,j), ~] = turunan(f, x(i,j), y(i,j), n, h, t, var);
        end
    end
    
    galat(k) = log10(norm(dfexact - dfnum, 'fro'));  % galat Frobenius norm
    k = k + 1;
end

% Plot kurva galat
figure (3)
plot(nawal:2:nakhir, galat, 'ko-');
title(['Kurva Galat terhadap Orde Ketelitian n (∂f/∂' var ')']);
xlabel('n');
ylabel('log_{10}(Galat)');
xlim([nawal nakhir]);
grid on;
