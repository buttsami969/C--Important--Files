// Inverted half pyramid using numbers*
 #include <iostream>
using namespace std;

int main()
{
    int j,k,l;

    cout << "ENTER NUMBERS OF ROWS: ";
    cin >> j;

    for(k=j; k>= 1; --k)
    {
        for( l= 1; l <= k; ++l)
        {
            cout << l << " ";
        }
        cout << endl;
    }

    return 0;
}

