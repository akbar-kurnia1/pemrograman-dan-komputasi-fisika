% Prediksi angka pengangguran di Indonesia berdasarkan faktor kependudukan
% pendidikan, dan ekonomi menggunakan metode ekstrapolasi
tahun = [2014 2015 2016 2017 2018 2019 2020 2021 2022 2023];
pengangguran = [5.3 5.3 5.2 5.1 5.3 5.3 7.0 6.2 5.7 4.9];
pendidikan = [50 51 52 53 54 55 56 57 58 59];
ekonomi = [5.0 4.9 5.0 5.1 5.2 5.3 2.1 3.7 5.0 5.5];

norm_pendidikan = (pendidikan - min(pendidikan)) / (max(pendidikan) - min(pendidikan));
norm_ekonomi = (ekonomi - min(ekonomi)) / (max(ekonomi) - min(ekonomi));

faktor = (norm_pendidikan * 0.6 + norm_ekonomi * 0.4);

p_trend_faktor = polyfit(tahun, faktor, 1);
faktor_prediksi = polyval(p_trend_faktor, [2024 2025 2026]);

p = polyfit(faktor, pengangguran, 1);
pengangguran_prediksi = polyval(p, faktor_prediksi);

figure;
plot(tahun, pengangguran, 'b-o', 'LineWidth', 1.5, 'DisplayName', 'Data Historis');
hold on;
plot([2024 2025 2026], pengangguran_prediksi, 'r-o', 'LineWidth', 1.5, 'DisplayName', 'Prediksi');
title('Prediksi Pengangguran');
xlabel('Tahun');
ylabel('Tingkat Pengangguran (%)');
legend('show');
grid on;