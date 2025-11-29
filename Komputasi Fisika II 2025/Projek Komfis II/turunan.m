function [df0, g] = turunan(f, x0, y0, n, h, t, var)
% Menghitung turunan parsial pertama dari fungsi dua variabel f(x, y)
% di titik (x0, y0) dengan metode beda hingga:
% t = 1 (maju), t = 2 (mundur), t = 3 (pusat)
% var = 'x' untuk ∂f/∂x, var = 'y' untuk ∂f/∂y
%
% df0 = hasil turunan
% g   = vektor koefisien beda hingga

    if t == 1 || t == 2
        g0 = 0;
        for j = 1:n
            g0 = g0 + 1/j;
        end
        g0 = -g0;

        for k = 1:n
            g(k) = (-1)^(k+1)*factorial(n)/(k*factorial(n-k)*factorial(k));
        end

        if t == 1  % Maju
            xn = x0 + n*h;
            yn = y0 + n*h;
            if var == 'x'
                x = [x0:h:xn]'; y = y0 * ones(size(x));
            else
                y = [y0:h:yn]'; x = x0 * ones(size(y));
            end
            yval = 0;
            for k = 1:n
                yval = yval + g(k)*f(x(k+1), y(k+1));
            end
            df0 = (g0*f(x(1), y(1)) + yval)/h;
            g = [g0 g];

        elseif t == 2  % Mundur
            g = -g;
            xn = x0 - n*h;
            yn = y0 - n*h;
            if var == 'x'
                x = [x0:-h:xn]'; y = y0 * ones(size(x));
            else
                y = [y0:-h:yn]'; x = x0 * ones(size(y));
            end
            yval = 0;
            for k = 1:n
                yval = yval + g(k)*f(x(k+1), y(k+1));
            end
            df0 = (-g0*f(x(1), y(1)) + yval)/h;
            g = [g(end:-1:1) -g0];
        end

    elseif t == 3  % Pusat
        if mod(n,2) ~= 0
            error('Orde keakuratan beda pusat harus genap.');
        end
        n2 = n/2;
        g = zeros(1, 2*n2+1);
        for k = -n2:n2
            if k == 0
                g(n2+1) = 0;
            else
                g(k+n2+1) = (-1)^(k+1)*factorial(n2)^2 / (k*factorial(n2-k)*factorial(n2+k));
            end
        end

        % Buat grid titik evaluasi
        if var == 'x'
            x = (x0 - n2*h : h : x0 + n2*h)'; y = y0 * ones(size(x));
        else
            y = (y0 - n2*h : h : y0 + n2*h)'; x = x0 * ones(size(y));
        end

        yval = 0;
        for k = 1:length(g)
            yval = yval + g(k)*f(x(k), y(k));
        end
        df0 = yval / h;
    end
end
