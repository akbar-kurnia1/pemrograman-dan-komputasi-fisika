//Nama: Akbar Kurniawan
//NIM: 08021282328046
//MatKul: Pengantar Pemrograman (UAS)
#include <iostream>
#include <cmath>
using namespace std;

double hitungWaktu(double t_aksen, double v) {
    double c = 1.0;
    if (v > c) {
        return -1;
    }
    return t_aksen * sqrt(1 - (v * v) / (c * c));
}

void hitungWaktuVBerulang(double t_aksen) {
    double c = 1.0;
    const int num_values = 11; 
    double v_values[num_values]; 
    for (int i = 0; i < num_values; ++i) {
        v_values[i] = i / 10.0;
    }

    cout << "\nNilai t untuk berbagai nilai v dari 0 hingga 1 (dalam selang 0.1):" << endl;
    for (int i = 0; i < num_values; ++i) {
        double v = v_values[i];
        if (abs(v - 1.0) < 1e-6) {
            double t = 0.0; 
            cout << "v = " << v << ", t = " << t << " tahun" << endl;
        } else {
            double t = hitungWaktu(t_aksen, v);
            
            if (t == -1) {
                cout << "v = " << v << ", t = Error (v > c)." << endl;
            } else {
                cout << "v = " << v << ", t = " << t << " tahun" << endl;
            }
        }
    }
}

int main() {
    cout << "Program ini digunakan untuk menghitung waktu tempuh (t) yang dirasakan oleh\n"
         << "astronot berdasarkan jarak dari planet Bumi menuju suatu tempat seperti planet\n"
         << "atau galaksi dalam satuan tahun cahaya (t') dan kecepatan relatif pesawat (v).\n"
         << endl;
    cout << "Rumus yang digunakan adalah rumus dilatasi waktu: \n"
         << "t = t' x akar(1 - (v^2 / c^2))\n"
         << endl;
    cout << "dengan:" << endl;
    cout << "t   : Waktu yang dirasakan oleh astronot (tahun)" << endl;
    cout << "t'  : Waktu yang dirasakan oleh pengamat (sama dengan jarak dalam tahun cahaya)" << endl;
    cout << "v   : Kecepatan relatif pesawat terhadap kecepatan cahaya (c)" << endl;
    cout << "c   : Kecepatan cahaya (1)" << endl;
    cout << endl;

    int menu;
    cout << "Pilihan Menu:" << endl;
    cout << "1. Hitung Waktu Tempuh (t) berdasarkan jarak tempuh (t')" << endl;
    cout << "2. Cetak nilai t untuk berbagai nilai v dari 0 hingga 1 (dalam selang 0.1)\n" << endl;
    cout << "Pilih menu (1 atau 2): ";
    cin >> menu;

    switch (menu) {
        case 1: {
            double t_aksen;
            cout << "Masukkan nilai jarak t' (dalam tahun cahaya): ";
            cin >> t_aksen;

            double v;
            cout << "Masukkan nilai kecepatan relatif pesawat (c): ";
            cin >> v;

            double t = hitungWaktu(t_aksen, v);
            if (t == -1) {
                cout << "\nKecepatan tidak boleh melebihi kecepatan cahaya." << endl;
            } else {
                cout << "\nWaktu tempuh yang dirasakan oleh astronot (t) adalah: " << t << " tahun." << endl;
            }
            break;
        }
        case 2: {
            double t_aksen;
            cout << "Masukkan nilai jarak t' (dalam tahun cahaya): ";
            cin >> t_aksen;

            hitungWaktuVBerulang(t_aksen);
            break;
        }
        default:
            cout << "Pilihan menu tidak valid." << endl;
            break;
    }
    return 0;
}
