#include <iostream>
#include <windows.h>
#include <cmath>
using namespace std;
int main() {
    SetConsoleOutputCP(CP_UTF8);
    float k = 0.5;
    float matrix[ 2 ][ 10 ];
    cout << "Данная программа вычислит радиус основания цилиндра единичного объёма для различных h." << endl;
    for ( int i = 0; i < 10; i++ ) {
        matrix[ 0 ][ i ] = k;
        k += 0.5;
    }
    for ( int i = 0; i < 10; i++ ) {
        matrix[ 1 ][ i ] = sqrt(1 / ( M_PI * matrix[ 0 ][ i ] ) );
    }
    cout << "H          R" << endl;
    for ( int i = 0; i < 10; i++ ) {
            cout << matrix[ 0 ][ i ] << "    " << matrix[ 1 ][ i ] << endl;
    }
    return 0;
}
