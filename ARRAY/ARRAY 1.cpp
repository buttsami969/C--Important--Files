#include <iostream>
using namespace std;

int main()
{
    int i, n;
    float arr[10];

    cout << "Enter total number of elements(1 to 10): ";
    cin >> n;
    cout << endl;
    for(i = 0; i < n; ++i)
    {
       cout << "Enter Number " << i + 1 << " : ";
       cin >> arr[i];
    }

    for(i = 1;i < n; ++i)
    {
    
       if(arr[0] < arr[i])
           arr[0] = arr[i];
    }
    cout << "Largest element = " << arr[0];

    return 0;
}
