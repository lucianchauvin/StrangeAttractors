#include <iostream>
#include <fstream>
#include <cmath>
#include <chrono>

using namespace std;

bool conv(double x, double y, double z) {
    for (long i = 0; i < 100; i++) {
        double dx = (-1.4*x)-(4*y)-(4*z)-(y*y);
        double dy = -(4*x)-(1.4*y)-(4*z)-(z*z);
        double dz = -(4*x)-(4*y)-(1.4*z)-(x*x);

        x += dx*.005;
        y += dy*.005;
        z += dz*.005;
    }
    // cout << x << " " << y << " " << z << endl;
    if (isnan(x) || isnan(y) || isnan(z)) {
        return false;
    }
    return true;
}

int main () {
    ofstream f ("out.txt");

    auto start = chrono::high_resolution_clock::now();
    for (double x = -100; x < 100; x += .5) {
        for (double y = -100; y < 100; y += .5) {
            for (double z = -100; z < 100; z += .5) {
                if (conv(x, y, z)) {
                    f << x << " " << y << " " << z << endl;
                }
            }
        }
    }
    auto stop = chrono::high_resolution_clock::now();
    auto duration = chrono::duration_cast<chrono::seconds>(stop - start);
    cout << "Time taken by function: " << duration.count() << " seconds" << endl;
    cout << "Count: " << count << endl;

    f.close();

    return 0;
}   