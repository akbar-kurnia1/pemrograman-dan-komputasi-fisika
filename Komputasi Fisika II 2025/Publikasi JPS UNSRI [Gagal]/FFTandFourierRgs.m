clc; clear; close all;

% Import historical wind speed data
wind_speed = [11.0, 11.0, 11.0, 2.08, 1.66, 1.79, 2.40, 2.42, 4.97, 2.20, 1.90, 5.0, ...
              3.20, 3.90, 3.20, 3.00, 2.60, 2.10, 2.50, 2.70, 2.90, 3.00, 2.60, 1.80, ...
              2.70, 3.40, 2.70, 1.40, 1.20, 1.90, 2.00, 2.70, 3.70, 2.80, 1.30, 1.50]; 

year_start = 2021;  % Start year of historical data
months_per_year = 12; % 12 months in a year
total_years = 6; % From 2021 to 2026

t = (1:length(wind_speed))'; % Time in months

% Fourier regression
N = 2;  % Fourier order
omega = 2 * pi / months_per_year; % Fundamental frequency (1 cycle per 12 months)

% Fourier design matrix
X = ones(length(t), 2*N + 1);
for n = 1:N
    X(:, 2*n) = cos(n * omega * t);
    X(:, 2*n + 1) = sin(n * omega * t);
end

% Least squares regression to obtain coefficients
coeffs = X \ wind_speed';  

% Prediction for the next 3 years
t_pred = (length(wind_speed)+1:length(wind_speed)+36)'; % 36 months ahead
X_pred = ones(length(t_pred), 2*N + 1);
for n = 1:N
    X_pred(:, 2*n) = cos(n * omega * t_pred);
    X_pred(:, 2*n + 1) = sin(n * omega * t_pred);
end

wind_pred = X_pred * coeffs;  % Prediction using Fourier model

% Frequency analysis using FFT
Fs = 1; % Sampling rate: 1 sample per month
L = length(wind_speed); % Length of historical data
Y = fft(wind_speed); % FFT of historical data
P2 = abs(Y/L); % Two-sided spectrum
P1 = P2(1:floor(L/2)+1); % One-sided spectrum
P1(2:end-1) = 2*P1(2:end-1); % Correction for one-sided spectrum

f = Fs*(0:(floor(L/2)))/L; % Frequency in cycles per month

% Plot prediction graph
figure;
hold on;
plot(t, wind_speed, 'b.-', 'LineWidth', 1.5, 'DisplayName', 'Historical Data');
plot(t_pred, wind_pred, 'g.-', 'LineWidth', 1.5, 'DisplayName', 'Prediction (Fourier Regression)');

% Add vertical lines as year indicators
for year = 1:total_years-1
    xline(year * months_per_year, '--k', [' ' num2str(year_start + year)], ...
        'LineWidth', 1, 'LabelHorizontalAlignment', 'center', 'LabelVerticalAlignment', 'middle');
end

% Modify x-axis to display months 1-12 repeatedly
xticks(1:months_per_year*total_years);
xticklabels(repmat(string(1:months_per_year), 1, total_years));

legend;
xlabel('Month');
ylabel('Wind Speed (knots)');
title('Wind Speed Prediction using Fourier Regression');
grid on;
hold off;

% Plot frequency spectrum graph
figure;
stem(f, P1, 'r', 'LineWidth', 1.5); 
xlabel('Frequency (cycles per month)');
ylabel('|P1(f)|');
title('Frequency Spectrum of Wind Speed Data (FFT)');
grid on;

% Output prediction table in command window
predicted_years = repelem(2024:2026, months_per_year);
predicted_months = repmat(1:months_per_year, 1, 3);
prediction_table = table(predicted_years(:), predicted_months(:), wind_pred(:), ...
    'VariableNames', {'Year', 'Month', 'Wind_Speed'});

disp('Wind Speed Prediction (knots) for 2024-2026:');
disp(prediction_table);